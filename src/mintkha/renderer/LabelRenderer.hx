package mintkha.renderer;

typedef LabelOptions = {
	var defaultSkin : LabelSkin;
	var highlightSkin : LabelSkin;
	var downSkin : LabelSkin;
	var disabledSkin : LabelSkin;
}

class LabelRenderer extends G2Renderer {
    var label : mint.Label;

	var stateSkin : LabelSkin;

	var defaultSkin : LabelSkin;
	var highlightSkin : LabelSkin;
	var downSkin : LabelSkin;
	var disabledSkin : LabelSkin;

    public function new( rendering : G2Rendering, control : mint.Label ) {
        super(rendering, this.label = control);

		var options : LabelOptions = control.options.options;

		stateSkin = defaultSkin = options.defaultSkin;
		highlightSkin = options.highlightSkin;
		downSkin = options.downSkin;
		disabledSkin = options.disabledSkin;
    }

	// TODO (DK) @:allow points to bad design?
	@:allow(mintkha)
	function setStateSkin( state : mintkha.ControlState ) {
		stateSkin = switch (state) {
			case None: defaultSkin;
			case Highlight: highlightSkin;
			case Down: downSkin;
			case Disabled: disabledSkin;
		}
	}

	override function renderG2( graphics : kha.graphics2.Graphics ) {
		if (!visible) {
			return;
		}

		// TODO (DK) is this check neccessary?
		if (stateSkin != null) {
			stateSkin.text = label.text;
			stateSkin.fontSize = Std.int(label.options.text_size);
			stateSkin.drawG2(graphics, control.x, control.y, control.w, control.h);
		}
	}

    override function onvisible( visible : Bool ) {
        this.visible = visible;
    }

    override function ondepth( depth : Float ) {
		this.mydepth = depth;
		khaRendering.sortByDepth();
    }
}
