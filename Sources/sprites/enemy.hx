package sprites;

import kha.Color;

import n4.entities.NSprite;
import n4.NGame;

import n4.math.NPoint;
import n4.math.NVector;
import n4.math.NAngle;

class Enemy extends NSprite {
    private var speed:Float = 10;

    public function new(?X:Float = 0, ?Y:Float = 0) {
        // Define a constructor for Player matching the base constructor
        super(X, Y);

        // Create a 20x20 blue square as the image
		makeGraphic(40, 40, Color.Blue);

        // set movement drag (this is like friction)
        drag.set(80, 80);
        // set a maximum velocity
        maxVelocity.set(100, 100);

		angularVelocity = Math.PI / 2;
    }

    override public function update(dt:Float) {
        // call our movement function
        movement();
        // call the base update
        super.update(dt);
    }

    private function movement() {
        var player = Registry.PS.player;

        var posVelocity = new NVector(x, y).subtractPoint(new NPoint(player.x, player.y))
            .toVector().normalize().scale(speed).rotate(new NPoint(x, y), 180);
        velocity.add(posVelocity.x, posVelocity.y);
    }
}