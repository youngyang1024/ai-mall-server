<template>
  <div class="address-page-inner">
    <!-- 移动端使用 Vant 的 AddressList 以保持原生体验，PC端使用自定义卡片网格 -->
    <template v-if="isMobile">
      <van-address-list
        v-model="chosenId"
        :list="addressList"
        default-tag-text="默认"
        @add="openEdit()"
        @edit="openEdit"
        @select="onSelect"
      />
      <van-empty v-if="!addressList.length" description="暂无收货地址" />
    </template>
    <template v-else>
      <div class="address-grid">
        <!-- 新增地址卡片 -->
        <div class="address-card add-card" @click="openEdit()">
          <van-icon name="plus" size="32" color="var(--color-text-muted)" />
          <span class="add-text">新增收货地址</span>
        </div>
        
        <!-- 地址列表卡片 -->
        <div v-for="addr in addressList" :key="addr.id" class="address-card" :class="{ 'is-default': addr.isDefault }">
          <div class="card-header">
            <span class="name">{{ addr.name }}</span>
            <span class="tel">{{ addr.tel }}</span>
          </div>
          <div class="card-body">
            <p>{{ addr.address }}</p>
          </div>
          <div class="card-footer">
            <span v-if="addr.isDefault" class="default-badge">默认地址</span>
            <a v-else href="javascript:;" @click.prevent="onSelect(addr)" class="set-default">设为默认</a>
            <div class="actions">
              <a href="javascript:;" @click.prevent="openEdit(addr)">编辑</a>
              <span class="divider">|</span>
              <a href="javascript:;" @click.prevent="removeAddressById(addr.id)">删除</a>
            </div>
          </div>
        </div>
      </div>
    </template>

    <!-- 编辑弹窗 -->
    <van-popup v-model="showEdit" :position="isMobile ? 'bottom' : 'center'" round :style="editPopupStyle">
      <div class="popup-header">{{ editForm.id ? '编辑地址' : '新增地址' }}</div>
      <van-form @submit="saveAddress" class="edit-form">
        <van-field v-model="editForm.receiverName" label="收货人" placeholder="请输入收货人姓名" :rules="[{ required: true }]" />
        <van-field v-model="editForm.receiverPhone" label="手机号" placeholder="请输入收货人手机号" :rules="[{ required: true }]" />
        
        <!-- 省市区选择器联动 -->
        <van-field
          readonly
          clickable
          name="area"
          :value="areaText"
          label="所在地区"
          placeholder="点击选择省市区"
          @click="showArea = true"
          :rules="[{ required: true, message: '请选择所在地区' }]"
        />
        <van-popup v-model="showArea" position="bottom" append-to-body>
          <van-area
            :area-list="areaList"
            :value="currentAreaCode"
            @confirm="onAreaConfirm"
            @cancel="showArea = false"
          />
        </van-popup>

        <van-field v-model="editForm.detail" label="详细地址" placeholder="街道门牌、楼层房间号等信息" :rules="[{ required: true }]" />
        
        <van-cell title="设为默认">
          <template #right-icon>
            <van-switch v-model="editForm.isDefault" :active-value="1" :inactive-value="0" size="20" active-color="var(--color-primary)" />
          </template>
        </van-cell>
        
        <div style="margin:24px 16px 16px">
          <button class="shopify-btn" style="width: 100%" type="submit">保存</button>
          <button v-if="editForm.id" type="button" class="shopify-btn shopify-btn--outline" style="width: 100%; margin-top:12px" @click="removeAddressById(editForm.id)">删除</button>
        </div>
      </van-form>
    </van-popup>
  </div>
</template>

<script>
import { getAddressList, createAddress, updateAddress, deleteAddress, setDefaultAddress } from '@/api/address'
import { areaList } from '@vant/area-data'

export default {
  name: 'AddressPage',
  data() {
    return {
      list: [],
      chosenId: '',
      showEdit: false,
      editForm: this.emptyForm(),
      showArea: false,
      areaList,
      currentAreaCode: ''
    }
  },
  computed: {
    addressList() {
      return this.list.map(item => ({
        id: String(item.id),
        name: item.receiverName,
        tel: item.receiverPhone,
        address: `${item.province || ''}${item.city || ''}${item.district || ''}${item.detail}`,
        isDefault: item.isDefault === 1
      }))
    },
    editPopupStyle() {
      return this.isMobile ? { height: '80%' } : { width: '520px', paddingBottom: '16px' }
    },
    areaText() {
      const { province, city, district } = this.editForm
      if (province && city && district) {
        return `${province} / ${city} / ${district}`
      }
      return ''
    }
  },
  async created() {
    await this.loadData()
  },
  methods: {
    emptyForm() {
      return { id: null, receiverName: '', receiverPhone: '', province: '', city: '', district: '', detail: '', isDefault: 0 }
    },
    async loadData() {
      const res = await getAddressList()
      this.list = res.data || []
      const defaultAddr = this.list.find(a => a.isDefault === 1)
      if (defaultAddr) {
        this.chosenId = String(defaultAddr.id)
      }
    },
    getAreaCode(province, city, district) {
      if (!province || !city || !district) return ''
      let pCode, cCode, dCode
      // Find province
      for (const [code, name] of Object.entries(this.areaList.province_list)) {
        if (name === province || province.startsWith(name) || name.startsWith(province)) { 
          pCode = code
          break 
        }
      }
      if (!pCode) return ''
      
      // Find city
      const cityPrefix = pCode.substring(0, 2)
      for (const [code, name] of Object.entries(this.areaList.city_list)) {
        if (code.startsWith(cityPrefix) && (name === city || city.startsWith(name) || name.startsWith(city))) { 
          cCode = code
          break 
        }
      }
      if (!cCode) return ''
      
      // Find district
      const distPrefix = cCode.substring(0, 4)
      for (const [code, name] of Object.entries(this.areaList.county_list)) {
        if (code.startsWith(distPrefix) && (name === district || district.startsWith(name) || name.startsWith(district))) { 
          dCode = code
          break 
        }
      }
      return dCode || ''
    },
    onAreaConfirm(values) {
      if (values && values.length === 3) {
        this.editForm.province = values[0].name
        this.editForm.city = values[1].name
        this.editForm.district = values[2].name
        this.currentAreaCode = values[2].code
      }
      this.showArea = false
    },
    openEdit(item) {
      if (item && item.id) {
        const raw = this.list.find(a => String(a.id) === String(item.id))
        this.editForm = raw ? { ...raw } : this.emptyForm()
        this.currentAreaCode = this.getAreaCode(this.editForm.province, this.editForm.city, this.editForm.district)
      } else {
        this.editForm = this.emptyForm()
        this.currentAreaCode = ''
      }
      this.showEdit = true
    },
    async saveAddress() {
      const data = { ...this.editForm }
      if (data.id) await updateAddress(data.id, data)
      else await createAddress(data)
      this.showEdit = false
      this.$toast.success('保存成功')
      await this.loadData()
    },
    async removeAddressById(id) {
      await deleteAddress(id)
      if (this.showEdit && this.editForm.id === id) {
        this.showEdit = false
      }
      this.$toast.success('已删除')
      await this.loadData()
    },
    async onSelect(item) {
      await setDefaultAddress(item.id)
      this.chosenId = String(item.id)
      this.$toast.success('已设为默认地址')
      await this.loadData()
    }
  }
}
</script>

<style scoped>
.edit-form { padding: 0 12px 24px; }
.popup-header {
  text-align: center;
  font-size: 16px;
  font-weight: 600;
  padding: 16px;
  border-bottom: 1px solid var(--color-border);
  margin-bottom: 16px;
}

/* PC 端网格布局样式 */
.address-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 20px;
  padding: 20px 0;
}

.address-card {
  background: var(--color-background);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  padding: 20px;
  display: flex;
  flex-direction: column;
  min-height: 160px;
  transition: border-color 0.2s, box-shadow 0.2s;
}

.address-card:hover {
  border-color: var(--color-primary);
  box-shadow: var(--shadow-sm);
}

.address-card.is-default {
  border-color: var(--color-primary);
}

.add-card {
  justify-content: center;
  align-items: center;
  border: 1px dashed var(--color-border);
  cursor: pointer;
  background: var(--color-surface);
}

.add-card:hover {
  background: var(--color-background);
}

.add-text {
  margin-top: 12px;
  font-size: 15px;
  color: var(--color-text-muted);
  font-weight: 500;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.card-header .name {
  font-size: 16px;
  font-weight: 600;
}

.card-header .tel {
  font-size: 14px;
  color: var(--color-text-muted);
}

.card-body {
  flex: 1;
}

.card-body p {
  margin: 0;
  font-size: 14px;
  line-height: 1.5;
  color: var(--color-text-main);
}

.card-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 16px;
  padding-top: 16px;
  border-top: 1px solid var(--color-border);
  font-size: 13px;
}

.default-badge {
  background: var(--color-primary);
  color: #fff;
  padding: 2px 8px;
  border-radius: 2px;
  font-size: 12px;
}

.set-default {
  color: var(--color-text-muted);
}

.set-default:hover {
  color: var(--color-primary);
}

.actions {
  display: flex;
  align-items: center;
  gap: 8px;
}

.actions a {
  color: var(--color-primary);
}

.actions .divider {
  color: var(--color-border);
}
</style>
