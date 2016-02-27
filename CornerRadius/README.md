# CornerRadius

参考了这篇文章：[小心别让圆角成了你列表的帧数杀手](http://www.cocoachina.com/ios/20150803/12873.html)

都说 `cornerRadius` + `masksToBounds` 会导致离屏渲染，从而大幅度降低 `UITabelView` 滑动时的性能。

我做了一个 demo，在 cell 中放了四个 UIImageView，令我惊讶的是，使用不同的图片可能会导致不同的结果。有些图片设置圆角会导致离屏渲染，有些则不会。即使四个图片都导致了离屏渲染，也并没有看到滑动时帧数的下降。