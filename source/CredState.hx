package;

import djFlixel.fx.BoxFader;
import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.text.FlxTextField;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class CredState extends FlxState 
{
	private var creds:FlxText;
	private var boxFade:BoxFader;
	
	private var credTimer:Float = 5;
	private var curCredPlacement:Int = 0;
	
	override public function create():Void 
	{	
		creds = new FlxText(0, 0, FlxG.width - 24, "", 24);
		creds.alignment = FlxTextAlign.CENTER;
		add(creds);
		
		for (i in 0...credsArray[curCredPlacement].length)
		{
			creds.text += credsArray[curCredPlacement][i] + "\n";
		}
		
		creds.screenCenter();		
		
		boxFade = new BoxFader();
		boxFade.setColor(FlxColor.BLACK);
		boxFade.fadeOff();
		add(boxFade);
		
		FlxG.sound.playMusic("assets/music/randy.mp3");
		
		super.create();
	}
	
	override public function update(elapsed:Float):Void 
	{
		credTimer -= FlxG.elapsed;
		
		if (credTimer < 0)
		{
			credTimer = 6;
			
			boxFade.fadeColor(0xFF000000, null, function(){
				creds.text = "";
				curCredPlacement += 1;
				
				if (curCredPlacement >= credsArray.length)
					curCredPlacement = 0;
				
				for (i in 0...credsArray[curCredPlacement].length)
				{
					creds.text += credsArray[curCredPlacement][i] + "\n";
				}
				
				creds.screenCenter();
				boxFade.fadeOff();
			});	
		}
		
		if (FlxG.keys.anyJustPressed(["Z", "ENTER", "SPACE"]))
		{
			FlxG.sound.music.stop();
			
			FlxG.switchState(new MenuState());
		}
			
		var gamepad = FlxG.gamepads.lastActive;
			
		super.update(elapsed);
	}
	
	private var credsArray:Array<Dynamic> = 
	[
		[
			"BLUE DOOR THE GAME",
			"",
			"",
			"Created and Designed by:",
			"Brandon Driesse (@BrandyBuizel)",
			"Joe Varca",
			"",
			"",
			"Made with HaxeFlixel"
		],
		[
			"Inspired by 'Tapper' and 'Spongebob: Lights, Camera, Pants'",
			"",
			"Github Sourcecode: https://github.com/BrandyBuizel/BlueDoor"
		],
		[
			"FEATURING",
			"Ken",
			"Dylan",
			"Dustin"
		],
		[
			"SPECIAL THANKS",
			"Isaac & Logan",
			"",
			"For helping us sneak this game onto their custom cabinet"
		],
		[
			"SPECIAL THANKS",
			"Cameron Taylor (@ninja_muffin99)",
			"",
			"For additional coding assitance"
		],
		[
			"Press Z to go back"
		],
		[
			"Or listen to the Macho Man Rap on loop..."
		]
	];
	
}