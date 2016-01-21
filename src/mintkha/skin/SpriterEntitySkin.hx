package mintkha.skin;

import mintkha.support.Offset;

class SpriterEntitySkin {
	var spriter : spriter.engine.Spriter
	var offset : Offset;

	public function new( spriter : spriter.engine.Spriter, ?offset : Offset ) {
		this.spriter = spriter;
		this.offset = offset;
	}

	public function drawG2( g : kha.graphics2.Graphics, controlX : Float, controlY : Float, controlWidth : Float, controlHeight : Float ) {
		var oh = offset != null ? offset.horizontal : 0;
		var ov = offset != null ? offset.vertical : 0;

		// g.drawScaledSubImage(texture, x, y, w, h, controlX + oh, controlY + ov, controlWidth, controlHeight);
	}
}
