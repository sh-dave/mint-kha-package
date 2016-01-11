package mintkha.skin;

import mintkha.support.Rectangle;

class NineSliceAtlasTextureSkin {
	var texture : kha.Image;
	var x : Float;
	var y : Float;
	var w : Float;
	var h : Float;
	var grid : Rectangle;

	public function new( texture : kha.Image, x : Float, y : Float, w : Float, h : Float, grid : Rectangle  ) {
		this.texture = texture;
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
		this.grid = grid;
	}

	public function drawG2( g : kha.graphics2.Graphics, cx : Float, cy : Float, cw : Float, ch : Float ) {
		var leftWidth = grid.x;
		var centerWidth = grid.w;
		var rightWidth = w - grid.w - grid.x;
		var topHeight = grid.y;
		var middleHeight = grid.h;
		var bottomHeight = h - grid.h - grid.y;

		g.drawScaledSubImage(texture, x,							y,		leftWidth,		topHeight, 		cx,						cy, 					leftWidth,						topHeight);
		g.drawScaledSubImage(texture, x + leftWidth,				y,		centerWidth, 	topHeight, 		cx + leftWidth,			cy,						cw - leftWidth - rightWidth,	topHeight);
		g.drawScaledSubImage(texture, x + leftWidth + centerWidth, 	y,		rightWidth,		topHeight, 		cx + cw - rightWidth,	cy, 					rightWidth,						topHeight);

		var msy = y + topHeight; // middle source y

		g.drawScaledSubImage(texture, x,							msy,	leftWidth,		middleHeight, 	cx,						cy + topHeight, 		leftWidth,						ch - topHeight - bottomHeight);
		g.drawScaledSubImage(texture, x + leftWidth,				msy,	centerWidth, 	middleHeight, 	cx + leftWidth,			cy + topHeight,			cw - leftWidth - rightWidth,	ch - topHeight - bottomHeight);
		g.drawScaledSubImage(texture, x + leftWidth + centerWidth, 	msy,	rightWidth,		middleHeight, 	cx + cw - rightWidth,	cy + topHeight, 		rightWidth,						ch - topHeight - bottomHeight);

		var bsy = y + topHeight + middleHeight; // bottom source y

		g.drawScaledSubImage(texture, x,							bsy,	leftWidth,		bottomHeight, 	cx,						cy + ch - bottomHeight, leftWidth,						bottomHeight);
		g.drawScaledSubImage(texture, x + leftWidth,				bsy,	centerWidth,	bottomHeight, 	cx + leftWidth,			cy + ch - bottomHeight,	cw - leftWidth - rightWidth,	bottomHeight);
		g.drawScaledSubImage(texture, x + leftWidth + centerWidth, 	bsy,	rightWidth,		bottomHeight, 	cx + cw - rightWidth,	cy + ch - bottomHeight, rightWidth,						bottomHeight);
	}
}
