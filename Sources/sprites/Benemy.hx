package sprites;

import kha.Color;

import n4.entities.NSprite;
import n4.NGame;

import n4.math.NPoint;
import n4.math.NVector;
import n4.math.NAngle;

import n4.util.NColorUtil;

import n4.effects.particles.NParticleEmitter;

class EnemyStage3 extends Enemy {
    private var speedInaccuracy:Float = Math.random();
    private var speed:Float = 5;

    public function new(?X:Float = 0, ?Y:Float = 0) {
        
        // Define a constructor for Player matching the base constructor
        super(X, Y);

        type = 3;

        // Create a 20x20 blue square as the image
		makeGraphic(60, 60, Color.fromFloats(0.9, 0.9, 0.1));

        // set movement drag (this is like friction)
        drag.set(Math.random() * 5 + 30, Math.random() * 5 + 30);
        // set a maximum velocity
        maxVelocity.set(Math.random() * 50 + 275, Math.random() * 50 + 275);

		angularVelocity = Math.PI * 3;
    }

    override public function update(dt:Float) {
        // call our movement function
        movement();
        // call the base update
        super.update(dt);

        Registry.PS.emitter
            .emitSquare(x + width / 2, y + width / 2, 16, NParticleEmitter.velocitySpread(width * 2),
				NColorUtil.randCol(0.9, 0.9, 0.1, 0.1),
				0.3
			);
        
        if (Math.random() < 0.1) makeGraphic(Std.int(width - 1), Std.int(height - 1), Color.fromFloats(0.9, 0.9, 0.1));

        if (width < 30) {
            for (i in 0...30)
            Registry.PS.emitter
                .emitSquare(x + 2.5, y + 2.5, 16, NParticleEmitter.velocitySpread(width * 2),
		 	    NColorUtil.randCol(0.9, 0.9, 0.1, 0.1),
			 	0.3
			);

            destroy();

            var sloomoo = new Penemy(x + width / 2, y + width / 2);
            Registry.PS._enemies.add(sloomoo);
        }
    }

    private function movement() {
        var player = Registry.PS.player;

        // move toward player
        var posVelocity = new NVector(x, y).subtractPoint(new NPoint(player.x, player.y))
            .toVector().normalize().scale(5 * speedInaccuracy + speed)
            .rotate(new NPoint(0, 0), 180);
        velocity.add(posVelocity.x, posVelocity.y);
    }

	private function acquireTarget():Shenemy {
		var target:Shenemy = null;
		var minDistance = 2;
		return target;
	}
}