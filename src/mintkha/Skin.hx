package mintkha;

// TODO (DK) split into G2 / G4 / GX skin and pass kha.Canvas instead of kha.graphicsX.Graphics?
interface Skin {
	function drawG2( g : kha.graphics2.Graphics, x : Float, y : Float, w : Float, h : Float ) : Void;

	function show( cx : Float, cy : Float, cw : Float, ch : Float ) : Void;
	function hide() : Void;
}
