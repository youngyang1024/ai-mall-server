<template>
  <div class="dashboard">
    <el-row :gutter="16" class="overview">
      <el-col :span="6" v-for="card in overviewCards" :key="card.label">
        <el-card shadow="hover">
          <div class="card-label">{{ card.label }}</div>
          <div class="card-value">{{ card.value }}</div>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="16" style="margin-top:16px">
      <el-col :span="14">
        <el-card>
          <div slot="header" class="chart-header">
            <span>销售趋势</span>
            <el-radio-group v-model="period" size="mini" @change="loadTrend">
              <el-radio-button :label="7">近7天</el-radio-button>
              <el-radio-button :label="30">近30天</el-radio-button>
            </el-radio-group>
          </div>
          <div ref="trendChart" class="chart" />
        </el-card>
      </el-col>
      <el-col :span="10">
        <el-card>
          <div slot="header">订单状态分布</div>
          <div ref="pieChart" class="chart" />
        </el-card>
      </el-col>
    </el-row>

    <el-row style="margin-top:16px">
      <el-col :span="24">
        <el-card>
          <div slot="header">商品销量 TOP10</div>
          <div ref="rankChart" class="chart" />
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import * as echarts from 'echarts'
import { getDashboardOverview, getSalesTrend, getProductRank, getOrderStatus } from '@/api/dashboard'

export default {
  name: 'Home',
  data() {
    return {
      period: 7,
      overview: {},
      trendChart: null,
      pieChart: null,
      rankChart: null
    }
  },
  computed: {
    overviewCards() {
      const o = this.overview
      return [
        { label: '今日订单', value: o.todayOrderCount || 0 },
        { label: '今日销售额', value: '¥' + (o.todaySalesAmount || 0) },
        { label: '今日新用户', value: o.todayNewUserCount || 0 },
        { label: '待发货订单', value: o.pendingShipCount || 0 }
      ]
    }
  },
  async mounted() {
    this.trendChart = echarts.init(this.$refs.trendChart)
    this.pieChart = echarts.init(this.$refs.pieChart)
    this.rankChart = echarts.init(this.$refs.rankChart)
    window.addEventListener('resize', this.resizeCharts)
    await this.loadAll()
  },
  beforeDestroy() {
    window.removeEventListener('resize', this.resizeCharts)
    this.trendChart && this.trendChart.dispose()
    this.pieChart && this.pieChart.dispose()
    this.rankChart && this.rankChart.dispose()
  },
  methods: {
    resizeCharts() {
      this.trendChart && this.trendChart.resize()
      this.pieChart && this.pieChart.resize()
      this.rankChart && this.rankChart.resize()
    },
    async loadAll() {
      const overviewRes = await getDashboardOverview()
      this.overview = overviewRes.data || {}
      await Promise.all([this.loadTrend(), this.loadPie(), this.loadRank()])
    },
    async loadTrend() {
      const res = await getSalesTrend(this.period)
      const list = res.data || []
      this.trendChart.setOption({
        tooltip: { trigger: 'axis' },
        xAxis: { type: 'category', data: list.map(i => i.date) },
        yAxis: { type: 'value' },
        series: [{ type: 'line', smooth: true, data: list.map(i => i.amount), areaStyle: {} }]
      })
    },
    async loadPie() {
      const res = await getOrderStatus()
      const list = res.data || []
      this.pieChart.setOption({
        tooltip: { trigger: 'item' },
        series: [{
          type: 'pie',
          radius: '65%',
          data: list.map(i => ({ name: i.statusDesc, value: i.count }))
        }]
      })
    },
    async loadRank() {
      const res = await getProductRank()
      const list = res.data || []
      this.rankChart.setOption({
        tooltip: { trigger: 'axis' },
        xAxis: { type: 'category', data: list.map(i => i.name), axisLabel: { rotate: 30 } },
        yAxis: { type: 'value' },
        series: [{ type: 'bar', data: list.map(i => i.salesCount) }]
      })
    }
  }
}
</script>

<style scoped>
.dashboard { padding: 0; }
.card-label { color: #909399; font-size: 14px; }
.card-value { font-size: 28px; font-weight: bold; margin-top: 8px; color: #303133; }
.chart { height: 320px; }
.chart-header { display: flex; justify-content: space-between; align-items: center; }
</style>
