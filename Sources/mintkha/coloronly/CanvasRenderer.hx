package mintkha.coloronly;

class CanvasRenderer extends G2BaseRenderer {
    var canvas : mint.Canvas;

    public function new( rendering : G2Rendering, control : mint.Canvas ) {
        super(rendering, this.canvas = control);
    }

    override function ondepth( depth : Float ) {
		this.depth = depth;
		khaRendering.sortByDepth();
    }
}
