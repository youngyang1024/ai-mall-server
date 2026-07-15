import { isMobileViewport } from '@/utils/device'

export default {
  data() {
    return {
      isMobile: isMobileViewport()
    }
  },
  mounted() {
    this._onResize = () => {
      this.isMobile = isMobileViewport()
    }
    window.addEventListener('resize', this._onResize)
  },
  beforeDestroy() {
    window.removeEventListener('resize', this._onResize)
  }
}
