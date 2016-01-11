package mintkha.support;

class Rectangle {
	public var x : Float;
	public var y : Float;
	public var w : Float;
	public var h : Float;

	public function new( ?x = 0.0, ?y = 0.0, ?w = 0.0, ?h = 0.0 ) {
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
	}
}