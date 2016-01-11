package mintkha;

class CanvasRenderer extends G2Renderer {
    var canvas : mint.Canvas;

    public function new( rendering : G2Rendering, control : mint.Canvas ) {
        super(rendering, this.canvas = control);
    }

    override function ondepth( depth : Float ) {
		this.mydepth = depth;
		khaRendering.sortByDepth();
    }
}
