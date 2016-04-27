package mintkha.renderer;

typedef ButtonRendererOptions = {
	var defaultSkin : Skin;
	@:optional var highlightSkin : Skin;
	@:optional var downSkin : Skin;
	@:optional var disabledSkin : Skin;

	@:optional var highlightMode : HighlightMode;
}
