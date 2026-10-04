import { atom, read, update } from 'claude-code'
import type { EngineInterface, Register, SessionContextBreakdown } from 'claude-code'

import type { Fill, Segment } from '../types'

const fill = atom({ plugin: 'context-bar', key: 'fill' } as const, null)
const isHidden = atom({ plugin: 'context-bar', key: 'isHidden' } as const, false)

// Deferred tool schemas sit outside the window, so /context leaves them off its grid too.
export function toFill(breakdown: SessionContextBreakdown): Fill {
  const segments: Segment[] = breakdown.categories
    .filter(row => row.kind !== 'deferred' && row.tokens > 0)
    .map(row => ({ name: row.name, tokens: row.tokens, color: row.color, isFree: row.kind === 'free' }))

  return {
    segments,
    totalTokens: breakdown.totalTokens,
    maxTokens: breakdown.rawMaxTokens,
    percentage: breakdown.percentage,
  }
}

// Splits `width` cells across the segments by tokens (largest remainder), so the widths always sum to `width`.
export function cellWidths(segments: Segment[], width: number): number[] {
  const total = segments.reduce((sum, s) => sum + s.tokens, 0)
  if (total === 0 || width <= 0) return segments.map(() => 0)

  const exact = segments.map(s => (s.tokens / total) * width)
  const widths = exact.map(Math.floor)
  let left = width - widths.reduce((sum, w) => sum + w, 0)
  const byRemainder = exact.map((x, i) => ({ i, rest: x - Math.floor(x) })).sort((a, b) => b.rest - a.rest)
  for (const { i } of byRemainder) {
    if (left === 0) break
    widths[i] = (widths[i] ?? 0) + 1
    left -= 1
  }

  return widths
}

export function formatTokens(tokens: number): string {
  if (tokens >= 1_000_000) return `${(tokens / 1_000_000).toFixed(1)}M`
  if (tokens >= 1_000) return `${(tokens / 1_000).toFixed(1)}k`
  return String(tokens)
}

async function refresh($: EngineInterface) {
  // `summary` estimates locally and sends no token-count requests.
  const { context } = await $.session.usage({ breakdown: 'summary' })
  if (context.breakdown) await update($, fill, () => toFill(context.breakdown!))
}

export const register: Register = on => {
  on('session.start', async ($, e, next) => {
    await $.command.register({
      name: 'context-bar',
      description: 'Show or hide the context window bar above the prompt',
    })
    const ran = await next(e)
    await refresh($)

    return ran
  })

  on('session.measure', async ($, e, next) => {
    const ran = await next(e)
    if (e.changed.includes('context')) await refresh($)

    return ran
  })

  on('command.run', { command: 'context-bar' }, async $ => {
    const wasHidden = await read($, isHidden)
    await update($, isHidden, () => !wasHidden)
    if (wasHidden) await refresh($)

    return { text: wasHidden ? 'Context bar shown.' : 'Context bar hidden.' }
  })

  on('ui.render', { component: 'AbovePrompt' }, async ($, e, next) => {
    const current = await read($, fill)
    if (e.props.hasSurvey || current === null || (await read($, isHidden))) return next(e)

    // The band holds one tree. When a mod beneath draws there (Blast Radius's Proceed/Cancel
    // in a narrow terminal, say), it gets the band and the bar steps aside.
    const below = await next(e)
    if (below.type !== 'engine') return below

    const { Box, Text } = $.ui.resolve(e)
    const widths = cellWidths(current.segments, e.props.bodyColumns)

    return (
      <Box flexDirection="column">
        <Text wrap="truncate">
          {current.segments.map((segment, i) => (
            <Text key={segment.name} color={segment.color} dimColor={segment.isFree}>
              {(segment.isFree ? '░' : '█').repeat(widths[i] ?? 0)}
            </Text>
          ))}
        </Text>
        <Text wrap="truncate">
          <Text dimColor>
            {formatTokens(current.totalTokens)}/{formatTokens(current.maxTokens)} ({current.percentage}%){'  '}
          </Text>
          {current.segments
            .filter(segment => !segment.isFree)
            .map(segment => (
              <Text key={segment.name}>
                <Text color={segment.color}>■</Text>
                <Text dimColor> {segment.name} {formatTokens(segment.tokens)}  </Text>
              </Text>
            ))}
        </Text>
      </Box>
    )
  })
}
