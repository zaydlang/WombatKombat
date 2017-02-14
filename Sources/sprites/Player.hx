package sprites;

import kha.Color;

import n4.entities.NSprite;
import n4.NGame;
import n4.math.NPoint;

class Player extends NSprite {
    private var speed:Float = 10;

    public function new(?X:Float = 0, ?Y:Float = 0) {
        // Define a constructor for Player matching the base constructor
        super(X, Y);

        // Create a 20x20 blue square as the image
		makeGraphic(40, 40, Color.Red);

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
    }

    private function movement() {
        var up:Bool = false;
        var down:Bool = false;
        var left:Bool = false;
        var right:Bool = false;

        up = NGame.keys.pressed(["UP", "W"]);
        down = NGame.keys.pressed(["DOWN", "S"]);
        left = NGame.keys.pressed(["LEFT", "A"]);
        right = NGame.keys.pressed(["RIGHT", "D"]);

        if (up || down || left || right)
        {
            // Cancel double directions
            if (up && down)
                up = down = false;
            if (left && right)
                left = right = false;
            var mA = 0;
            // movement angle; this will keep total speed uniform
            // even when moving diagonally
            if (left || right || up || down)
            {
                if (up)
                {
                    mA = -90;
                    if (left)
                    {
                        mA -= 45;
                    }
                    if (right)
                    {
                        mA += 45;
                    }
                }
                else if (down)
                {
                    mA = 90;
                    if (left)
                    {
                        mA += 45;
                    }
                    if (right)
                    {
                        mA -= 45;
                    }
                }
                else if (left)
                {
                    mA = 180;
                }
                else if (right)
                {
                    mA = 0;
                }
            }
            var movementVel = new NPoint(speed, 0);
            velocity.addPoint(movementVel.rotate(new NPoint(0, 0), mA));
        }
    }
}