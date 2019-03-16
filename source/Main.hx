package;

import flixel.FlxGame;
import openfl.display.Sprite;
import com.newgrounds.*;
import com.newgrounds.components.*;

class Main extends Sprite
{
	public static var fisrtRun:Bool = true;
	
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, MenuState, 1));
	}
}
