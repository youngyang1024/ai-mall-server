import DOMPurify from 'dompurify'

// 富文本白名单净化：允许常规排版标签与图片，禁 script/样式表/事件属性
const CONFIG = {
  ALLOWED_TAGS: [
    'a', 'b', 'strong', 'i', 'em', 'u', 's', 'br', 'p', 'div', 'span',
    'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'ul', 'ol', 'li', 'blockquote',
    'table', 'thead', 'tbody', 'tr', 'th', 'td', 'img', 'figure', 'figcaption', 'hr'
  ],
  ALLOWED_ATTR: ['href', 'target', 'rel', 'src', 'alt', 'title', 'width', 'height', 'class'],
  ALLOW_DATA_ATTR: false
}

// a 标签强制安全跳转属性
DOMPurify.addHook('afterSanitizeAttributes', (node) => {
  if (node.tagName === 'A') {
    node.setAttribute('rel', 'noopener noreferrer')
    if (node.getAttribute('target') === '_blank') {
      node.setAttribute('rel', 'noopener noreferrer')
    }
  }
})

export function sanitizeHtml(html) {
  if (!html) return ''
  return DOMPurify.sanitize(html, CONFIG)
}

// v-safe-html 指令：v-html 的安全替代
export const safeHtmlDirective = {
  inserted(el, binding) {
    el.innerHTML = sanitizeHtml(binding.value)
  },
  update(el, binding) {
    if (binding.value !== binding.oldValue) {
      el.innerHTML = sanitizeHtml(binding.value)
    }
  }
}
