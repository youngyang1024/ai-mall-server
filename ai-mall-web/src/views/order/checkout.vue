<template>
  <page-shell title="确认订单" :show-back="isMobile">
    <div class="checkout-page-inner">
      <div class="checkout-layout">
        <!-- 左侧：主要信息区 -->
        <div class="checkout-main">
          <div class="checkout-section">
            <div class="section-header">
              <h2 class="section-title">收货地址</h2>
              <button class="edit-btn" @click="showAddressPicker = true">修改</button>
            </div>
            <div class="address-card" v-if="selectedAddress">
              <div class="address-name">{{ selectedAddress.receiverName }} {{ selectedAddress.receiverPhone }}</div>
              <div class="address-detail">{{ fullAddress(selectedAddress) }}</div>
            </div>
            <div class="address-empty" v-else @click="showAddressPicker = true">
              <van-icon name="add-o" size="24" />
              <span>添加收货地址</span>
            </div>
          </div>

          <div class="checkout-section">
            <h2 class="section-title">商品清单</h2>
            <div class="order-items">
              <div v-for="item in cartItems" :key="item.id" class="order-item">
                <div class="item-image-wrapper">
                  <img :src="item.image" :alt="item.spuName" class="item-image" />
                  <span class="item-badge">{{ item.quantity }}</span>
                </div>
                <div class="item-info">
                  <div class="item-title">{{ item.spuName }}</div>
                  <div class="item-spec" v-if="item.skuSpec">{{ formatSpec(item.skuSpec) }}</div>
                </div>
                <div class="item-price">¥{{ (item.price * item.quantity).toFixed(2) }}</div>
              </div>
            </div>
          </div>

          <div class="checkout-section">
            <h2 class="section-title">订单备注</h2>
            <div class="remark-input-wrapper">
              <input type="text" v-model="remark" placeholder="选填，给卖家留言" class="remark-input" />
            </div>
          </div>
        </div>

        <!-- 右侧：摘要与优惠券 -->
        <div class="checkout-sidebar">
          <div class="summary-card">
            <div class="coupon-selector" @click="showCouponPicker = true">
              <span class="coupon-label">优惠券</span>
              <span class="coupon-value" :class="{ 'has-coupon': selectedCoupon }">
                {{ selectedCoupon ? '-¥' + selectedCoupon.discount : usableCoupons.length ? '有可用券' : '暂无可用' }}
              </span>
              <van-icon name="arrow" color="#969799" />
            </div>

            <div class="summary-details">
              <div class="summary-row">
                <span>商品总额</span>
                <span>¥{{ totalPrice.toFixed(2) }}</span>
              </div>
              <div class="summary-row discount-row" v-if="discountAmount > 0">
                <span>优惠抵扣</span>
                <span>-¥{{ discountAmount.toFixed(2) }}</span>
              </div>
              <div class="summary-row">
                <span>运费</span>
                <span>免运费</span>
              </div>
            </div>

            <div class="summary-total">
              <span>应付金额</span>
              <span class="total-price">¥{{ payPrice.toFixed(2) }}</span>
            </div>

            <button class="shopify-btn submit-btn" @click="onSubmit">提交订单</button>
          </div>
        </div>
      </div>
    </div>

    <!-- 地址选择弹窗 -->
    <van-popup
      v-model="showAddressPicker"
      :position="isMobile ? 'bottom' : 'center'"
      :class="isMobile ? 'mobile-popup' : 'pc-popup'"
      closeable
      round
      :style="isMobile ? { maxHeight: '80%' } : { width: '500px', maxHeight: '80vh' }"
    >
      <div class="popup-header">选择收货地址</div>
      <div class="popup-content sheet-list">
        <div class="address-list">
          <div 
            v-for="addr in addressList" 
            :key="addr.id" 
            class="address-item"
            :class="{ active: selectedAddress && selectedAddress.id === addr.id }"
            @click="selectAddress(addr)"
          >
            <div class="address-item-info">
              <div class="name-phone">{{ addr.receiverName }} {{ addr.receiverPhone }}</div>
              <div class="detail">{{ fullAddress(addr) }}</div>
            </div>
            <van-icon name="success" class="check-icon" v-if="selectedAddress && selectedAddress.id === addr.id" />
          </div>
        </div>
        
        <van-empty v-if="!addressList.length" description="暂无地址">
          <button class="shopify-btn" @click="$router.push('/user/address')">去添加</button>
        </van-empty>
        <div v-if="addressList.length" class="popup-action">
          <button class="shopify-btn shopify-btn--outline" style="width: 100%" @click="$router.push('/user/address')">
            管理收货地址
          </button>
        </div>
      </div>
    </van-popup>

    <!-- 优惠券选择弹窗 -->
    <van-popup
      v-model="showCouponPicker"
      :position="isMobile ? 'bottom' : 'center'"
      :class="isMobile ? 'mobile-popup' : 'pc-popup'"
      closeable
      round
      :style="isMobile ? { maxHeight: '80%' } : { width: '500px', maxHeight: '80vh' }"
    >
      <div class="popup-header">选择优惠券</div>
      <div class="popup-content sheet-list">
        <div class="coupon-list">
          <div class="coupon-item" :class="{ active: !selectedCoupon }" @click="selectCoupon(null)">
            <div class="coupon-info">不使用优惠券</div>
            <van-icon name="success" class="check-icon" v-if="!selectedCoupon" />
          </div>
          
          <div 
            v-for="coupon in usableCoupons" 
            :key="coupon.id" 
            class="coupon-item"
            :class="{ active: selectedCoupon && selectedCoupon.id === coupon.id }"
            @click="selectCoupon(coupon)"
          >
            <div class="coupon-info">
              <div class="coupon-title">{{ couponTitle(coupon) }}</div>
              <div class="coupon-time">有效期至 {{ coupon.endTime }}</div>
            </div>
            <van-icon name="success" class="check-icon" v-if="selectedCoupon && selectedCoupon.id === coupon.id" />
          </div>
        </div>

        <van-empty v-if="!usableCoupons.length" description="暂无可用优惠券">
          <button class="shopify-btn" @click="$router.push('/coupon')">去领券</button>
        </van-empty>
      </div>
    </van-popup>
  </page-shell>
</template>

<script>
import { getAddressList } from '@/api/address'
import { getCartList } from '@/api/cart'
import { createOrder } from '@/api/order'
import { getUsableCoupons } from '@/api/coupon'

export default {
  name: 'CheckoutPage',
  data() {
    return {
      addressList: [],
      selectedAddress: null,
      cartItems: [],
      usableCoupons: [],
      selectedCoupon: null,
      remark: '',
      showAddressPicker: false,
      showCouponPicker: false
    }
  },
  computed: {
    totalPrice() {
      return this.cartItems.reduce((sum, item) => sum + Number(item.price) * item.quantity, 0)
    },
    discountAmount() {
      return this.selectedCoupon ? Number(this.selectedCoupon.discount) : 0
    },
    payPrice() {
      return Math.max(0, this.totalPrice - this.discountAmount)
    }
  },
  async created() {
    const cartIds = (this.$route.query.cartIds || '').split(',').filter(Boolean).map(Number)
    const [addrRes, cartRes] = await Promise.all([getAddressList(), getCartList()])
    this.addressList = addrRes.data || []
    const all = cartRes.data || []
    if (cartIds.length) {
      this.cartItems = all.filter(i => cartIds.includes(i.id))
    } else {
      this.cartItems = all.filter(i => i.checked === 1)
    }
    this.selectedAddress = this.addressList.find(a => a.isDefault === 1) || this.addressList[0] || null
    await this.loadUsableCoupons()
  },
  methods: {
    formatSpec(specJsonStr) {
      if (!specJsonStr) return ''
      try {
        const obj = JSON.parse(specJsonStr)
        return Object.entries(obj).map(([k, v]) => `${k}: ${v}`).join(' | ')
      } catch (e) {
        return specJsonStr
      }
    },
    fullAddress(addr) {
      return [addr.province, addr.city, addr.district, addr.detail].filter(Boolean).join('')
    },
    couponTitle(coupon) {
      return `满${coupon.threshold}减${coupon.discount}`
    },
    async loadUsableCoupons() {
      if (!this.totalPrice) return
      const res = await getUsableCoupons(this.totalPrice)
      this.usableCoupons = res.data || []
    },
    selectAddress(addr) {
      this.selectedAddress = addr
      this.showAddressPicker = false
    },
    selectCoupon(coupon) {
      this.selectedCoupon = coupon
      this.showCouponPicker = false
    },
    async onSubmit() {
      if (!this.selectedAddress) {
        this.$toast('请选择收货地址')
        return
      }
      if (!this.cartItems.length) {
        this.$toast('没有可结算的商品')
        return
      }
      const payload = {
        addressId: this.selectedAddress.id,
        cartIds: this.cartItems.map(i => i.id),
        remark: this.remark
      }
      if (this.selectedCoupon) {
        payload.userCouponId = this.selectedCoupon.id
      }
      const res = await createOrder(payload)
      this.$router.replace({ path: '/order/pay', query: { orderNo: res.data.orderNo } })
    }
  }
}
</script>

<style scoped>
.checkout-page-inner {
  max-width: 1200px;
  margin: 0 auto;
  padding: 24px 16px;
}

.checkout-layout {
  display: grid;
  grid-template-columns: 1fr 380px;
  gap: 48px;
  align-items: start;
}

.checkout-section {
  margin-bottom: 40px;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px; /* Increased margin below title */
}

.section-title {
  font-size: 20px;
  font-weight: 500;
  margin: 0;
  margin-bottom: 24px; /* Ensure spacing if no header container */
}

.section-header .section-title {
  margin-bottom: 0; /* Let section-header control the spacing when it exists */
}

.edit-btn {
  background: none;
  border: none;
  color: var(--color-text-muted);
  text-decoration: underline;
  cursor: pointer;
  font-size: 14px;
}
.edit-btn:hover {
  color: var(--color-primary);
}

.address-card {
  padding: 20px;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  background: #fff;
}
.address-name {
  font-weight: 600;
  margin-bottom: 8px;
  font-size: 16px;
}
.address-detail {
  color: var(--color-text-muted);
  line-height: 1.5;
}
.address-empty {
  padding: 30px;
  border: 1px dashed var(--color-border);
  border-radius: var(--radius-sm);
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  color: var(--color-text-muted);
  cursor: pointer;
}
.address-empty:hover {
  border-color: var(--color-primary);
  color: var(--color-primary);
}

.order-items {
  display: flex;
  flex-direction: column;
  gap: 16px;
}
.order-item {
  display: flex;
  align-items: center;
  gap: 16px;
}
.item-image-wrapper {
  position: relative;
}
.item-image {
  width: 64px;
  height: 64px;
  object-fit: cover;
  border-radius: var(--radius-sm);
  background: var(--color-surface);
  border: 1px solid var(--color-border);
}
.item-badge {
  position: absolute;
  top: -8px;
  right: -8px;
  background: var(--color-text-muted);
  color: #fff;
  font-size: 12px;
  min-width: 20px;
  height: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 10px;
  padding: 0 6px;
}
.item-info {
  flex: 1;
}
.item-title {
  font-weight: 500;
  font-size: 14px;
  margin-bottom: 4px;
}
.item-spec {
  font-size: 12px;
  color: var(--color-text-muted);
}
.item-price {
  font-weight: 600;
}

.remark-input-wrapper {
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  overflow: hidden;
}
.remark-input {
  width: 100%;
  border: none;
  padding: 12px 16px;
  font-size: 14px;
  outline: none;
}

/* Sidebar */
.checkout-sidebar {
  position: sticky;
  top: 24px;
}
.summary-card {
  background: var(--color-surface);
  padding: 24px;
  border-radius: var(--radius-md);
}

.coupon-selector {
  display: flex;
  align-items: center;
  padding: 16px;
  background: #fff;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  cursor: pointer;
  margin-bottom: 24px;
}
.coupon-label {
  flex: 1;
  font-weight: 500;
}
.coupon-value {
  color: var(--color-text-muted);
  margin-right: 8px;
  font-size: 14px;
}
.coupon-value.has-coupon {
  color: #ee0a24;
  font-weight: 500;
}

.summary-details {
  border-bottom: 1px solid var(--color-border);
  padding-bottom: 16px;
  margin-bottom: 16px;
}
.summary-row {
  display: flex;
  justify-content: space-between;
  margin-bottom: 12px;
  color: var(--color-text-muted);
}
.summary-row:last-child {
  margin-bottom: 0;
}
.discount-row span:last-child {
  color: #ee0a24;
}

.summary-total {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 18px;
  font-weight: 600;
  margin-bottom: 24px;
}
.total-price {
  font-size: 24px;
}
.submit-btn {
  width: 100%;
}

/* Popups */
.sheet-list { overflow-y: auto; }
.popup-header {
  text-align: center;
  font-size: 16px;
  font-weight: 600;
  padding: 16px;
  border-bottom: 1px solid var(--color-border);
}
.popup-content {
  padding-bottom: env(safe-area-inset-bottom);
}
.pc-popup .popup-content {
  padding: 0 16px 24px;
}

.address-list, .coupon-list {
  padding: 16px 0;
}
.address-item, .coupon-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  margin-bottom: 12px;
  cursor: pointer;
  transition: all 0.2s;
}
.address-item:hover, .coupon-item:hover {
  border-color: #ccc;
}
.address-item.active, .coupon-item.active {
  border-color: var(--color-primary);
  background: var(--color-surface);
}
.name-phone {
  font-weight: 600;
  margin-bottom: 4px;
}
.detail {
  font-size: 13px;
  color: var(--color-text-muted);
  line-height: 1.4;
}
.coupon-title {
  font-weight: 600;
  color: #ee0a24;
  margin-bottom: 4px;
}
.coupon-time {
  font-size: 12px;
  color: var(--color-text-muted);
}
.check-icon {
  color: var(--color-primary);
  font-size: 20px;
}

.popup-action {
  padding-top: 16px;
}

@media (max-width: 767px) {
  .checkout-page-inner {
    padding: 16px;
  }
  .checkout-layout {
    grid-template-columns: 1fr;
    gap: 24px;
  }
  .checkout-sidebar {
    position: static;
  }
}
</style>
