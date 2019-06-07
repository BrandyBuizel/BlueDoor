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

class MenuState extends FlxState
{
	private var _grpMenu:FlxTypedGroup<FlxText>;
	private var _grpMenuBar:FlxTypedGroup<FlxSprite>;

	private var menuItems:Array<String> = ["Play", "Select Character", "Credits"];

	private var selected:Int = 0;
	private var charSelect:Int = 0;

	private var curMenu:Int = 0;
	private var selector:FlxSprite;
	private var selMax:Int = 0;//gets set later	
	
	override public function create():Void 
	{
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

		for (i in 0...menuItems.length)
		{
			var text:FlxText = new FlxText(0, 180 + (i * 60), 0, menuItems[i], 32);
			text.color = FlxColor.WHITE;
			text.screenCenter(X);
			_grpMenu.add(text);
		}
		
		//Character Select Arrow
		var selArrowR = new FlxSprite(_grpMenu.members[1].x - 45, _grpMenu.members[1].y + 7);
		selArrowR.loadGraphic(AssetPaths.selectArrow__png);
		selArrowR.setGraphicSize(15);
		selArrowR.updateHitbox();
		FlxTween.tween(selArrowR, {x: selArrowR.x + 10}, 0.2, {type:FlxTweenType.PINGPONG, ease:FlxEase.quadInOut});
		add(selArrowR);
		
		//Character Select Arrow
		var selArrowL = new FlxSprite(_grpMenu.members[1].x + 340, _grpMenu.members[1].y + 7);
		selArrowL.loadGraphic(AssetPaths.selectArrow__png);
		selArrowL.setGraphicSize(15);
		selArrowL.flipX = true;
		selArrowL.updateHitbox();
		FlxTween.tween(selArrowL, {x: selArrowL.x + 10}, 0.2, {type:FlxTweenType.PINGPONG, ease:FlxEase.quadInOut});
		add(selArrowL);
	}
	
	override public function update(elapsed:Float):Void 
	{
		menuHandling();		
		
		super.update(elapsed);
	}

	private function menuHandling():Void
	{
		
		for (i in 0..._grpMenu.members.length)
		{
			_grpMenu.members[i].color = FlxColor.WHITE;
		}

		_grpMenu.members[selected].color = FlxColor.YELLOW;
		

		if (FlxG.keys.anyJustPressed(["W", "UP"]))
		{
			selected -= 1;

			FlxG.sound.play("assets/sounds/menuUp.mp3");
		}
		
		if (FlxG.keys.anyJustPressed(["S", "DOWN"]))
		{
			selected += 1;
			FlxG.sound.play("assets/sounds/menuDown.mp3");
		}

		FlxG.watch.addQuick("selected 1: ", selected);

		if (selected > _grpMenu.members.length - 1)
			selected = 0;
		if (selected < 0)
			selected = _grpMenu.members.length - 1;

		FlxG.watch.addQuick("selected 2: ", selected);

		if (FlxG.keys.anyJustPressed(["ENTER", "Z", "SPACE"]))
		{
			menuOpen(menuItems[selected]);
		}
		
		if (selected == 1){
			if (FlxG.keys.anyJustPressed(["A", "LEFT"]))
			{
				FlxG.sound.play("assets/sounds/menuUp.mp3");
			}
			
			if (FlxG.keys.anyJustPressed(["D", "RIGHT"]))
			{
				FlxG.sound.play("assets/sounds/menuUp.mp3");
			}
		}
	}

	private function menuOpen(menuSelected:String):Void
	{
		var sound:FlxSound = new FlxSound();
		sound.persist = true;
		sound.loadEmbedded("assets/sounds/menuConfirm.mp3", false, true);
		sound.group = FlxG.sound.defaultSoundGroup;
		sound.play();

		switch (menuSelected)
		{
			case "Play":
				FlxG.switchState(new PlayState());
			case "Credits":
				FlxG.switchState(new CredState());
			default:
		}
	}
}