<template>
  <page-shell title="购物车" :with-tabbar-space="isMobile">
    <div class="cart-page-inner">
      <div v-if="!list.length && !loading" class="empty-state">
        <h2 class="empty-title">您的购物车是空的</h2>
        <button class="shopify-btn" @click="$router.push('/category')">继续购物</button>
      </div>

      <template v-else>
        <div class="cart-layout">
          <div class="cart-main">
            <div class="cart-header" v-if="!isMobile">
              <div class="col-product select-all-wrap">
                <van-checkbox
                  :value="isAllChecked"
                  checked-color="var(--color-primary)"
                  :disabled="!validList.length"
                  @click.native.prevent="toggleCheckAll"
                >
                  全选
                </van-checkbox>
                <span class="col-label">商品</span>
              </div>
              <div class="col-quantity">数量</div>
              <div class="col-total">小计</div>
            </div>

            <div class="mobile-select-all" v-else>
              <van-checkbox
                :value="isAllChecked"
                checked-color="var(--color-primary)"
                :disabled="!validList.length"
                @click.native.prevent="toggleCheckAll"
              >
                全选
              </van-checkbox>
            </div>

            <div v-for="item in list" :key="item.id" class="cart-item" :class="{ 'is-invalid': item.spuStatus === 0 }">
              <div class="item-checkbox">
                <van-checkbox v-model="item.checked" :name="item.id" checked-color="var(--color-primary)" :disabled="item.spuStatus === 0" @change="onCheckChange(item)" />
              </div>
              <div class="item-product">
                <img :src="item.image" :alt="item.spuName" class="item-image" @click="goToProduct(item.spuId)" />
                <div class="item-info">
                  <div class="item-title" @click="goToProduct(item.spuId)">
                    {{ item.spuName }}
                    <span class="invalid-tag" v-if="item.spuStatus === 0">已下架</span>
                  </div>

                  <!-- Homary style spec block -->
                  <div class="item-spec-box" :class="{ disabled: item.spuStatus === 0 }" @click="item.spuStatus !== 0 && openSpecSelector(item)">
                    <div class="item-spec-text" v-if="item.skuSpec">{{ formatSpec(item.skuSpec) }}</div>
                    <div class="item-price-box">
                      <span class="price-current">¥{{ item.price }}</span>
                      <span class="price-original">¥{{ (item.price * 1.2).toFixed(2) }}</span>
                    </div>
                  </div>

                  <div class="invalid-tips" v-if="item.spuStatus === 0">该商品已下架，无法结算</div>

                  <div class="item-actions">
                    <button class="item-action-btn" @click="removeItem(item)"><van-icon name="cross" /> 移除</button>
                    <!-- Here we could add save for later -->
                  </div>
                </div>
              </div>
              <div class="item-quantity" v-if="!isMobile">
                <van-stepper v-model="item.quantity" min="1" :max="item.stock" disable-input :disabled="item.spuStatus === 0" @change="qty => onQtyChange(item, qty)" />
              </div>
              <div class="item-total" v-if="!isMobile">
                ¥{{ (item.price * item.quantity).toFixed(2) }}
              </div>
            </div>
          </div>

          <div class="cart-sidebar">
            <div class="summary-card">
              <h3 class="summary-title">订单摘要</h3>
              <div class="summary-row">
                <span>小计({{ checkedIds.length }}件)</span>
                <span>¥{{ totalPrice.toFixed(2) }}</span>
              </div>
              <p class="summary-note">运费和税费将在结算时计算</p>
              <button class="shopify-btn checkout-btn" :disabled="!checkedIds.length" @click="onSubmit">
                去结算
              </button>
            </div>
          </div>
        </div>
      </template>
    </div>

    <!-- Edit Spec Popup -->
    <van-popup v-model="showSpecPopup" position="bottom" round class="spec-popup" :style="{ maxHeight: '80%' }">
      <div class="spec-popup-content" v-if="currentEditingItem && editingProductDetail">
        <div class="popup-header">
          <img :src="editingCurrentSku ? editingCurrentSku.image || editingProductDetail.spu.mainImage : editingProductDetail.spu.mainImage" class="popup-img" />
          <div class="popup-price-wrap">
            <span class="popup-price">¥{{ editingCurrentSku ? editingCurrentSku.price : editingProductDetail.spu.minPrice }}</span>
            <span class="popup-stock">库存: {{ editingCurrentSku ? editingCurrentSku.stock : 0 }}</span>
          </div>
          <van-icon name="cross" class="popup-close" @click="showSpecPopup = false" />
        </div>
        <div class="popup-body">
          <div class="product-variants">
            <div v-for="(spec, specIndex) in editingProductDetail.specs" :key="spec.specName" class="variant-group">
              <div class="variant-label">{{ spec.specName }}</div>
              <div class="variant-options">
                <button
                  v-for="(val, valIdx) in spec.specValues"
                  :key="val"
                  type="button"
                  :class="['variant-btn', { active: editingSelectedSpecs[specIndex] === valIdx }]"
                  @click="$set(editingSelectedSpecs, specIndex, valIdx)"
                >
                  {{ val }}
                </button>
              </div>
            </div>
          </div>
          <div class="popup-qty">
            <span class="qty-label">数量</span>
            <van-stepper v-model="editingQuantity" min="1" :max="editingCurrentSku ? editingCurrentSku.stock : 1" disable-input />
          </div>
        </div>
        <div class="popup-footer">
          <button class="shopify-btn" style="width:100%" :disabled="!editingCurrentSku || editingCurrentSku.stock <= 0" @click="confirmEditSpec">
            确认修改
          </button>
        </div>
      </div>
    </van-popup>
  </page-shell>
</template>

<script>
import { getCartList, updateCart, deleteCartItem, checkAllCart } from '@/api/cart'
import { getProductDetail } from '@/api/product'

export default {
  name: 'CartPage',
  data() {
    return {
      list: [],
      loading: false,
      showSpecPopup: false,
      currentEditingItem: null,
      editingProductDetail: null,
      editingSelectedSpecs: [],
      editingQuantity: 1
    }
  },
  computed: {
    // 有效商品（未下架）
    validList() {
      return this.list.filter(i => i.spuStatus !== 0)
    },
    isAllChecked() {
      return this.validList.length > 0 && this.validList.every(i => i.checked)
    },
    checkedIds() {
      return this.validList.filter(i => i.checked).map(i => i.id)
    },
    totalPrice() {
      return this.validList
        .filter(item => item.checked)
        .reduce((sum, item) => sum + Number(item.price) * item.quantity, 0)
    },
    editingCurrentSku() {
      if (!this.editingProductDetail?.skus?.length) return null
      const specs = this.editingProductDetail.specs || []
      if (!specs.length) return this.editingProductDetail.skus[0]
      if (this.editingSelectedSpecs.length < specs.length) return null

      return this.editingProductDetail.skus.find(sku => {
        let specObj
        try {
          specObj = JSON.parse(sku.specJson)
        } catch {
          return false
        }
        return specs.every((spec, idx) => {
          const val = spec.specValues[this.editingSelectedSpecs[idx]]
          return specObj[spec.specName] === val
        })
      }) || null
    }
  },
  async created() {
    await this.loadData()
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
    goToProduct(spuId) {
      this.$router.push('/product/' + spuId)
    },
    async loadData() {
      this.loading = true
      try {
        const res = await getCartList()
        this.list = (res.data || []).map(item => ({
          ...item,
          checked: item.checked === 1
        }))
      } finally {
        this.loading = false
      }
    },
    async onQtyChange(item, qty) {
      await updateCart({ id: item.id, quantity: qty, checked: item.checked ? 1 : 0 })
    },
    async onCheckChange(item) {
      await updateCart({ id: item.id, quantity: item.quantity, checked: item.checked ? 1 : 0 })
    },
    // 后端全选会把失效商品也置 checked，前端总价/结算只统计有效已选项
    async toggleCheckAll() {
      if (!this.validList.length) return
      const target = this.isAllChecked ? 0 : 1
      await checkAllCart(target)
      await this.loadData()
    },
    async removeItem(item) {
      await deleteCartItem(item.id)
      this.$toast.success('已删除')
      await this.loadData()
    },
    onSubmit() {
      if (!this.checkedIds.length) return
      this.$router.push({ path: '/order/checkout', query: { cartIds: this.checkedIds.join(',') } })
    },
    async openSpecSelector(item) {
      this.currentEditingItem = item
      this.editingQuantity = item.quantity
      try {
        const res = await getProductDetail(item.spuId)
        this.editingProductDetail = res.data
        // Match current spec selection
        const specs = this.editingProductDetail.specs || []
        let currentSpecObj = {}
        try {
          currentSpecObj = JSON.parse(item.skuSpec)
        } catch(e) {}
        
        this.editingSelectedSpecs = specs.map(spec => {
          const val = currentSpecObj[spec.specName]
          const idx = spec.specValues.indexOf(val)
          return idx !== -1 ? idx : 0
        })
        
        this.showSpecPopup = true
      } catch (e) {
        this.$toast('获取商品详情失败')
      }
    },
    async confirmEditSpec() {
      if (!this.editingCurrentSku) return
      try {
        await updateCart({
          id: this.currentEditingItem.id,
          skuId: this.editingCurrentSku.id,
          quantity: this.editingQuantity,
          checked: this.currentEditingItem.checked ? 1 : 0
        })
        this.showSpecPopup = false
        this.$toast.success('修改成功')
        await this.loadData()
      } catch (e) {
        // error handled globally
      }
    }
  }
}
</script>

<style scoped>
.cart-page-inner {
  max-width: 1200px;
  margin: 0 auto;
  padding: 24px 16px;
}

.empty-state {
  text-align: center;
  padding: 80px 0;
}
.empty-title {
  font-size: 24px;
  margin-bottom: 24px;
  font-weight: 500;
}

.cart-layout {
  display: grid;
  grid-template-columns: 1fr 320px;
  gap: 48px;
  align-items: start;
}

.cart-header {
  display: grid;
  grid-template-columns: 40px 1fr 120px 100px;
  padding-bottom: 16px;
  border-bottom: 1px solid var(--color-border);
  font-size: 13px;
  color: var(--color-text-muted);
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.cart-item {
  display: grid;
  grid-template-columns: 40px 1fr 120px 100px;
  align-items: center;
  padding: 24px 0;
  border-bottom: 1px solid var(--color-border);
}

/* 失效（已下架）商品 */
.cart-item.is-invalid .item-image,
.cart-item.is-invalid .item-title,
.cart-item.is-invalid .item-spec-box,
.cart-item.is-invalid .item-quantity,
.cart-item.is-invalid .item-total {
  opacity: 0.5;
  filter: grayscale(0.8);
}

.cart-item.is-invalid .item-image,
.cart-item.is-invalid .item-title {
  cursor: default;
}

.invalid-tag {
  display: inline-block;
  font-size: 11px;
  font-weight: 400;
  color: #ee0a24;
  border: 1px solid #ee0a24;
  border-radius: 2px;
  padding: 1px 6px;
  margin-left: 8px;
  vertical-align: middle;
}

.invalid-tips {
  font-size: 12px;
  color: #ee0a24;
  margin-bottom: 12px;
}

.item-spec-box.disabled {
  cursor: not-allowed;
}

.item-spec-box.disabled:hover {
  border-color: var(--color-border);
}

/* 全选 */
.select-all-wrap {
  display: flex;
  align-items: center;
  gap: 24px;
  grid-column: 1 / 3;
}

.select-all-wrap ::v-deep .van-checkbox__label {
  font-size: 13px;
  color: var(--color-text-muted);
}

.mobile-select-all {
  padding: 12px 0;
  border-bottom: 1px solid var(--color-border);
}

.mobile-select-all ::v-deep .van-checkbox__label {
  font-size: 13px;
  color: var(--color-text-main);
}

.item-checkbox {
  display: flex;
  align-items: center;
}

.item-product {
  display: flex;
  gap: 24px;
}
.item-image {
  width: 120px;
  height: 120px;
  object-fit: cover;
  border-radius: var(--radius-sm);
  background: var(--color-surface);
  cursor: pointer;
}
.item-info {
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  flex: 1;
}
.item-title {
  font-size: 16px;
  font-weight: 500;
  margin-bottom: 12px;
  cursor: pointer;
  line-height: 1.4;
}
.item-title:hover {
  text-decoration: underline;
}

/* Homary Spec Box */
.item-spec-box {
  border: 1px solid var(--color-border); /* Subtle border instead of red */
  padding: 12px;
  border-radius: 2px;
  display: inline-block;
  cursor: pointer;
  margin-bottom: 12px;
  align-self: flex-start;
  transition: border-color 0.2s;
}
.item-spec-box:hover {
  border-color: var(--color-primary);
}
.item-spec-text {
  font-size: 13px;
  color: var(--color-text-main);
  margin-bottom: 8px;
}
.item-price-box {
  display: flex;
  align-items: baseline;
  gap: 8px;
}
.price-current {
  font-size: 16px;
  font-weight: 600;
  color: var(--color-text-main);
}
.price-original {
  font-size: 13px;
  color: var(--color-text-muted);
  text-decoration: line-through;
}

.item-actions {
  display: flex;
  gap: 16px;
  margin-top: auto;
}
.item-action-btn {
  background: none;
  border: none;
  padding: 0;
  font-size: 13px;
  color: var(--color-text-main);
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 4px;
}
.item-action-btn:hover {
  text-decoration: underline;
}

.item-quantity {
  display: flex;
  align-items: center;
}

.item-total {
  font-size: 18px;
  font-weight: 600;
  text-align: right;
}

.summary-card {
  background: var(--color-surface);
  padding: 24px;
  border-radius: var(--radius-md);
}
.summary-title {
  font-size: 18px;
  margin-bottom: 24px;
  font-weight: 500;
}
.summary-row {
  display: flex;
  justify-content: space-between;
  font-size: 16px;
  font-weight: 600;
  margin-bottom: 16px;
}
.summary-note {
  font-size: 13px;
  color: var(--color-text-muted);
  margin-bottom: 24px;
}
.checkout-btn {
  width: 100%;
}

/* Spec Popup Styles */
.spec-popup-content {
  display: flex;
  flex-direction: column;
  height: 100%;
}
.popup-header {
  padding: 16px;
  display: flex;
  gap: 16px;
  border-bottom: 1px solid var(--color-border);
  position: relative;
}
.popup-img {
  width: 80px;
  height: 80px;
  object-fit: cover;
  border-radius: 4px;
  border: 1px solid var(--color-border);
}
.popup-price-wrap {
  display: flex;
  flex-direction: column;
  justify-content: center;
}
.popup-price {
  color: var(--color-primary);
  font-size: 20px;
  font-weight: 600;
  margin-bottom: 4px;
}
.popup-stock {
  font-size: 12px;
  color: var(--color-text-muted);
}
.popup-close {
  position: absolute;
  top: 16px;
  right: 16px;
  font-size: 20px;
  color: var(--color-text-muted);
  cursor: pointer;
}
.popup-body {
  flex: 1;
  overflow-y: auto;
  padding: 16px;
}
.variant-group {
  margin-bottom: 20px;
}
.variant-label {
  font-size: 14px;
  font-weight: 600;
  margin-bottom: 12px;
}
.variant-options {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
}
.variant-btn {
  padding: 8px 16px;
  border: 1px solid var(--color-border);
  background: #fff;
  font-size: 13px;
  cursor: pointer;
  border-radius: 2px;
}
.variant-btn.active {
  border-color: var(--color-primary);
  background: var(--color-primary);
  color: #fff;
}
.popup-qty {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 16px;
  border-top: 1px solid var(--color-border);
}
.qty-label {
  font-weight: 600;
}
.popup-footer {
  padding: 16px;
  border-top: 1px solid var(--color-border);
}

@media (max-width: 767px) {
  .cart-page-inner {
    padding: 16px;
  }
  .cart-layout {
    grid-template-columns: 1fr;
    gap: 24px;
  }
  .cart-item {
    grid-template-columns: 32px 1fr;
    gap: 16px;
    padding: 16px 0;
  }
  .item-product {
    gap: 16px;
  }
  .item-image {
    width: 80px;
    height: 80px;
  }
  .item-quantity {
    grid-column: 2;
    margin-top: -12px;
  }
  .summary-card {
    padding: 16px;
  }
}
</style>
