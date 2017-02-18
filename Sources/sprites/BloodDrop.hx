package sprites;

import kha.Color;

import n4.entities.NSprite;
import n4.NGame;
import n4.math.NPoint;

import n4.util.NColorUtil;

import n4.effects.particles.NParticleEmitter;

class BloodDrop extends NSprite {
    public function new(?X:Float = 0, ?Y:Float = 0) {
        // Define a constructor for Player matching the base constructor
        super(X, Y);

        // Create a 20x20 blue square as the image
		makeGraphic(5, 5, Color.Red);
    }
}