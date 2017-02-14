package states;

import n4.NGame;
import n4.NState;

import sprites.*;

class PlayState extends NState {
	public var player:Player;
	private var enemy:Enemy;

    override public function create() {
		Registry.PS = this;

		player = new Player(NGame.width / 2, NGame.height / 2);
		add(player);
		enemy = new Enemy(NGame.width / 3, NGame.height / 3);
		add(enemy);

        super.create();
    }
}