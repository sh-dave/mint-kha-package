package mintkha;

typedef ProgressOptions = {
	var backgroundSkin : Skin;
	var fillSkin : Skin;

	//var disabledBackgroundSkin : Skin;
	//var disabledFillSkin : Skin;

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
        options.backgroundSkin.drawG2(graphics, control.x, control.y, control.w, control.h);
        
		var pl = options.paddingLeft;
		var pt = options.paddingTop;
		var pr = options.paddingRight;
		var pb = options.paddingBottom;

		var maxWidth = control.w - pr - pl;
		var actualWidth = maxWidth * progress.progress;
        
        options.fillSkin.drawG2(graphics, control.x + pl, control.y + pt, actualWidth, control.h - pt - pb);
	}

    override function ondepth( depth : Float ) {
		this.mydepth = depth;
		khaRendering.sortByDepth();
    }
}
