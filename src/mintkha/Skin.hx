package mintkha;

typedef Skin = {
	function drawG2( g : kha.graphics2.Graphics, x : Float, y : Float, w : Float, h : Float ) : Void;

	function show() : Void;
	function hide() : Void;

	//@:optional var show : Void -> Void;
	//@:optional var hide : Void -> Void;
}
