package mintkha.renderer;

import mint.core.Macros.*;
import mintkha.Skin;

class CheckboxRenderer extends G2Renderer {
    var checkbox : mint.Checkbox;

	var stateSkin : Skin;

	var defaultSkin : Skin;
	var highlightSkin : Skin;
	var downSkin : Skin;
	var disabledSkin : Skin;

	var selectedDefaultSkin : Skin;
	var selectedHighlightSkin : Skin;
	var selectedDownSkin : Skin;
	var selectedDisabledSkin : Skin;

	var highlightMode : HighlightMode;

    public function new( rendering : G2Rendering, control : mint.Checkbox ) {
        super(rendering, this.checkbox = control);

		var options : CheckboxRendererOptions = control.options.options;

		highlightMode = def(options.highlightMode, mintkha.renderer.internal.Defaults.highlightMode);

		defaultSkin = options.defaultSkin;
		highlightSkin = def(options.highlightSkin, defaultSkin);
		downSkin = def(options.downSkin, defaultSkin);
		disabledSkin = def(options.disabledSkin, defaultSkin);

		selectedDefaultSkin = def(options.selectedDefaultSkin, defaultSkin);
		selectedHighlightSkin = def(options.selectedHighlightSkin, defaultSkin);
		selectedDownSkin = def(options.selectedDownSkin, defaultSkin);
		selectedDisabledSkin = def(options.selectedDisabledSkin, defaultSkin);

		// (DK) we need to register after internal checkbox events, so isfocused works properly
		checkbox.oncreate.listen(checkbox_onCreateHandler);
    }

	function checkbox_onCreateHandler() {
		checkbox.oncreate.remove(checkbox_onCreateHandler);

// TODO (DK) unregister
        checkbox.onmouseenter.listen(checkbox_onMouseEnterHandler);
        checkbox.onmouseleave.listen(checkbox_onMouseLeaveHandler);
        checkbox.onmousedown.listen(checkbox_onMouseDownHandler);
        checkbox.onmouseup.listen(checkbox_onMouseUpHandler);
		checkbox.onchange.listen(checkbox_onChangeHandler);
// TODO (DK) /unregister

		checkbox_onChangeHandler(checkbox.state, false); // (DK) inject initial state
	}

	function checkbox_onMouseUpHandler( e, c ) {
		if (checkbox.ishovered) {
			stateSkin = checkbox.state ? selectedHighlightSkin : highlightSkin;
		} else {
			stateSkin = checkbox.state ? selectedDefaultSkin : defaultSkin;
		}
	}

	function checkbox_onMouseDownHandler( e, c ) {
		stateSkin = checkbox.state ? selectedDownSkin : downSkin;
	}

	function checkbox_onMouseEnterHandler( e, c ) {
		if (checkbox.isfocused) {
			stateSkin = checkbox.state ? selectedDownSkin : downSkin;
		} else {
			stateSkin = checkbox.state ? selectedHighlightSkin : highlightSkin;
		}
	}

	function checkbox_onMouseLeaveHandler( e, c ) {
		if (checkbox.isfocused) {
			switch (highlightMode) {
				case HighlightMode.DownWhileActive: {
					stateSkin = checkbox.state ? selectedDownSkin : downSkin;
				}
				case HighlightMode.HighlightWhileActive: {
					stateSkin = checkbox.state ? selectedHighlightSkin : highlightSkin;
				}
			}
		} else {
			stateSkin = checkbox.state ? selectedDefaultSkin : defaultSkin;
		}
	}

	function checkbox_onChangeHandler( newState, _ ) {
		// TODO (DK)
		//	-what todo if we f.ex. hover over the element while it's state changes externally?
		//	-copy code from the eventhandlers in checkbox_onCreateHandler()?

		if (checkbox.state) {
			stateSkin = selectedDefaultSkin;
		} else {
			stateSkin = defaultSkin;
		}
	}

	override function renderG2( graphics : kha.graphics2.Graphics ) {
		if (!visible) {
			return;
		}

		stateSkin.drawG2(graphics, control.x, control.y, control.w, control.h);
	}

    override function onvisible( visible : Bool ) {
        this.visible = visible;
    }

    override function ondepth( depth : Float ) {
		this.mydepth = depth;
		khaRendering.sortByDepth();
    }
}
