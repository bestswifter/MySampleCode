# CornerRadius

都说 `cornerRadius` + `masksToBounds` 会导致离屏渲染，从而大幅度降低 `UITabelView` 滑动时的性能。

我做了一个 demo，在 cell 中放了四个 UIImageView，但是在 Instument 中检测时并没有发现离屏渲染，滑动时帧数也未见下降。