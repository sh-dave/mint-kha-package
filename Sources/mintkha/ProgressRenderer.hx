package mintkha;

// TODO (DK) implements with skin
typedef ProgressOptions = {
	var fillSkin : kha.Color;
	var backgroundSkin : kha.Color;

	//var disabledBackgroundSkin : kha.Color;
	//var disabledFillSkin : kha.Color;

	var paddingTop : Float;
	var paddingRight : Float;
	var paddingBottom : Float;
	var paddingLeft : Float;
}

class ProgressRenderer extends G2Renderer {
    var progress : mint.Progress;
	var options : ProgressOptions;

    public function new( rendering : G2Rendering , control : mint.Progress ) {
        super(rendering, this.progress = control);

		this.options = control.options.options;
    }

	override function renderG2( graphics : kha.graphics2.Graphics ) {
		var colorGuard = graphics.color;

// background skin
		graphics.color = options.backgroundSkin;

		kha.graphics2.GraphicsExtension.fillPolygon(graphics, control.x, control.y, [
			new kha.math.Vector2(0, control.h),
			new kha.math.Vector2(control.w, control.h),
			new kha.math.Vector2(control.w, 0),
		]);

// fill skin
		graphics.color = options.fillSkin;

		var pl = options.paddingLeft;
		var pt = options.paddingTop;
		var pr = options.paddingRight;
		var pb = options.paddingBottom;

		var maxWidth = control.w - pr - pl;
		var actualWidth = maxWidth * progress.progress;

		kha.graphics2.GraphicsExtension.fillPolygon(graphics, control.x + pl, control.y + pt, [
			new kha.math.Vector2(0, control.h - pb - pt),
			new kha.math.Vector2(actualWidth, control.h - pb - pt),
			new kha.math.Vector2(actualWidth, 0),
		]);

		graphics.color = colorGuard;
	}

    override function ondepth( depth : Float ) {
		this.mydepth = depth;
		khaRendering.sortByDepth();
    }
}
