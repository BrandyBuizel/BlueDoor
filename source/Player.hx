package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Player extends FlxSprite 
{
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.spr_player__png, true, 16, 16);

		var frameRate:Int = 6;
		animation.add("u", [0, 1, 2], frameRate);
		drag.x = drag.y = 200;
		
		width = 8;
		offset.x = 4;
		height = 8;
		offset.y = 6;

		FlxG.log.add("added player");
	}
}