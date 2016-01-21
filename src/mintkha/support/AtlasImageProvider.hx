package mintkha.support;

import mintkha.support.TextureAtlas.AtlasModel;
import spriter.library.KhaG2Library.TextureAsset;
import spriter.library.KhaG2Library.Rectangle;

class AtlasImageProvider {
	public function new( image : kha.Image, atlas : AtlasModel ) {
		this.image = image;
		this.atlas = atlas;
	}

	public function getAsset( id : String ) : TextureAsset {
		var fixed = id.substring(0, id.lastIndexOf('.'));
		var region = Lambda.find(atlas.regions, function( region ) { return region.id == fixed; } );

		if (region == null) {
			trace('region "${id}" not found in atlas');
			return null;
		}

		return {
			image : image,
			region : new Rectangle(region.x, region.y, region.width, region.height)
		}
	}

	var image : kha.Image;
	var atlas : AtlasModel;
}
