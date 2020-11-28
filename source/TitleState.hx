package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.android.FlxAndroidKey;
import flixel.input.gamepad.FlxGamepad;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.ui.FlxSpriteButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.util.FlxSpriteUtil;
import lime.utils.Assets;

class TitleState extends FlxState
{
	static public var soundExt:String = ".mp3";
	
	private var _grpMenu:FlxTypedGroup<FlxText>;
	private var _grpMenuBar:FlxTypedGroup<FlxSprite>;
	
	private var menuItems:Array<String> = ["Play", "Select Character", "Credits", "Exit"];
	private var charItems:Array<String> = ["Ken", "Dylan", "Dustin"];

	private var selected:Int = 0;
	private var charSelect:Int = 0;

	private var curMenu:Int = 0;
	private var selector:FlxSprite;
	private var selMax:Int = 0;//gets set later	
	
	private var _selArrowL:FlxSprite;
	private var _selArrowR:FlxSprite;

	private var _left:Array<flixel.input.keyboard.FlxKey> = ["LEFT", "A"];
	private var _right:Array<flixel.input.keyboard.FlxKey> = ["RIGHT", "D"];
	private var _up:Array<flixel.input.keyboard.FlxKey> = ["UP", "W"];
	private var _down:Array<flixel.input.keyboard.FlxKey> = ["DOWN", "S"];
	private var _accept:Array<flixel.input.keyboard.FlxKey> = ["SPACE", "ENTER"];
	
	override public function create():Void 
	{
		trace("init title state");
		
		#if (!web)
		TitleState.soundExt = '.ogg';
		#end    
		
		initText();
		
		super.create();
	}

	private function initText():Void
	{		
		_grpMenuBar = new FlxTypedGroup<FlxSprite>();
		add(_grpMenuBar);

		selector = new FlxSprite(0, 315);
		selector.makeGraphic(FlxG.width, 36, FlxColor.MAGENTA);

		_grpMenu = new FlxTypedGroup<FlxText>();
		add(_grpMenu);

		selMax = menuItems.length - 1;

		for (i in 0...menuItems.length){
			var text:FlxText = new FlxText(0, 180 + (i * 60), 0, menuItems[i], 32);
			text.color = FlxColor.WHITE;
			text.screenCenter(X);
			_grpMenu.add(text);
		}
		
		//Character Select Arrow Left
		_selArrowL = new FlxSprite(_grpMenu.members[1].x - 42, _grpMenu.members[1].y + 6);
		_selArrowL.loadGraphic(AssetPaths.spr_selectArrow__png, true, 6, 9);
		_selArrowL.setGraphicSize(15);
		_selArrowL.updateHitbox();
		FlxTween.tween(_selArrowL, {x: _selArrowL.x + 10}, 0.2, {type:FlxTweenType.PINGPONG, ease:FlxEase.quadInOut, startDelay:0.225});
		add(_selArrowL);
		
		_selArrowL.animation.add("normal", [0]);
		_selArrowL.animation.add("yellow", [1, 1, 1, 0], 16, false);
		
		//Character Select Arrow Right
		_selArrowR = new FlxSprite(_grpMenu.members[1].x + 340, _grpMenu.members[1].y + 8);
		_selArrowR.loadGraphic(AssetPaths.spr_selectArrow__png, true, 6, 9);
		_selArrowR.setGraphicSize(15);
		_selArrowR.flipX = true;
		_selArrowR.updateHitbox();
		FlxTween.tween(_selArrowR, {x: _selArrowR.x + 10}, 0.2, {type:FlxTweenType.PINGPONG, ease:FlxEase.quadInOut});
		add(_selArrowR);
		
		_selArrowR.animation.add("normal", [0]);
		_selArrowR.animation.add("yellow", [1, 1, 1, 0], 16, false);	
	}
	
	override public function update(elapsed:Float):Void 
	{
		menuHandling();
		
		super.update(elapsed);
	}

	private function menuHandling():Void
	{
		for (i in 0..._grpMenu.members.length){
			_grpMenu.members[i].color = FlxColor.WHITE;
		}
		
		_grpMenu.members[selected].color = FlxColor.YELLOW;
		
		if (FlxG.keys.anyJustPressed(_up))
		{
			selected -= 1;
			FlxG.sound.play("assets/sounds/menuUp" + soundExt);
		}
		
		if (FlxG.keys.anyJustPressed(_down))
		{
			selected += 1;
			FlxG.sound.play("assets/sounds/menuDown" + soundExt);
		}
		
		if (selected == 1){
			if (FlxG.keys.anyJustPressed(_left))
			{
				charSelect -= 1;
				_selArrowL.animation.play("yellow");
				FlxG.sound.play("assets/sounds/menuConfirm" + soundExt);
			}
				
			if (FlxG.keys.anyJustPressed(_right))
			{
				charSelect += 1;
				_selArrowR.animation.play("yellow");
				FlxG.sound.play("assets/sounds/menuConfirm" + soundExt);
			}
		}

		if (selected == 0 || selected == 2){
			if (FlxG.keys.anyJustPressed(_accept))
			{
				menuOpen(menuItems[selected]);
			}
		}
	
		FlxG.watch.addQuick("selected 1: ", selected);

		if (selected > _grpMenu.members.length - 1)
			selected = 0;
		if (selected < 0)
			selected = _grpMenu.members.length - 1;

		FlxG.watch.addQuick("selected 2: ", selected);
	}

	private function menuOpen(menuSelected:String):Void
	{
		switch (menuSelected){
			case "Play":
				FlxG.switchState(new PlayState());
			case "Credits":
				FlxG.switchState(new CredState());
			default:
		}
	}
}