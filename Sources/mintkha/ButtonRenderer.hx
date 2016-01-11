package mintkha;

import mintkha.Skin;

typedef ButtonOptions = {
// button
	var defaultSkin : Skin;
	var highlightSkin : Skin;
	var downSkin : Skin;
	var disabledSkin : Skin;

// label
	var labelFont : kha.Font;
	var defaultLabelSkin : kha.Color;
	var highlightLabelSkin : kha.Color;
	var downLabelSkin : kha.Color;
	var disabledLabelSkin : kha.Color;
}

class ButtonRenderer extends G2Renderer {
    var button : mint.Button;

	var options : ButtonOptions;

	var stateSkin : Skin;

    public function new( rendering : G2Rendering, control : mint.Button ) {
        super(rendering, this.button = control);

		this.options = control.options.options;

		stateSkin = options.defaultSkin;

        button.onmouseenter.listen(function(e, c) {
			stateSkin = options.highlightSkin;
		});

        button.onmouseleave.listen(function(e, c) {
			stateSkin = options.defaultSkin;
		});

        button.onmousedown.listen(function(e, c) {
			stateSkin = options.downSkin;
		});

        button.onmouseup.listen(function(e, c) {
			stateSkin = options.highlightSkin;
		});
    }

	override function renderG2( graphics : kha.graphics2.Graphics ) {
		stateSkin.drawG2(graphics, control.x, control.y, control.w, control.h);
	}

    override function ondepth( depth : Float ) {
		this.depth = depth;
		khaRendering.sortByDepth();
    }
}
