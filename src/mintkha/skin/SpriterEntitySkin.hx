package mintkha.skin;

import mintkha.support.Offset;

class SpriterEntitySkin {
	var engine : spriter.engine.SpriterEngine;
	var entity : spriter.engine.Spriter;
	var offset : Offset;

	var entityId : String;
	var animationId : String;

	//public var show : Void -> Void;
	//public var hide : Void -> Void;

	public function new( engine : spriter.engine.SpriterEngine, entityId : String, animationId : String, ?offset : Offset ) {
		this.engine = engine;
		this.offset = offset;
		this.entityId = entityId;
		this.animationId = animationId;
		this.offset = offset;

		//show = showImpl;
		//hide = hideImpl;
	}

	public function drawG2( g : kha.graphics2.Graphics, controlX : Float, controlY : Float, controlWidth : Float, controlHeight : Float ) {
		var oh = offset != null ? offset.horizontal : 0;
		var ov = offset != null ? offset.vertical : 0;
		entity.set(controlX + oh, controlY + ov);
	}

	public function show() {
		entity = engine.addSpriter(entityId);
		entity.playAnim(animationId);
	}

	public function hide() {
		engine.removeSpriter(entityId);
	}

}
