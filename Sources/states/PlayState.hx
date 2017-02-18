package states;

import n4.NGame;
import n4.NState;
import n4.effects.particles.NParticleEmitter;

import n4.group.NTypedGroup;

import n4.util.NColorUtil;

import sprites.*;

class PlayState extends NState {
	public var player:Player;
	private var _enemies:NTypedGroup<Enemy>;

	private var frameCounter:Float = 0;
	private var enemyCounter:Int = 0;

	private var spawnTimer:Float = 0;
	private var spawnTime:Float = 1;

	public var emitter(default, null):NParticleEmitter;

    override public function create() {
		Registry.PS = this;
		
		player = new Player(NGame.width / 2, NGame.height / 2);
		add(player);

		_enemies = new NTypedGroup<Enemy>();
		add(_enemies);

		// for particles
		emitter = new NParticleEmitter(240);
		add(emitter);

        super.create();
    }

	override public function update(dt:Float) {
		super.update(dt);

		NGame.overlap(_enemies, _enemies, enemyColision);

		if (player.x < 0) player.x = 0;
		if (player.x > NGame.width - player.width) player.x = NGame.width - player.width;
		if (player.y < 0) player.y = 0;
		if (player.y > NGame.height - player.height) player.y = NGame.height - player.height;

		_enemies.forEachActive(function (enemy) {
			if (enemy.x < 0) enemy.x = 0;
			if (enemy.x > NGame.width - enemy.width) enemy.x = NGame.width - enemy.width;
			if (enemy.y < 0) enemy.y = 0;
			if (enemy.y > NGame.height - enemy.height) enemy.y = NGame.height - enemy.height;
		});

		spawnTimer += dt;
		if (spawnTimer >= spawnTime) {
			spawnTimer = 0;
			
			if (_enemies.memberCount < Math.random() * 3 + 5) {
				var shenemy = new Enemy(NGame.width / 10, NGame.height * 9 / 10); // don't ask about shenemy
				_enemies.add(shenemy);
			}

			enemyCounter++;
		}
	}

	function enemyColision(b:Enemy, p:Enemy) {
		// hit player
		if (b == p) return;

		p.x = (Math.random() * 0.8 + 0.1) * NGame.width;
		p.y = (Math.random() * 0.8 + 0.1) * NGame.height;
		for (i in 0...35) {
			Registry.PS.emitter
				.emitSquare(b.x, b.y, 9, NParticleEmitter.velocitySpread(100, 
						p.velocity.x / 2,
						p.velocity.y / 2),
					NColorUtil.randCol(0.3, 0.3, 0.3),
					0.8
				);
		}
		for (i in 0...27) {
			Registry.PS.emitter
				.emitSquare(b.x, b.y, 9, NParticleEmitter.velocitySpread(75, 
						p.velocity.x / 2,
						p.velocity.y / 2),
					NColorUtil.randCol(1, 0.1, 0),
					0.8
				);
		}

		enemyCounter -= 2;

		b.destroy();
		p.destroy();
	}
}