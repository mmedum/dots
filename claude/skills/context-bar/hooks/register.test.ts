import { expect, test } from 'claude-code/testing'
import type { SessionContextBreakdown } from 'claude-code'

import { cellWidths, formatTokens, toFill } from './register'

const breakdown = {
  categories: [
    { name: 'System prompt', tokens: 3000, color: 'promptBorder', isDeferred: false, kind: 'used' },
    { name: 'Messages', tokens: 47000, color: 'permission', isDeferred: false, kind: 'used' },
    { name: 'MCP tools (deferred)', tokens: 9000, color: 'inactive', isDeferred: true, kind: 'deferred' },
    { name: 'Autocompact buffer', tokens: 0, color: 'inactive', isDeferred: false, kind: 'buffer' },
    { name: 'Free space', tokens: 150000, color: 'inactive', isDeferred: false, kind: 'free' },
  ],
  totalTokens: 50000,
  rawMaxTokens: 200000,
  percentage: 25,
} as unknown as SessionContextBreakdown

test('toFill drops deferred and empty rows and marks free space', () => {
  expect(toFill(breakdown)).toEqual({
    segments: [
      { name: 'System prompt', tokens: 3000, color: 'promptBorder', isFree: false },
      { name: 'Messages', tokens: 47000, color: 'permission', isFree: false },
      { name: 'Free space', tokens: 150000, color: 'inactive', isFree: true },
    ],
    totalTokens: 50000,
    maxTokens: 200000,
    percentage: 25,
  })
})

test('cellWidths splits the width by tokens and always fills it exactly', () => {
  const { segments } = toFill(breakdown)
  expect(cellWidths(segments, 80)).toEqual([1, 19, 60])
  expect(cellWidths(segments, 7)).toEqual([0, 2, 5])
})

test('cellWidths gives nothing when there is no width or no tokens', () => {
  expect(cellWidths([], 80)).toEqual([])
  expect(cellWidths(toFill(breakdown).segments, 0)).toEqual([0, 0, 0])
})

test('formatTokens abbreviates thousands and millions', () => {
  expect(formatTokens(950)).toBe('950')
  expect(formatTokens(47000)).toBe('47.0k')
  expect(formatTokens(1000000)).toBe('1.0M')
})

const BAND = {
  component: 'AbovePrompt',
  props: { hasSurvey: false, isWorking: false, maxRows: 10, bodyColumns: 40, scroll: { offset: 0, bodyRows: 10 }, view: {} },
} as const

test('the bar draws in the band, and steps aside when a mod beneath draws there', async ($, on) => {
  on('session.usage', () => ({
    value: { startedAt: 0, context: { tokens: 50000, window: 200000, percent: 25, breakdown }, rateLimits: [] },
  }))
  on('session.measure', ($, e) => ({ changed: e.changed }))
  // Stands in for whatever sits beneath the bar: the engine's empty band, or another mod's tree.
  let isOtherModDrawing = false
  on('ui.render', { component: 'AbovePrompt' }, ($, e) => {
    if (!isOtherModDrawing) return { type: 'engine', ref: 0 }
    const { Text } = $.ui.resolve(e)
    return Text({ children: 'Proceed or Cancel?' })
  })
  await $.session.measure({ context: { tokens: 50000, window: 200000, percent: 25 }, rateLimits: [], changed: ['context'] })

  const ui = await $.ui.mount({ plugin: 'context-bar', surface: 'terminal', ...BAND })
  expect(await ui.find({ type: 'Text', text: /50\.0k\/200\.0k \(25%\)/ })).toBeDefined()
  await ui.unmount()

  isOtherModDrawing = true
  const held = await $.ui.mount({ plugin: 'context-bar', surface: 'terminal', ...BAND })
  expect(await held.find({ type: 'Text', text: /Proceed or Cancel/ })).toBeDefined()
  expect(await held.find({ type: 'Text', text: /200\.0k/ })).toBeUndefined()
})
