package mintkha;

import mintkha.skin.NinesliceSubImageSkin;
import mintkha.skin.SubImageSkin;
import mintkha.support.Offset;
import mintkha.support.Rectangle;
import mintkha.support.TextureAtlas.AtlasModel;

class ThemeTools {
	public static function subImageSkin( texture : kha.Image, atlasModel : AtlasModel, id : String, ?offset : Offset = null ) : SubImageSkin {
		var region = Lambda.find(atlasModel.regions, function( region ) { return region.id == id; } );

		if (region == null) {
			trace('region "${id}" not found in atlas');
			return null;
		}

		return new SubImageSkin(texture, region.x, region.y, region.width, region.height, offset);
	}

	public static function ninesliceSubImageSkin( texture : kha.Image, atlasModel : AtlasModel, id : String, grid : Rectangle, ?offset : Offset = null ) : NinesliceSubImageSkin {
		var region = Lambda.find(atlasModel.regions, function( region ) { return region.id == id; } );

		if (region == null) {
			trace('region "${id}" not found in atlas');
			return null;
		}

		return new NinesliceSubImageSkin(texture, region.x, region.y, region.width, region.height, grid, offset);
	}
}
