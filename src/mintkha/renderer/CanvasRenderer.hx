package mintkha.renderer;

class CanvasRenderer extends G2Renderer {
    var canvas : mint.Canvas;

    public function new( rendering : G2Rendering, control : mint.Canvas ) {
        super(rendering, this.canvas = control);
    }

    override function ondestroy() {
        //visual.drop();
        //visual = null;
    }

    override function onbounds() {
        //visual.transform.pos.set_xy(control.x, control.y);
        //visual.resize_xy(control.w, control.h);
    }

    override function onclip( disable : Bool, x : Float, y : Float, w : Float, h : Float ) {
        //if(_disable) {
            //visual.clip_rect = null;
        //} else {
            //visual.clip_rect = new luxe.Rectangle(x, y, w, h);
        //}
    }

    override function onvisible( visible : Bool ) {
        this.visible = visible;
    }

    override function ondepth( depth : Float ) {
		this.mydepth = depth;
		khaRendering.sortByDepth();
    }
}
