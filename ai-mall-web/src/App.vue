<template>
  <div id="app" :class="appClass">
    <announcement-bar v-if="!isMobile" />
    <pc-header v-if="!isMobile" />
    <div class="app-body">
      <router-view />
    </div>
    <rich-footer v-if="!isMobile" />
    <mobile-tabbar v-if="isMobile && showTabbar" />
  </div>
</template>

<script>
import AnnouncementBar from '@/components/layout/AnnouncementBar.vue'
import PcHeader from '@/components/layout/PcHeader.vue'
import RichFooter from '@/components/layout/RichFooter.vue'
import MobileTabbar from '@/components/layout/MobileTabbar.vue'
import responsiveMixin from '@/mixins/responsive'

export default {
  name: 'App',
  components: { AnnouncementBar, PcHeader, RichFooter, MobileTabbar },
  mixins: [responsiveMixin],
  computed: {
    appClass() {
      return this.isMobile ? 'is-mobile' : 'is-pc'
    },
    showTabbar() {
      return !!this.$route.meta.tabbar
    }
  }
}
</script>

<style>
html, body, #app {
  height: 100%;
  margin: 0;
  background-color: #f5f5f5;
}
.app-body {
  min-height: calc(100vh - 112px);
}
.is-mobile .app-body {
  min-height: 100vh;
}
</style>
