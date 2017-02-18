package states;

import kha.Assets;

import n4.NGame;
import n4e.ui.NEText;
import n4.util.NAxes;

import n4.NState;

class GameOverState extends NState {
	private var score:Int;

	public function new(Score:Int) {
		super();
		score = Score;
	}

    override public function create() {
        // TODO: Add some stuff to our menu state

		//Display title
		var titleText = new NEText(0, NGame.height / 3, "Game Over", 60);
		titleText.screenCenter(NAxes.X);
		add(titleText);
	
		//Display score
		var titleText = new NEText(0, NGame.height * 2 / 5, "Score: " + score, 60);
		titleText.screenCenter(NAxes.X);
		add(titleText);

		// Direct the user
		var howToStartText = new NEText(0, NGame.height * 0.5, "Press RETURN to play", 30);
		howToStartText.screenCenter(NAxes.X);
		add(howToStartText);

        super.create();
    }

	override public function update(dt:Float) {
        if (NGame.keys.justPressed(["ENTER"])) {
            // start game
            NGame.switchState(new PlayState());
        }

        super.update(dt);
    }
}