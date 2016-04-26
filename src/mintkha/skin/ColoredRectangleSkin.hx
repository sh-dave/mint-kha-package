package mintkha.skin;

// TODO (DK) remove skin altogether?
class ColoredRectangleSkin implements Skin {
	var color : kha.Color;

	public function new( color : kha.Color ) {
		this.color = color;
	}

	public function drawG2( g : kha.graphics2.Graphics, cx : Float, cy : Float, cw : Float, ch : Float ) {
		var colorGuard = g.color;

		g.color = color;

		// TODO (DK) remove allocs
		kha.graphics2.GraphicsExtension.fillPolygon(g, cx, cy, [
			new kha.math.Vector2(0, 0), new kha.math.Vector2(cw, 0), new kha.math.Vector2(cw, ch), new kha.math.Vector2(0, ch)
		]);

		g.color = colorGuard;
	}

	public function show( cx : Float, cy : Float, cw : Float, ch : Float ) { }
	public function hide() {}
}
