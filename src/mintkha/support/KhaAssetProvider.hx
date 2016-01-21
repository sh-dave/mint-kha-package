package mintkha.support;

class KhaAssetProvider {
	public function new( assets : kha.Assets ) {
		this.assets = assets;
	}

	public function getAsset( id : String ) : _TextureAsset {
		var image = Reflect.field(assets, id);

		return {
			image : image,
			region : new Rectangle(0, 0, image.width, image.height),
		}
	}

	var assets : kha.Assets;
}
