package mintkha.coloronly;

typedef ButtonOptions = {
// button
	var defaultSkin : kha.Color;
	var highlightSkin : kha.Color;
	var downSkin : kha.Color;
	var disabledSkin : kha.Color;

// label
	var labelFont : kha.Font;
	var defaultLabelSkin : kha.Color;
	var highlightLabelSkin : kha.Color;
	var downLabelSkin : kha.Color;
	var disabledLabelSkin : kha.Color;
}

class ButtonRenderer extends G2BaseRenderer {
    var button : mint.Button;

	var options : ButtonOptions;

	var stateColor : kha.Color;

    public function new( rendering : G2Rendering, control : mint.Button ) {
        super(rendering, this.button = control);

		this.options = control.options.options;

		stateColor = options.defaultSkin;

        button.onmouseenter.listen(function(e, c) {
			stateColor = options.highlightSkin;
		});

        button.onmouseleave.listen(function(e, c) {
			stateColor = options.defaultSkin;
		});

        button.onmousedown.listen(function(e, c) {
			stateColor = options.downSkin;
		});

        button.onmouseup.listen(function(e, c) {
			stateColor = options.highlightSkin;
		});
    }

	override function renderG2( graphics : kha.graphics2.Graphics ) {
		var colorGuard = graphics.color;

		graphics.color = stateColor;

		kha.graphics2.GraphicsExtension.fillPolygon(graphics, control.x, control.y, [
			new kha.math.Vector2(0, 0), new kha.math.Vector2(control.w, 0), new kha.math.Vector2(control.w, control.h), new kha.math.Vector2(0, control.h)
		]);

		graphics.color = colorGuard;
	}

    override function ondepth( depth : Float ) {
		this.depth = depth;
		khaRendering.sortByDepth();
    }
}
