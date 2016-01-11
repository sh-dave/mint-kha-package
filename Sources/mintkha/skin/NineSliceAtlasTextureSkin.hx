package mintkha.skin;

import mintkha.support.Offset;
import mintkha.support.Rectangle;

class NineSliceAtlasTextureSkin {
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

		g.drawScaledSubImage(texture, x,							y,		leftWidth,		topHeight, 		cx + oh,					cy + ov, 				leftWidth,						topHeight);
		g.drawScaledSubImage(texture, x + leftWidth,				y,		centerWidth, 	topHeight, 		cx + oh + leftWidth,		cy + ov,				cw - leftWidth - rightWidth,	topHeight);
		g.drawScaledSubImage(texture, x + leftWidth + centerWidth, 	y,		rightWidth,		topHeight, 		cx + oh + cw - rightWidth,	cy + ov, 				rightWidth,						topHeight);

		var msy = y + topHeight; // middle source y

		g.drawScaledSubImage(texture, x,							msy,	leftWidth,		middleHeight, 	cx + oh,					cy + ov + topHeight, 	leftWidth,						ch - topHeight - bottomHeight - ov);
		g.drawScaledSubImage(texture, x + leftWidth,				msy,	centerWidth, 	middleHeight, 	cx + oh + leftWidth,		cy + ov + topHeight,	cw - leftWidth - rightWidth,	ch - topHeight - bottomHeight - ov);
		g.drawScaledSubImage(texture, x + leftWidth + centerWidth, 	msy,	rightWidth,		middleHeight, 	cx + oh + cw - rightWidth,	cy + ov + topHeight, 	rightWidth,						ch - topHeight - bottomHeight - ov);

		var bsy = y + topHeight + middleHeight; // bottom source y

		g.drawScaledSubImage(texture, x,							bsy,	leftWidth,		bottomHeight, 	cx + oh,					cy + ch - bottomHeight,	leftWidth,						bottomHeight);
		g.drawScaledSubImage(texture, x + leftWidth,				bsy,	centerWidth,	bottomHeight, 	cx + oh + leftWidth,		cy + ch - bottomHeight,	cw - leftWidth - rightWidth,	bottomHeight);
		g.drawScaledSubImage(texture, x + leftWidth + centerWidth, 	bsy,	rightWidth,		bottomHeight, 	cx + oh + cw - rightWidth,	cy + ch - bottomHeight,	rightWidth,						bottomHeight);
	}
}
