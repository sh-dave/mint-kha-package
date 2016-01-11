package mintkha;

typedef LabelOptions = {
	var font : kha.Font;

	var defaultSkin : kha.Color;
	var highlightSkin : kha.Color;
	var downSkin : kha.Color;
	var disabledSkin : kha.Color;
}

class LabelRenderer extends G2Renderer {
    var label : mint.Label;
	var options : LabelOptions;

	var stateColor : kha.Color;

    public function new( rendering : G2Rendering, control : mint.Label ) {
        super(rendering, this.label = control);

		this.options = control.options.options;

		stateColor = options.defaultSkin;

        label.onmouseenter.listen(function(e, c) {
			stateColor = options.highlightSkin;
		});

        label.onmouseleave.listen(function(e, c) {
			stateColor = options.defaultSkin;
		});

        label.onmousedown.listen(function(e, c) {
			stateColor = options.downSkin;
		});

        label.onmouseup.listen(function(e, c) {
			stateColor = options.highlightSkin;
		});
    }

	override function renderG2( graphics : kha.graphics2.Graphics ) {
		var colorGuard = graphics.color;

		graphics.color = stateColor;
		graphics.font = options.font;
		graphics.fontSize = Std.int(label.options.text_size);

		graphics.drawString(label.text, control.x, control.y);

// debugArea
		//graphics.color = kha.Color.Magenta;
		//graphics.drawRect(control.x, control.y, control.w, control.h, 2);
// /debugArea

		graphics.color = colorGuard;
	}

    override function ondepth( depth : Float ) {
		this.depth = depth;
		khaRendering.sortByDepth();
    }
}
