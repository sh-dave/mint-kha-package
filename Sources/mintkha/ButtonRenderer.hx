package mintkha;

import mintkha.Skin;
import mintkha.skin.LabelSkin;

typedef ButtonOptions = {
	var defaultSkin : Skin;
	var highlightSkin : Skin;
	var downSkin : Skin;
	var disabledSkin : Skin;
}

class ButtonRenderer extends G2Renderer {
    var button : mint.Button;

	var options : ButtonOptions;

	var stateSkin : Skin;

    public function new( rendering : G2Rendering, control : mint.Button ) {
        super(rendering, this.button = control);

		this.options = control.options.options;

		stateSkin = options.defaultSkin;

		// TODO (DK) casting is crap, find a better design

        button.onmouseenter.listen(function(e, c) {
			if (button.isfocused) {
				stateSkin = options.downSkin;
				cast (button.label.renderer, LabelRenderer).stateSkin = control.options.options.label.downSkin;
			} else {
				stateSkin = options.highlightSkin;
				cast (button.label.renderer, LabelRenderer).stateSkin = control.options.options.label.highlightSkin;
			}
		});

        button.onmouseleave.listen(function(e, c) {
			if (button.isfocused) {
				stateSkin = options.highlightSkin;
				cast (button.label.renderer, LabelRenderer).stateSkin = control.options.options.label.highlightSkin;
			} else {
				stateSkin = options.defaultSkin;
				cast (button.label.renderer, LabelRenderer).stateSkin = control.options.options.label.defaultSkin;
			}
		});

        button.onmousedown.listen(function(e, c) {
			stateSkin = options.downSkin;
			cast (button.label.renderer, LabelRenderer).stateSkin = control.options.options.label.downSkin;
		});

        button.onmouseup.listen(function(e, c) {
			if (button.ishovered) {
				stateSkin = options.highlightSkin;
				cast (button.label.renderer, LabelRenderer).stateSkin = control.options.options.label.highlightSkin;
			} else {
				stateSkin = options.defaultSkin;
				cast (button.label.renderer, LabelRenderer).stateSkin = control.options.options.label.defaultSkin;
			}
		});
    }

	override function renderG2( graphics : kha.graphics2.Graphics ) {
		stateSkin.drawG2(graphics, control.x, control.y, control.w, control.h);
	}

    override function ondepth( depth : Float ) {
		this.mydepth = depth;
		khaRendering.sortByDepth();
    }
}
