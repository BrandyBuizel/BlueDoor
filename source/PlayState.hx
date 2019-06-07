package;

import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.addons.util.PNGEncoder;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.system.replay.FlxReplay;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import openfl.display.BitmapData;
import openfl.utils.ByteArray;
import openfl.utils.Object;

class PlayState extends FlxState
{
	private var playerLane:Int = 1;
	
	override public function create():Void 
	{
		playerMovement();
		
		super.create();
	}
	
	private function playerMovement():Void
	{
		switch (playerLane)
		{
			case 1:
				//set player pos to lane 1
			case 2:
				//set player pos to lane 2
			case 3:
				//set player pos to lane 3
			default:
				//set player pos value to lane 1 value
		}
	}
}