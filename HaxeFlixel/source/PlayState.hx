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
	private var _player:Player;
	
	override public function create():Void 
	{	
		var floor = new FlxSprite(0, 0);
		floor.loadGraphic(AssetPaths.floor__png);
		floor.setGraphicSize(960);
		floor.updateHitbox();
		add(floor);
		
		_player = new Player(200, 200);
		
		super.create();
	}
	
	override public function update(elapsed:Float):Void 
	{
		//DEBUG leave PlayState
		if (FlxG.keys.anyJustPressed(["Q", "ESCAPE"])){
			FlxG.switchState(new TitleState());
		}
		
		super.update(elapsed);
	}
}