package mintkha;

class G2Renderer extends mint.render.Render {
    var khaRendering : G2Rendering;

	public var depth : Float;

	public function new( rendering : G2Rendering, control : mint.Control ) {
		super(this.khaRendering = rendering, control);

		khaRendering.elements.push(this);
	}

	@:allow(mintkha)
	function renderG2( graphics : kha.graphics2.Graphics ) {
	}
}
