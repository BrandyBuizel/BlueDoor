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
			FlxG.switchState(new MenuState());
		}
			
		var gamepad = FlxG.gamepads.lastActive;
			
		super.update(elapsed);
	}
	
	private function mobileShit():Void
	{
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed) 
			{
				FlxG.switchState(new MenuState());
			}
		}
		
		#if android
			if (FlxG.android.justPressed.BACK)
			{
				FlxG.switchState(new MenuState());
			}
		#end
		
		#if switch
			if (touch.justPressed) 
			{
				FlxG.switchState(new MenuState());
			}
		#end
		
	}
	
	private var credsArray:Array<Dynamic> = 
	[
		[
			"Blue Door the Game",
			"",
			"Created and Designed by:",
			"Brandon Driesse (@BrandyBuizel)",
			"Joe Varca",
			"",
			"Made with HaxeFlixel"
		],
		[
			"Inspired by 'Tapper' and 'Lights, Camera, Pants'",
			"",
			"Github Sourcecode: https://github.com/BrandyBuizel/BlueDoor"
		],
		[
			"Starring Your Coffee & Waffle connaisseurs",
			"Ken",
			"Dylan",
			"Dustin"
		],
		[
			"SPECIAL THANKS",
			"Isaac & Logan",
			"",
			"For helping us sneak this game on their custom cabinent"
		],
		[
			"Press Z to go back"
		]
	];
	
}