package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Player extends FlxSprite 
{
	private var playerLane:Int = 1;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y);
		loadGraphic(AssetPaths.spr_player__png, true, 16, 16);
		updateHitbox();
		FlxG.log.add("added player");
	}
		
	public function playerMovement():Void
	{
		switch (playerLane){
			case 1:
				//set player pos to lane 1
			case 2:
				//set player pos to lane 2
			case 3:
				//set player pos to lane 3
			default:
				//set player pos value to lane 1 value
		}
		
		if (FlxG.keys.anyPressed([W, A, S, D, "UP", "DOWN", "LEFT", "RIGHT"]))
		{
			if (FlxG.keys.anyPressed(["S", "DOWN"]))
			{
				
			}
			if (FlxG.keys.anyPressed(["W", "UP"]))
			{
				
			}
		}
	}
}