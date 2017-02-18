package states;

import n4.NGame;
import n4.NState;
import n4.effects.particles.NParticleEmitter;
import n4e.ui.NEText;
import n4.util.NAxes;

import n4.group.NTypedGroup;

import n4.util.NColorUtil;

import sprites.*;

class PlayState extends NState {
	public var player:Player;
	public var _enemies:NTypedGroup<Enemy>;

	public var enemiesKilled:Int = 0;
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

		/*var ScoreText = new NEText(0, NGame.height / 10, "Score: " + enemiesKilled, 30);
		ScoreText.screenCenter(NAxes.X);
		add(ScoreText);*/
		
		NGame.overlap(_enemies, _enemies, enemyColision);
		NGame.overlap(_enemies, player, playerColision);

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
			if (enemyCounter < Math.random() * 3 + (enemiesKilled < 10 ? 5
			 : 15)) {
				if (enemiesKilled < 9 || Math.random() >= ((enemiesKilled - 10) * 0.075) + 0.25) {
					var shenemy = new EnemyStage3(NGame.width * (Math.random() > 0.5 ? 1 : 9) / 10, 
						NGame.height * (Math.random() > 0.5 ? 1 : 9) / 10); // don't ask about shenemy
					_enemies.add(shenemy);
				} else {
					var shenemy = new Penemy(NGame.width * (Math.random() > 0.5 ? 1 : 9) / 10, 
						NGame.height * (Math.random() > 0.5 ? 1 : 9) / 10); // don't ask about shenemy
					_enemies.add(shenemy); 
				}
			
			enemyCounter++;
			}
		}
	}

	function playerColision(b:Enemy, p:Player) {
		// hit player

		p.x = (Math.random() * 0.8 + 0.1) * NGame.width;
		p.y = (Math.random() * 0.8 + 0.1) * NGame.height;
		for (i in 0...35) {
			Registry.PS.emitter
				.emitSquare(b.x, b.y, 9, NParticleEmitter.velocitySpread(100, 
						p.velocity.x / 2,
						p.velocity.y / 2),
					NColorUtil.randCol(0.3, 0.3, 0.3, 0.9),
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

		enemiesKilled += 1;

		b.destroy();
		if (!player.spedUp) {
			if (!player.spedUp) NGame.switchState(new GameOverState(enemiesKilled));
			p.destroy();
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
					NColorUtil.randCol(0.3, 0.3, 0.3, 0.9),
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

		for (i in 0...50) {
			var spread = NParticleEmitter.velocitySpread(30);
			var shlood = new BloodDrop(b.x + spread.x, b.y + spread.y);
			add(shlood); 
		}

		b.destroy();
		p.destroy();

		if (b.type == 3) {
			var sloomoo = new Penemy(b.x + b.width / 2, b.y + b.width / 2);
            _enemies.add(sloomoo);
		}

		if (p.type == 3) {
			var poomoo = new Penemy(p.x + p.width / 2, p.y + p.width / 2);
            _enemies.add(poomoo);
		}

		enemiesKilled += 2;
	}
}