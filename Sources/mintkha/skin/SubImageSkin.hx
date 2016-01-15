package mintkha.skin;

import mintkha.support.Offset;

class SubImageSkin {
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

	public function drawG2( g : kha.graphics2.Graphics, controlX : Float, controlY : Float, controlWidth : Float, controlHeight : Float ) {
		var oh = offset != null ? offset.horizontal : 0;
		var ov = offset != null ? offset.vertical : 0;

		g.drawScaledSubImage(texture, x, y, w, h, controlX + oh, controlY + ov, controlWidth, controlHeight);
	}
}
