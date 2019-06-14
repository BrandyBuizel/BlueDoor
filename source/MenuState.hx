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

//import djFlixel.gui.FlxMenu;
//import djFlixel.gui.FlxMenuPages;

#if arcade
	//arcace specific code goes here
#end

class MenuState extends FlxState
{
	private var _grpMenu:FlxTypedGroup<FlxText>;
	private var _grpMenuBar:FlxTypedGroup<FlxSprite>;
	
	#if (arcade || web)
		private var menuItems:Array<String> = ["Play", "Select Character", "Credits"];
	#else
		private var menuItems:Array<String> = ["Play", "Select Character", "Credits", "Exit"];
	#end
	
	private var charItems:Array<String> = ["Ken", "Dylan", "Dustin"];

	private var selected:Int = 0;
	private var charSelect:Int = 0;

	private var curMenu:Int = 0;
	private var selector:FlxSprite;
	private var selMax:Int = 0;//gets set later	
	
	private var _selArrowL:FlxSprite;
	private var _selArrowR:FlxSprite;
	
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
		
		#if !arcade //Normal Controller Mapping
			if (FlxG.keys.anyJustPressed(["W", "UP"])){
				selected -= 1;

				FlxG.sound.play("assets/sounds/menuUp.mp3");
				FlxG.sound.play("assets/sounds/menuUp.ogg");
			}
			
			if (FlxG.keys.anyJustPressed(["S", "DOWN"])){
				selected += 1;
				FlxG.sound.play("assets/sounds/menuDown.mp3");
				FlxG.sound.play("assets/sounds/menuDown.ogg");
			}
		
			if (selected == 1){
				if (FlxG.keys.anyJustPressed(["A", "LEFT"])){
					charSelect -= 1;
					_selArrowL.animation.play("yellow");
					FlxG.sound.play("assets/sounds/menuConfirm.mp3");
					FlxG.sound.play("assets/sounds/menuConfirm.ogg");
				}
				
				if (FlxG.keys.anyJustPressed(["D", "RIGHT"])){
					charSelect += 1;
					_selArrowR.animation.play("yellow");
					FlxG.sound.play("assets/sounds/menuConfirm.mp3");
					FlxG.sound.play("assets/sounds/menuConfirm.ogg");
				}
			}
			
			if (FlxG.keys.anyJustPressed(["ENTER", "Z", "SPACE"]) && (selected == 0 || selected == 2)){
				menuOpen(menuItems[selected]);
			}
		#end

		FlxG.watch.addQuick("selected 1: ", selected);

		if (selected > _grpMenu.members.length - 1)
			selected = 0;
		if (selected < 0)
			selected = _grpMenu.members.length - 1;

		FlxG.watch.addQuick("selected 2: ", selected);
	}

	private function menuOpen(menuSelected:String):Void
	{
		var sound:FlxSound = new FlxSound();
		sound.persist = true;
		sound.loadEmbedded("assets/sounds/menuConfirm.mp3", false, true);
		sound.loadEmbedded("assets/sounds/menuConfirm.ogg", false, true);
		sound.group = FlxG.sound.defaultSoundGroup;
		sound.play();

		switch (menuSelected){
			case "Play":
				FlxG.switchState(new PlayState());
			case "Credits":
				FlxG.switchState(new CredState());
			default:
		}
	}
}