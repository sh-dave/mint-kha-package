package mintkha.skin;

import mintkha.support.Offset;
import mintkha.support.Rectangle;

class NinesliceSubImageSkin {
	var texture : kha.Image;
	var x : Float;
	var y : Float;
	var w : Float;
	var h : Float;
	var grid : Rectangle;
	var offset : Offset;

	public function new( texture : kha.Image, x : Float, y : Float, w : Float, h : Float, grid : Rectangle, ?offset : Offset = null ) {
		this.texture = texture;
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
		this.grid = grid;
		this.offset = offset;
	}

	public function drawG2( g : kha.graphics2.Graphics, cx : Float, cy : Float, cw : Float, ch : Float ) {
		var leftWidth = grid.x;
		var centerWidth = grid.w;
		var rightWidth = w - grid.w - grid.x;
		var topHeight = grid.y;
		var middleHeight = grid.h;
		var bottomHeight = h - grid.h - grid.y;
		var oh = offset != null ? offset.horizontal : 0;
		var ov = offset != null ? offset.vertical : 0;

		var lrx = cx + oh; // left region x
		var mrx = cx + oh + leftWidth; // middle region x
		var rrx = cx + oh + cw - rightWidth; // right region x
		var mrw = cw - leftWidth - rightWidth; // middle region width
		var mrh = ch - topHeight - bottomHeight - ov; // middle region height
		var mry = cy + ov + topHeight; // middle region y
		var msy = y + topHeight; // middle source y
		var bsy = y + topHeight + middleHeight; // bottom source y
		var bry = cy + ch - bottomHeight; // bottom region y

		g.drawScaledSubImage(texture, x,							y,		leftWidth,		topHeight, 		lrx,	cy + ov,	leftWidth,		topHeight);
		g.drawScaledSubImage(texture, x + leftWidth,				y,		centerWidth, 	topHeight, 		mrx,	cy + ov,	mrw,			topHeight);
		g.drawScaledSubImage(texture, x + leftWidth + centerWidth, 	y,		rightWidth,		topHeight, 		rrx,	cy + ov, 	rightWidth,		topHeight);

		g.drawScaledSubImage(texture, x,							msy,	leftWidth,		middleHeight, 	lrx,	mry, 		leftWidth,		mrh);
		g.drawScaledSubImage(texture, x + leftWidth,				msy,	centerWidth, 	middleHeight, 	mrx,	mry,		mrw,			mrh);
		g.drawScaledSubImage(texture, x + leftWidth + centerWidth, 	msy,	rightWidth,		middleHeight, 	rrx,	mry, 		rightWidth,		mrh);

		g.drawScaledSubImage(texture, x,							bsy,	leftWidth,		bottomHeight, 	lrx,	bry,		leftWidth,		bottomHeight);
		g.drawScaledSubImage(texture, x + leftWidth,				bsy,	centerWidth,	bottomHeight, 	mrx,	bry,		mrw,			bottomHeight);
		g.drawScaledSubImage(texture, x + leftWidth + centerWidth, 	bsy,	rightWidth,		bottomHeight, 	rrx,	bry,		rightWidth,		bottomHeight);
	}
}
