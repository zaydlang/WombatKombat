package sprites;

import kha.Color;

import n4.entities.NSprite;
import n4.NGame;

import n4.math.NPoint;
import n4.math.NVector;
import n4.math.NAngle;

import n4.util.NColorUtil;

import n4.effects.particles.NParticleEmitter;

class Enemy extends NSprite {
    private var speed:Float = 10;
    private var speedInaccuracy:Float = 2;

    public function new(?X:Float = 0, ?Y:Float = 0) {
        // Define a constructor for Player matching the base constructor
        super(X, Y);

        // Create a 20x20 blue square as the image
		makeGraphic(40, 40, Color.Blue);

        // set movement drag (this is like friction)
        drag.set(5, 5);
        // set a maximum velocity
        maxVelocity.set(200, 200);

		angularVelocity = Math.PI / 2;
    }

    override public function update(dt:Float) {
        // call our movement function
        movement();
        // call the base update
        super.update(dt);

        Registry.PS.emitter
            .emitSquare(x + 20, y + 20, 16, NParticleEmitter.velocitySpread(50),
				NColorUtil.randCol(0, 255, 0),
				0.3
			);
    }

    private function movement() {
        var player = Registry.PS.player;

        // move toward player
        var posVelocity = new NVector(x, y).subtractPoint(new NPoint(player.x, player.y))
            .toVector().normalize().scale(Math.random() * speedInaccuracy + speed)
            .rotate(new NPoint(0, 0), 180);
        velocity.add(posVelocity.x, posVelocity.y);
    }
}