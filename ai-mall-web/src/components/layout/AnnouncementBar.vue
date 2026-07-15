<template>
  <div class="announcement-bar">
    <div class="announcement-bar__text">
      全场满 ¥99 免运费 | 30天无理由退换 | 会员首单享9折
    </div>
  </div>
</template>

<script>
export default {
  name: 'AnnouncementBar'
}
</script>

<style scoped>
.announcement-bar {
  background-color: var(--color-primary);
  color: #fff;
  text-align: center;
  padding: 8px 16px;
  font-size: 12px;
  font-weight: 500;
  letter-spacing: 0.5px;
}
</style>
