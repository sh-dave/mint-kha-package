package mintkha.skin;

import mintkha.support.Offset;

// TODO (DK) don't use kha.Image directly, but an AtlasWrapper
class SubImageSkin implements Skin {
	var texture : kha.Image;
	var x : Float;
	var y : Float;
	var w : Float;
	var h : Float;
	var offset : Offset;

	public function new( texture : kha.Image, x : Float, y : Float, w : Float, h : Float, ?offset : Offset ) {
		this.texture = texture;
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
		this.offset = offset;
	}

	public function drawG2( g : kha.graphics2.Graphics, cx : Float, cy : Float, cw : Float, ch : Float ) {
		var oh = offset != null ? offset.horizontal : 0;
		var ov = offset != null ? offset.vertical : 0;

		g.drawScaledSubImage(texture, x, y, w, h, cx + oh, cy + ov, cw, ch);
	}

	public function show( cx : Float, cy : Float, cw : Float, ch : Float ) {}
	public function hide() {}
}
