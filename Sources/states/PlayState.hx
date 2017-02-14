package states;

import n4.NGame;
import n4.NState;
import n4.effects.particles.NParticleEmitter;

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
}