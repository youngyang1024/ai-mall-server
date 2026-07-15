<template>
  <div class="page-shell" :class="shellClass">
    <van-nav-bar
      v-if="isMobile && title"
      class="mobile-nav"
      :title="title"
      :left-arrow="showBack"
      :fixed="fixed"
      @click-left="handleBack"
    />
    <div v-if="!isMobile && title" class="pc-page-title">{{ title }}</div>
    <div class="page-shell__body" :class="bodyClass" :style="bodyStyle">
      <slot />
    </div>
  </div>
</template>

<script>
export default {
  name: 'PageShell',
  props: {
    title: {
      type: String,
      default: ''
    },
    showBack: {
      type: Boolean,
      default: false
    },
    fixed: {
      type: Boolean,
      default: true
    },
    withTabbarSpace: {
      type: Boolean,
      default: false
    },
    narrow: {
      type: Boolean,
      default: false
    },
    fullWidth: {
      type: Boolean,
      default: false
    }
  },
  computed: {
    shellClass() {
      return {
        'page-shell--narrow': this.narrow
      }
    },
    bodyClass() {
      return {
        'page-shell__body--tabbar': this.isMobile && this.withTabbarSpace,
        'page-shell__body--full': this.fullWidth
      }
    },
    bodyStyle() {
      if (this.isMobile && this.title && this.fixed) {
        return { paddingTop: '46px' }
      }
      return {}
    }
  },
  methods: {
    handleBack() {
      if (this.$listeners.back) {
        this.$emit('back')
        return
      }
      this.$router.back()
    }
  }
}
</script>

<style scoped>
.page-shell {
  min-height: 100vh;
  background: #f5f5f5;
}
.page-shell--narrow .page-shell__body {
  max-width: 480px;
  margin: 0 auto;
}
.pc-page-title {
  max-width: 1200px;
  margin: 0 auto;
  padding: 24px 24px 0;
  font-size: 24px;
  font-weight: 600;
  color: #323233;
}
.page-shell__body {
  max-width: 1200px;
  margin: 0 auto;
  padding: 16px 16px 24px;
}
.page-shell__body--tabbar {
  padding-bottom: 60px;
}
.page-shell__body--full {
  max-width: none;
  padding: 0;
}
</style>
