export const MOBILE_BREAKPOINT = 768

export function isMobileViewport() {
  if (typeof window === 'undefined') {
    return true
  }
  return window.innerWidth < MOBILE_BREAKPOINT
}
