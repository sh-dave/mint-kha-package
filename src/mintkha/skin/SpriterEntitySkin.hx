package mintkha.skin;

import mintkha.support.Offset;

// (DK) https://github.com/wighawag/spriter
class SpriterEntitySkin {
	var engine : spriter.Spriter;
	var scheduler : kha.Scheduler;
	var entity : spriter.EntityInstance;
	var offset : Offset;
	var entityId : String;
	var animationId : String;
	var lastTime = 0.0;
	var updateId = -1;

	public function new( engine : spriter.Spriter, entityId : String, animationId : String, scheduler : kha.Scheduler, ?offset : Offset ) {
		this.engine = engine;
		this.scheduler = scheduler;
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
		if (entity != null) {
			trace('entity already created');
			return;
		}

		entity = engine.createEntity(entityId);
		entity.play(animationId);
		entity.set(cx, cy);

		lastTime = scheduler.time();
		updateId = scheduler.addTimeTask(update, 0, 1 / 60);
	}

	function update() {
		var now = scheduler.time();
		var delta = now - lastTime;
		lastTime = now;
		entity.step(delta);
	}

	public function hide() {
		if (entity == null) {
			trace('entity already destroyed');
			return;
		}

		//engine.removeSpriter(entityId);

		entity = null;
		scheduler.removeTimeTask(updateId);
		updateId = -1;
	}
}
