package mintkha.support;

typedef RegionModel = {
	var id : String;
	var x : Float;
	var y : Float;
	var width : Float;
	var height : Float;
	//var pivotX : Float;
	//var pivotY : Float;
	//var frameX : Float;
	//var frameY : Float;
	//var frameWidth : Float;
	//var frameHeight : Float;
	//var rotated : Bool;
}

typedef AtlasModel = {
	var regions : Array<RegionModel>;
}
