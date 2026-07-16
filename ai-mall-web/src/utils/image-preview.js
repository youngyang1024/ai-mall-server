import { ImagePreview } from 'vant'

// 评论图等大图预览的统一配置：右上角关闭 X + 点击图片/遮罩可关闭
export function previewImages(images, startPosition = 0) {
  ImagePreview({
    images,
    startPosition,
    closeable: true,
    closeOnClickImage: true,
    closeOnClickOverlay: true
  })
}
