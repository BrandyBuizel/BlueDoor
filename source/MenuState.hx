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

	private function initText():Void
	{
		// sprite's graphic will be made into a 128px by 64px solid red rectangle
		var sprite = new FlxSprite();
		sprite.makeGraphic(128, 64, FlxColor.RED);
		sprite.screenCenter();
		add(sprite);
		
		/*
		_grpMenuBar = new FlxTypedGroup<FlxSprite>();
		add(_grpMenuBar);

		selector = new FlxSprite(0, 315);
		selector.makeGraphic(FlxG.width, 36, FlxColor.MAGENTA);

		_grpMenu = new FlxTypedGroup<FlxText>();
		add(_grpMenu);

		selMax = menuItems.length - 1;

		for (i in 0...menuItems.length)
		{
			var text:FlxText = new FlxText(0, 0, 0, menuItems[i], 32);
			text.color = FlxColor.WHITE;
			text.screenCenter(X);
			_grpMenu.add(text);
		}
		*/
		
		var text:FlxText = new FlxText(480, 120, 0, menuItems[0], 32);
		text.color = FlxColor.WHITE;
		text.screenCenter(X);
		add(text);
	}

	private function menuHandling():Void
	{
		/*
		for (i in 0..._grpMenu.members.length)
		{
			_grpMenu.members[i].color = FlxColor.WHITE;
		}

		_grpMenu.members[selected].color = FlxColor.MAGENTA;
		*/

		if (FlxG.keys.anyJustPressed(["W", "UP"]))
		{
			selected -= 1;

			FlxG.sound.play("assets/sounds/menuUp.");
		}
		
		if (FlxG.keys.anyJustPressed(["S", "DOWN"]))
		{
			selected += 1;
			FlxG.sound.play("assets/sounds/menuDown.");
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
	}

	private function menuOpen(menuSelected:String):Void
	{
		var sound:FlxSound = new FlxSound();
		sound.persist = true;
		sound.loadEmbedded("assets/sounds/menuConfirm.", false, true);
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