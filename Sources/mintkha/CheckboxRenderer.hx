package mintkha;

import mintkha.Skin;

typedef CheckboxOptions = {
	var defaultSkin : Skin;
	var highlightSkin : Skin;
	var downSkin : Skin;
	var disabledSkin : Skin;

	var selectedDefaultSkin : Skin;
	var selectedHighlightSkin : Skin;
	var selectedDownSkin : Skin;
	var selectedDisabledSkin : Skin;

// label
	//var labelFont : kha.Font;
	//var defaultLabelSkin : kha.Color;
	//var highlightLabelSkin : kha.Color;
	//var downLabelSkin : kha.Color;
	//var disabledLabelSkin : kha.Color;
}

private enum State {
	None;
	Hover;
	Down;
}
class CheckboxRenderer extends G2Renderer {
    var checkbox : mint.Checkbox;

	var options : CheckboxOptions;

	var stateSkin : Skin;
	@:isVar var state(default, set) : State;

    public function new( rendering : G2Rendering, control : mint.Checkbox ) {
        super(rendering, this.checkbox = control);

		this.options = control.options.options;

		stateSkin = options.defaultSkin;

        checkbox.onmouseenter.listen(function(e, c) {
			state = Hover;
		});

        checkbox.onmouseleave.listen(function(e, c) {
			state = None;
		});

        checkbox.onmousedown.listen(function(e, c) {
			state = Down;
		});

        checkbox.onmouseup.listen(function(e, c) {
			state = Hover;
		});

		checkbox.onchange.listen(function( newState, oldState )  {
			updateStateSkin();
		});
    }

	function updateStateSkin() {
		switch (state) {
			case None: stateSkin = checkbox.state ? options.selectedDefaultSkin : options.defaultSkin;
			case Hover: stateSkin = checkbox.state ? options.selectedHighlightSkin : options.highlightSkin;
			case Down: stateSkin = checkbox.state ? options.selectedDownSkin : options.downSkin;
		}
	}

	inline function set_state( value : State ) : State {
		state = value;
		updateStateSkin();
		return state;
	}

	override function renderG2( graphics : kha.graphics2.Graphics ) {
		stateSkin.drawG2(graphics, control.x, control.y, control.w, control.h);
	}

    override function ondepth( depth : Float ) {
		this.mydepth = depth;
		khaRendering.sortByDepth();
    }
}
