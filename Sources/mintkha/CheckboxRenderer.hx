package mintkha;

import mintkha.Skin;

typedef CheckboxOptions = {
// button
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

        checkbox.onmouseenter.listen(function(e, c) {
			stateSkin = checkbox.state ? options.selectedHighlightSkin : options.highlightSkin;
		});

        checkbox.onmouseleave.listen(function(e, c) {
			stateSkin = checkbox.state ? options.selectedDefaultSkin : options.defaultSkin;
		});

        checkbox.onmousedown.listen(function(e, c) {
			stateSkin = checkbox.state ? options.selectedDownSkin : options.downSkin;
		});

        checkbox.onmouseup.listen(function(e, c) {
			stateSkin = checkbox.state ? options.selectedHighlightSkin : options.highlightSkin;
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
