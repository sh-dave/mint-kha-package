package mintkha.skin;

import mintkha.support.Offset;

// (DK) https://github.com/sh-dave/SpriterHaxeEngine/tree/dev
class SpriterHaxeEngineEntitySkin {
	var engine : spriter.engine.SpriterEngine;
	var entity : spriter.engine.Spriter;
	var offset : Offset;
	var entityId : String;
	var animationId : String;

	public function new( engine : spriter.engine.SpriterEngine, entityId : String, animationId : String, ?offset : Offset ) {
		this.engine = engine;
		this.offset = offset;
		this.entityId = entityId;
		this.animationId = animationId;
		this.offset = offset;
	}

	public function drawG2( g : kha.graphics2.Graphics, cx : Float, cy : Float, cw : Float, ch : Float ) {
		var oh = offset != null ? offset.horizontal : 0;
		var ov = offset != null ? offset.vertical : 0;
		entity.set(cx + oh, cy + ov);
	}

	public function show( cx : Float, cy : Float, cw : Float, ch : Float ) {
		entity = engine.addSpriter(entityId);
		entity.playAnim(animationId);
		entity.set(cx, cy);
	}

	public function hide() {
		engine.removeSpriter(entityId);
	}
}
