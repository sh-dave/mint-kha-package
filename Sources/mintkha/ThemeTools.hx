package mintkha;

import mintkha.skin.NineSliceAtlasTextureSkin;
import mintkha.support.Offset;
import mintkha.support.Rectangle;
import mintkha.support.TextureAtlas.AtlasModel;

class ThemeTools {
	public static function nineSliceSkin( texture : kha.Image, atlasModel : AtlasModel, id : String, grid : Rectangle, ?offset : Offset = null ) : NineSliceAtlasTextureSkin {
		var region = Lambda.find(atlasModel.regions, function( region ) { return region.id == id; } );

		if (region == null) {
			trace('region "${id}" not found in atlas');
			return null;
		}

		return new NineSliceAtlasTextureSkin(texture, region.x, region.y, region.width, region.height, grid, offset);
	}
}
