package mintkha.skin;

import mintkha.support.Offset;

class ColoredLabelSkin implements LabelSkin {
	public var font : kha.Font;
	public var fontSize(null, default) : Int;
	public var text(null, default) : String;

	var color : kha.Color;
	var offset : Offset;

	public function new( color : kha.Color, font : kha.Font, ?offset : Offset = null ) {
		this.color = color;
		this.font = font;
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
		//g.color = kha.Color.Magenta;
		//g.drawRect(cx, cy, cw, ch, 2);
// /debugArea

		g.color = colorGuard;
	}

	public function show( cx : Float, cy : Float, cw : Float, ch : Float ) {
	}

	public function hide() {
	}
}
