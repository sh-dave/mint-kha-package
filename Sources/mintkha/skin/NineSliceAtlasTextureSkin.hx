package mintkha.skin;

import mintkha.support.Rectangle;

class NineSliceAtlasTextureSkin {
	public var texture : kha.Image;
	public var x : Float;
	public var y : Float;
	public var w : Float;
	public var h : Float;
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
		//g.drawScaledSubImage(texture, x, y, w, h, controlX, controlY, controlWidth, controlHeight);

		var gx = grid.x;
		var gy = grid.y;
		var gw = grid.w;
		var gh = grid.h;

		g.drawScaledSubImage(texture, x, y, gx, gy, cx, cy, gx, gy);
		g.drawScaledSubImage(texture, x + gx + gw, y, w - gx - gw, gy, cx + cw - gw - gx, cy, w - gx - gw, gy);
	}

	public static function fromAtlasRegion( texture : kha.Image, atlasModel : mintkha.support.TextureAtlas.AtlasModel, id : String, grid : Rectangle ) : NineSliceAtlasTextureSkin {
		var region = Lambda.find(atlasModel.regions, function( region ) { return region.id == id; } );

		if (region == null) {
			trace('region "${id}" not found in atlas');
			return null;
		}

		return new NineSliceAtlasTextureSkin(texture, region.x, region.y, region.width, region.height, grid);
	}
}
