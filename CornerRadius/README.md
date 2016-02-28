# CornerRadius

这是我的博客中：[iOS高效添加圆角效果实战讲解](http://www.jianshu.com/p/f970872fdc22)一文的 demo，据说配合着代码看博客效果更佳！

## 2016.2.28 A

不存在 iOS9 优化，只是圆角不够多，还没有影响性能。一旦超过某个临界值（iPhone6 上估计是 20多）就会大幅度降低 fps。

如果 `UIImageView` 的 width 和 height 相同，在某些情况下（可能是图片带有 alpha 通道），系统可能会自动优化，这时候就不会出现离屏渲染。

## 2016.2.27 Q
参考了这篇文章：[小心别让圆角成了你列表的帧数杀手](http://www.cocoachina.com/ios/20150803/12873.html)

都说 `cornerRadius` + `masksToBounds` 会导致离屏渲染，从而大幅度降低 `UITabelView` 滑动时的性能。

我做了一个 demo，在 cell 中放了四个 UIImageView，令我惊讶的是，使用不同的图片可能会导致不同的结果。有些图片设置圆角会导致离屏渲染，有些则不会。即使四个图片都导致了离屏渲染，也并没有看到滑动时帧数的下降。