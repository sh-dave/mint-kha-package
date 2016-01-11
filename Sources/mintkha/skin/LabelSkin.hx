package mintkha.skin;

import mintkha.support.Offset;

class LabelSkin {
	var color : kha.Color;
	var font : kha.Font;
	var fontSize : Int;
	var text : String;
	var offset : Offset;

	public function new( color : kha.Color, font : kha.Font, fontSize : Int, text : String, ?offset : Offset = null ) {
		this.color = color;
		this.font = font;
		this.fontSize = fontSize;
		this.text = text;
		this.offset = offset;
	}

	public function drawG2( g : kha.graphics2.Graphics, cx : Float, cy : Float, cw : Float, ch : Float ) {
		var colorGuard = g.color;

		var oh = offset != null ? offset.horizontal : 0;
		var ov = offset != null ? offset.vertical : 0;

		g.color = color;
		g.font = font;
		g.fontSize = fontSize;

		g.drawString(text, cx + oh, cy + ov);

// debugArea
		//graphics.color = kha.Color.Magenta;
		//graphics.drawRect(control.x, control.y, control.w, control.h, 2);
// /debugArea

		g.color = colorGuard;
	}
}
