package mintkha.renderer;

import mint.core.Macros.*;
import mintkha.Skin;

class ButtonRenderer extends G2Renderer {
    var button : mint.Button;

	var stateSkin(default, set) : Skin;
	var defaultSkin : Skin;
	var highlightSkin : Skin;
	var downSkin : Skin;
	var disabledSkin : Skin;

	var highlightMode : HighlightMode;

    public function new( rendering : G2Rendering, control : mint.Button ) {
        super(rendering, this.button = control);

		var options : ButtonRendererOptions = control.options.options;
		stateSkin = defaultSkin = options.defaultSkin;

		highlightSkin = def(options.highlightSkin, defaultSkin);
		downSkin = def(options.downSkin, defaultSkin);
		disabledSkin = def(options.disabledSkin, defaultSkin);

		highlightMode = def(options.highlightMode, mintkha.renderer.internal.Defaults.highlightMode);

		// TODO (DK) casting is crap, find a better design?
		var labelRenderer = cast (button.label.renderer, LabelRenderer);

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
				switch (highlightMode) {
					case HighlightMode.HighlightWhileActive: {
						stateSkin = highlightSkin;
						labelRenderer.setStateSkin(Highlight);
					}
					case HighlightMode.DownWhileActive: {
						stateSkin = downSkin;
						labelRenderer.setStateSkin(Down);
					}
				}
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

	inline function set_stateSkin( skin : Skin ) : Skin {
		if (stateSkin != null) {
			stateSkin.hide();
		}

		skin.show(button.x, button.y, button.w, button.h);

		return stateSkin = skin;
	}

	override function renderG2( graphics : kha.graphics2.Graphics ) {
		if (!visible) {
			return;
		}

		stateSkin.drawG2(graphics, control.x, control.y, control.w, control.h);
	}

    override function ondepth( depth : Float ) {
		this.mydepth = depth;
		khaRendering.sortByDepth();
    }

    //override function onbounds() {
        ////visual.transform.pos.set_xy(control.x, control.y);
        ////visual.geometry_quad.resize_xy(control.w, control.h);
    //}

    override function ondestroy() {
        //visual.destroy();
        //visual = null;
    }

    override function onclip( disable : Bool, x : Float, y : Float, w : Float, h : Float) {
        //if (disable) {
            //visual.clip_rect = null;
        //} else {
            //visual.clip_rect = new luxe.Rectangle(_x, _y, _w, _h);
        //}
    }

    override function onvisible( visible : Bool ) {
		this.visible = visible;
    }
}
