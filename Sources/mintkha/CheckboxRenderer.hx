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

class CheckboxRenderer extends G2Renderer {
    var checkbox : mint.Checkbox;

	var options : CheckboxOptions;

	var stateSkin : Skin;

    public function new( rendering : G2Rendering, control : mint.Checkbox ) {
        super(rendering, this.checkbox = control);

		this.options = control.options.options;

		stateSkin = options.defaultSkin;

		// (DK) we need to register after internal checkbox events, so isfocused works properly
		checkbox.oncreate.listen(checkbox_onCreateHandler);
    }

	function checkbox_onCreateHandler() {
        checkbox.onmouseenter.listen(function(e, c) {
			if (checkbox.isfocused) {
				stateSkin = checkbox.state ? options.selectedDownSkin : options.downSkin;
				//cast (checkbox.label.renderer, LabelRenderer).stateSkin = control.options.options.label.downSkin;
			} else {
				stateSkin = checkbox.state ? options.selectedHighlightSkin : options.highlightSkin;
				//cast (checkbox.label.renderer, LabelRenderer).stateSkin = control.options.options.label.highlightSkin;
			}
		});

        checkbox.onmouseleave.listen(function(e, c) {
			if (checkbox.isfocused) {
				stateSkin = checkbox.state ? options.selectedHighlightSkin : options.highlightSkin;
				//cast (checkbox.label.renderer, LabelRenderer).stateSkin = control.options.options.label.highlightSkin;
			} else {
				stateSkin = checkbox.state ? options.selectedDefaultSkin : options.defaultSkin;
				//cast (checkbox.label.renderer, LabelRenderer).stateSkin = control.options.options.label.defaultSkin;
			}
		});

        checkbox.onmousedown.listen(function(e, c) {
			stateSkin = checkbox.state ? options.selectedDownSkin : options.downSkin;
			//cast (checkbox.label.renderer, LabelRenderer).stateSkin = control.options.options.label.downSkin;
		});

        checkbox.onmouseup.listen(function(e, c) {
			if (checkbox.ishovered) {
				stateSkin = checkbox.state ? options.selectedHighlightSkin : options.highlightSkin;
				//cast (checkbox.label.renderer, LabelRenderer).stateSkin = control.options.options.label.highlightSkin;
			} else {
				stateSkin = checkbox.state ? options.selectedDefaultSkin : options.defaultSkin;
				//cast (checkbox.label.renderer, LabelRenderer).stateSkin = control.options.options.label.defaultSkin;
			}
		});

		checkbox.onchange.listen(checkbox_onChangeHandler);

		checkbox_onChangeHandler(checkbox.state, false); // (DK) initial state
	}

	function checkbox_onChangeHandler( newState, _ ) {
		// TODO (DK) what if we f.ex. hover over the element while it's state changes?

		if (checkbox.state) {
			stateSkin = options.selectedDefaultSkin;
		} else {
			stateSkin = options.defaultSkin;
		}
	}

	override function renderG2( graphics : kha.graphics2.Graphics ) {
		stateSkin.drawG2(graphics, control.x, control.y, control.w, control.h);
	}

    override function ondepth( depth : Float ) {
		this.mydepth = depth;
		khaRendering.sortByDepth();
    }
}
