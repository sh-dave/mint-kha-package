package mintkha.skin;

class AtlasTextureSkin {
	public var texture : kha.Image;
	public var x : Float;
	public var y : Float;
	public var w : Float;
	public var h : Float;

	public function new( texture : kha.Image, x : Float, y : Float, w : Float, h : Float ) {
		this.texture = texture;
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
	}

	public function drawG2( g : kha.graphics2.Graphics, controlX : Float, controlY : Float, controlWidth : Float, controlHeight : Float ) {
		g.drawScaledSubImage(texture, x, y, w, h, controlX, controlY, controlWidth, controlHeight);
	}

	public static function fromAtlasRegion( texture : kha.Image, atlasModel : mintkha.support.TextureAtlas.AtlasModel, id : String ) : AtlasTextureSkin {
		var region = Lambda.find(atlasModel.regions, function( region ) { return region.id == id; } );

		if (region == null) {
			trace('region "${id}" not found in atlas');
			return null;
		}

		return new AtlasTextureSkin(texture, region.x, region.y, region.width, region.height);
	}
}
