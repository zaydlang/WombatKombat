package states;

import n4.NGame;
import n4.NState;
import n4.effects.particles.NParticleEmitter;

import n4.util.NColorUtil;

import sprites.*;

class PlayState extends NState {
	public var player:Player;
	private var enemy:Enemy;
	public var emitter(default, null):NParticleEmitter;

    override public function create() {
		Registry.PS = this;

		player = new Player(NGame.width / 2, NGame.height / 2);
		add(player);
		enemy = new Enemy(NGame.width / 3, NGame.height / 3);
		add(enemy);
		enemy = new Enemy(NGame.width * 2 / 3, NGame.height * 2 / 3);
		add(enemy);

		// for particles
		emitter = new NParticleEmitter(240);
		add(emitter);

        super.create();
    }

	override public function update(dt:Float) {
		super.update(dt);

		if (player.x < 0) player.x = 0;
		if (player.x > NGame.width - player.width) player.x = NGame.width - player.width;
		if (player.y < 0) player.y = 0;
		if (player.y > NGame.height - player.height) player.y = NGame.height - player.height;

		if (enemy.x < 0) enemy.x = 0;
		if (enemy.x > NGame.width - enemy.width) enemy.x = NGame.width - enemy.width;
		if (enemy.y < 0) enemy.y = 0;
		if (enemy.y > NGame.height - enemy.height) enemy.y = NGame.height - enemy.height;
	}

	static function enemyColision(b:Enemy, p:Enemy) {
		// hit player
		p.x = (Math.random() * 0.8 + 0.1) * NGame.width;
		p.y = (Math.random() * 0.8 + 0.1) * NGame.height;
		for (i in 0...15) {
			Registry.PS.emitter
				.emitSquare(b.x, b.y, 9, NParticleEmitter.velocitySpread(100, 
						p.velocity.x / 2,
						p.velocity.y / 2),
					NColorUtil.randCol(0.3, 0.3, 0.3),
					0.8
				);
		}
		for (i in 0...9) {
			Registry.PS.emitter
				.emitSquare(b.x, b.y, 9, NParticleEmitter.velocitySpread(75, 
						p.velocity.x / 2,
						p.velocity.y / 2),
					NColorUtil.randCol(1, 0.1, 0),
					0.8
				);
		}

		b.destroy();
		p.destroy();
	}
}