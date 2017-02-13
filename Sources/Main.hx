package;

import n4.NGame;
import states.IntroState;

class Main {
    public static function main() {
        NGame.init("Wombat Combat", 1024, 768, IntroState);
    }
}