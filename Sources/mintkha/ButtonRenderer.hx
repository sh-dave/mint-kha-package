package mintkha;

import mint.core.Macros.*;
import mintkha.Skin;

typedef ButtonOptions = {
	var defaultSkin : Skin;
	@:optional var highlightSkin : Skin;
	@:optional var downSkin : Skin;
	@:optional var disabledSkin : Skin;
}

class ButtonRenderer extends G2Renderer {
    var button : mint.Button;

	var stateSkin : Skin;

	var defaultSkin : Skin;
	var highlightSkin : Skin;
	var downSkin : Skin;
	var disabledSkin : Skin;

    public function new( rendering : G2Rendering, control : mint.Button ) {
        super(rendering, this.button = control);

		var options : ButtonOptions = control.options.options;
		stateSkin = defaultSkin = options.defaultSkin;

		highlightSkin = def(options.highlightSkin, defaultSkin);
		downSkin = def(options.downSkin, defaultSkin);
		disabledSkin = def(options.disabledSkin, defaultSkin);

		// TODO (DK) casting is crap, find a better design

		var labelRenderer : mintkha.LabelRenderer = cast button.label.renderer;

        button.onmouseenter.listen(function(e, c) {
			if (button.isfocused) {
				stateSkin = downSkin;
				labelRenderer.setStateSkin(Down);
			} else {
				stateSkin = highlightSkin;
				labelRenderer.setStateSkin(Highlight);
			}
		});

        button.onmouseleave.listen(function(e, c) {
			if (button.isfocused) {
				stateSkin = downSkin;
				labelRenderer.setStateSkin(Down);
			} else {
				stateSkin = defaultSkin;
				labelRenderer.setStateSkin(None);
			}
		});

        button.onmousedown.listen(function(e, c) {
			stateSkin = downSkin;
			labelRenderer.setStateSkin(Down);
		});

        button.onmouseup.listen(function(e, c) {
			if (button.ishovered) {
				stateSkin = highlightSkin;
				labelRenderer.setStateSkin(Highlight);
			} else {
				stateSkin = defaultSkin;
				labelRenderer.setStateSkin(None);
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
