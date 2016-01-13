package mintkha;

import mintkha.skin.LabelSkin;

typedef LabelOptions = {
	var defaultSkin : LabelSkin;
	var highlightSkin : LabelSkin;
	var downSkin : LabelSkin;
	var disabledSkin : LabelSkin;
}

class LabelRenderer extends G2Renderer {
    var label : mint.Label;
	var options : LabelOptions;

	// TODO (DK) 'setSkin' function?
	@:allow(mintkha)
	var stateSkin : LabelSkin;

    public function new( rendering : G2Rendering, control : mint.Label ) {
        super(rendering, this.label = control);

		this.options = control.options.options;

		stateSkin = options.defaultSkin;
    }

	override function renderG2( graphics : kha.graphics2.Graphics ) {
		// TODO (DK) is this check neccessary?
		if (stateSkin != null) {
			stateSkin.drawG2(graphics, control.x, control.y, control.w, control.h);
		}
	}

    override function ondepth( depth : Float ) {
		this.mydepth = depth;
		khaRendering.sortByDepth();
    }
}
