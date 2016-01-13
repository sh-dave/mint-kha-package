package mintkha;

typedef TrackSliderOptions = {
}

class TrackSliderRenderer extends G2Renderer {
	var slider : mint.TrackSlider;
	//var options : TrackSliderOptions;

	public function new( rendering : G2Rendering, control : mint.TrackSlider ) {
		super(rendering, this.slider = control);
		//this.options = control.options.options;
	}

	// TODO (DK) sort order: handle above track
    //override function ondepth( depth : Float ) {
		//this.mydepth = depth;
		//khaRendering.sortByDepth();
    //}
}