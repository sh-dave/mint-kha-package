package mintkha;

class G2Rendering extends mint.render.Rendering {
	@:allow(mintkha)
	var elements = new Array<G2Renderer>();

	public function renderG2( graphics : kha.graphics2.Graphics ) {
		for (element in elements) {
			element.renderG2(graphics);
		}
	}

    override function get<T : mint.Control, T1>( type : Class<T>, control : T ) : T1 {
        return cast switch(type) {
            case mint.Canvas: new mintkha.CanvasRenderer(this, cast control);
            case mint.Label: new mintkha.LabelRenderer(this, cast control);
            case mint.Button: new mintkha.ButtonRenderer(this, cast control);
            //case mint.Image: new mint.render.luxe.Image(this, cast control);
            //case mint.List: new mint.render.luxe.List(this, cast control);
            //case mint.Scroll: new mint.render.luxe.Scroll(this, cast control);
            //case mint.Panel: new mint.render.luxe.Panel(this, cast control);
            //case mint.Checkbox: new mint.render.luxe.Checkbox(this, cast control);
            //case mint.Window: new mint.render.luxe.Window(this, cast control);
            //case mint.TextEdit: new mint.render.luxe.TextEdit(this, cast control);
            //case mint.Dropdown: new mint.render.luxe.Dropdown(this, cast control);
            //case mint.Slider: new mint.render.luxe.Slider(this, cast control);
            case mint.Progress: new mintkha.ProgressRenderer(this, cast control);
            case _: null;
        }
    }

	// TODO (DK) lazy in renderG2 or something instead of immediate?
	public function sortByDepth() {
		elements.sort(function( l, r ) {
			return l.depth < r.depth ? -1 : 1;
		});

		var xxx : Int;
		xxx = 666;
	}
}
