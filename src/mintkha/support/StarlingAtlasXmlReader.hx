package mintkha.support;

import mintkha.support.TextureAtlas.AtlasModel;
import mintkha.support.TextureAtlas.RegionModel;

class StarlingAtlasXmlReader {
	public static function read( xml : Xml ) : AtlasModel {
		var root = xml.firstElement();

		if (root.nodeName != 'TextureAtlas') {
			trace('not a starling texture atlas');
			return null;
		}

		var regions = new Array<RegionModel>();

		for (child in root.elements()) {
			switch (child.nodeName) {
				case 'SubTexture': regions.push(readSubTexture(child));
				default: trace('unhandled node ${child.nodeName}');
			}
		}

		return {
			regions : regions
		}
	}

	static function readSubTexture( xml : Xml ) : RegionModel {
		return {
			id : _string(xml, 'name'),
			x : _float(xml, 'x'),
			y : _float(xml, 'y'),
			width : _float(xml, 'width'),
			height : _float(xml, 'height'),
			//pivotX : _float(xml, 'pivotX'),
			//pivotY : _float(xml, 'pivotY'),
			//frameX : _float(xml, 'frameX'),
			//frameY : _float(xml, 'frameY'),
			//frameWidth : _float(xml, 'frameWidth'),
			//frameHeight : _float(xml, 'frameHeight'),
			//rotated : xml.get('rotated') == 'true',
		}
	}

	static inline function _string( xml : Xml, name : String ) : String {
		return xml.get(name);
	}

	static inline function _float( xml : Xml, name : String ) : Float {
		return Std.parseFloat(xml.get(name));
	}
}
