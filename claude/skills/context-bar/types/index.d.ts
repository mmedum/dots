export type Segment = { name: string; tokens: number; color: string; isFree: boolean }
export type Fill = { segments: Segment[]; totalTokens: number; maxTokens: number; percentage: number }

declare module 'claude-code' {
  interface PluginState {
    'context-bar': { fill: Fill | null; isHidden: boolean }
  }
}
