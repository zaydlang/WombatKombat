package states;

import kha.Assets;

import n4.NGame;
import n4e.ui.NEText;
import n4.util.NAxes;

import n4.NState;

class MenuState extends NState {
    override public function create() {
        // TODO: Add some stuff to our menu state

		//Display title
		var titleText = new NEText(0, NGame.height / 3, "Wombat Kombat", 60);
		titleText.screenCenter(NAxes.X);
		add(titleText);
	
		// Direct the user
		var howToStartText = new NEText(0, NGame.height * 0.5, "Press RETURN to play", 30);
		howToStartText.screenCenter(NAxes.X);
		add(howToStartText);

		// Little splash screen I guess
		var madeWithText = new NEText(0, 0, "made with n4 engine", 32);
		madeWithText.x = NGame.width - madeWithText.width * 1.2;
		madeWithText.y = NGame.height - madeWithText.height * 1.4;
		add(madeWithText);

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