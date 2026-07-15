<template>
  <page-shell title="帮助中心" :show-back="isMobile" :with-tabbar-space="false">
    <div class="help-center-page">
      <!-- Search Top Bar -->
      <div class="help-search-header">
        <h1 class="help-title">搜索帮助中心</h1>
        <div class="search-box">
          <van-icon name="search" class="search-icon" />
          <input 
            type="text" 
            v-model="keyword" 
            placeholder="搜索问题关键词 (例如: 退换货)" 
            @keyup.enter="handleSearch"
          />
        </div>
      </div>

      <div class="help-content-wrapper">
        <h2 class="all-topics-title">全部主题</h2>
        
        <div class="help-layout">
          <!-- Left Sidebar Categories -->
          <aside class="help-sidebar" v-if="!isMobile || !showMobileArticle">
            <ul class="category-list">
              <li 
                v-for="cat in categories" 
                :key="cat.id" 
                :class="{ active: activeCategoryId === cat.id }"
                @click="selectCategory(cat.id)"
              >
                <span class="cat-name">{{ cat.name }}</span>
                <van-icon name="arrow" class="cat-arrow" />
              </li>
            </ul>
          </aside>

          <!-- Right Content Articles -->
          <main class="help-main" v-if="!isMobile || showMobileArticle">
            <!-- Mobile back button to categories -->
            <div class="mobile-back-cat" v-if="isMobile && showMobileArticle" @click="showMobileArticle = false">
              <van-icon name="arrow-left" /> 返回主题
            </div>
            
            <van-collapse v-model="activeNames" class="custom-collapse" accordion>
              <van-collapse-item 
                v-for="art in articles" 
                :key="art.id" 
                :title="art.title" 
                :name="art.id"
              >
                <div class="article-content" v-html="art.content"></div>
              </van-collapse-item>
            </van-collapse>
            
            <van-empty v-if="articles.length === 0" description="未找到相关问答" />
          </main>
        </div>
      </div>
    </div>
  </page-shell>
</template>

<script>
import { getFaqCategoryList, getFaqArticleList } from '@/api/faq'
import responsiveMixin from '@/mixins/responsive'

export default {
  name: 'HelpCenterPage',
  mixins: [responsiveMixin],
  data() {
    return {
      keyword: '',
      categories: [],
      activeCategoryId: null,
      articles: [],
      activeNames: '', // for van-collapse
      showMobileArticle: false
    }
  },
  created() {
    this.fetchCategories()
  },
  methods: {
    async fetchCategories() {
      try {
        const res = await getFaqCategoryList()
        this.categories = res.data || []
        if (this.categories.length > 0) {
          this.activeCategoryId = this.categories[0].id
          this.fetchArticles()
        }
      } catch (e) {
        console.error(e)
      }
    },
    async fetchArticles() {
      try {
        const res = await getFaqArticleList({ 
          categoryId: this.activeCategoryId,
          keyword: this.keyword
        })
        this.articles = res.data || []
        this.activeNames = '' // reset accordion
      } catch (e) {
        console.error(e)
      }
    },
    selectCategory(id) {
      this.activeCategoryId = id
      this.keyword = '' // clear search when switching category manually
      this.showMobileArticle = true
      this.fetchArticles()
    },
    handleSearch() {
      this.activeCategoryId = null // search globally by unsetting category
      this.showMobileArticle = true
      this.fetchArticles()
    }
  }
}
</script>

<style scoped>
.help-center-page {
  max-width: 1200px;
  margin: 0 auto;
  padding: 24px;
  min-height: calc(100vh - 120px);
}

.help-search-header {
  margin-bottom: 40px;
}

.help-title {
  font-size: 24px;
  font-weight: 600;
  margin-bottom: 20px;
  color: var(--color-text-main);
}

.search-box {
  display: flex;
  align-items: center;
  border: 1px solid var(--color-border);
  border-radius: 4px;
  padding: 12px 16px;
  background: #fff;
  max-width: 600px;
  transition: border-color 0.2s;
}

.search-box:focus-within {
  border-color: var(--color-primary);
}

.search-icon {
  font-size: 18px;
  color: var(--color-text-muted);
  margin-right: 12px;
}

.search-box input {
  flex: 1;
  border: none;
  outline: none;
  font-size: 14px;
  color: var(--color-text-main);
}

.search-box input::placeholder {
  color: #bbb;
}

.all-topics-title {
  font-size: 20px;
  font-weight: 600;
  margin-bottom: 24px;
  padding-bottom: 12px;
  border-bottom: 1px solid var(--color-border);
}

.help-layout {
  display: flex;
  gap: 40px;
  align-items: flex-start;
}

.help-sidebar {
  width: 240px;
  flex-shrink: 0;
}

.category-list {
  list-style: none;
  padding: 0;
  margin: 0;
}

.category-list li {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 0;
  cursor: pointer;
  border-bottom: 1px solid var(--color-border);
  color: var(--color-text-main);
  transition: all 0.2s;
}

.category-list li:hover {
  color: var(--color-primary);
}

.category-list li.active {
  color: var(--color-primary);
  font-weight: 600;
}

.cat-name {
  font-size: 14px;
}

.cat-arrow {
  font-size: 12px;
  color: #999;
}

.category-list li.active .cat-arrow {
  color: var(--color-primary);
}

.help-main {
  flex: 1;
  min-width: 0;
}

.mobile-back-cat {
  padding: 12px 0;
  font-size: 14px;
  color: var(--color-primary);
  display: flex;
  align-items: center;
  gap: 4px;
  cursor: pointer;
  margin-bottom: 16px;
  border-bottom: 1px solid var(--color-border);
}

/* Custom Collapse Styles matching Homary */
::v-deep .custom-collapse .van-cell {
  background-color: transparent;
}
::v-deep .custom-collapse .van-collapse-item__title {
  padding: 20px 0;
  font-size: 15px;
  font-weight: 500;
  color: var(--color-text-main);
  background-color: transparent;
}
::v-deep .custom-collapse .van-collapse-item__title .van-cell__right-icon {
  color: var(--color-text-main);
  font-size: 14px;
}
::v-deep .custom-collapse .van-collapse-item__wrapper {
  background-color: #fafafa;
  border-radius: 0 0 8px 8px;
}
::v-deep .custom-collapse .van-collapse-item__content {
  padding: 20px;
  color: var(--color-text-regular);
  line-height: 1.6;
  font-size: 14px;
  background: transparent;
}
::v-deep .van-cell::after {
  left: 0;
  right: 0;
  border-bottom-color: var(--color-border);
}

@media (max-width: 767px) {
  .help-center-page {
    padding: 16px;
  }
  .help-layout {
    flex-direction: column;
    gap: 0;
  }
  .help-sidebar {
    width: 100%;
  }
}
</style>
