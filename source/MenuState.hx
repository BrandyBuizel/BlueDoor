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

class MenuState extends BaseMenuState
{
	private var mScore:FlxText;

	private var debugInfo:FlxText;
	private var currentVersion:String = "v1.2.0";

	private var sprMonster:FlxSprite;
	private var sprMashing:FlxSprite;

	private var _grpMenu:FlxTypedGroup<FlxText>;
	private var _grpMenuBar:FlxTypedGroup<FlxSprite>;

	private var menuItems:Array<String> = ["Play", "Gallery", "Credits", "Hall of Shame", "Settings", "Join Our Discord"];
	private var leadItems:Array<String>;

	private var selected:Int = 0;

	/**
	 * 0 == Main Menu
	 * 1 == Settings
	 * 2 == Gallery
	 */
	private var curMenu:Int = 0;
	private var selector:FlxSprite;
	private var selMax:Int = 0;//gets set later

	private var discordLink:String = "https://discord.gg/t22G6Fr";
	private var nutakuLink:String = "https://nutaku.net/games/download/monster-mashing";

	private function initImages():Void
	{

		sprMonster = new FlxSprite(0, 30).loadGraphic(AssetPaths.mmLogo__png, false, 492, 166);
		sprMonster.screenCenter(X);
		add(sprMonster);

	}

	private function initText():Void
	{
		_grpMenuBar = new FlxTypedGroup<FlxSprite>();
		add(_grpMenuBar);

		selector = new FlxSprite(0, 315);
		selector.makeGraphic(FlxG.width, 36, FlxColor.MAGENTA);
		//add(selector);
		//resetBarFill();

		_grpMenu = new FlxTypedGroup<FlxText>();
		add(_grpMenu);

		selMax = menuItems.length - 1;

		for (i in 0...menuItems.length)
		{
			/*
			var whiteBar:FlxSprite = new FlxSprite(0, (i * 54) + 315);
			whiteBar.makeGraphic(FlxG.width, 36);
			_grpMenuBar.add(whiteBar);
			*/

			var text:FlxText = new FlxText(0, (i * 54) + 320, 0, menuItems[i], 32);
			var text:FlxText = new FlxText(0, (i * 54) + 320, 0, menuItems[i], 32);
			text.color = FlxColor.BLACK;
			text.screenCenter(X);
			_grpMenu.add(text);
		}

	private function menuHandling():Void
	{
		for (i in 0..._grpMenu.members.length)
		{
			_grpMenu.members[i].color = FlxColor.WHITE;
		}

		_grpMenu.members[selected].color = FlxColor.MAGENTA;

		#if !mobile
		if (FlxG.keys.anyJustPressed(["W", "UP", "I"]))
		{
			selected -= 1;

			FlxG.sound.play("assets/sounds/menuUp." + soundEXT, 0.5 * SettingSubstate.masterVol * SettingSubstate.soundVol);
		}
		if (FlxG.keys.anyJustPressed(["S", "DOWN", "K"]))
		{
			selected += 1;
			FlxG.sound.play("assets/sounds/menuDown." + soundEXT, 0.5 * SettingSubstate.masterVol * SettingSubstate.soundVol);
		}
		#end

		var gamepad = FlxG.gamepads.lastActive;
		if (gamepad != null)
		{
			if (gamepad.anyJustPressed(["DPAD_UP", "DPAD_LEFT", "LEFT_STICK_DIGITAL_UP", "LEFT_STICK_DIGITAL_LEFT"]))
			{
				selected -= 1;
				FlxG.sound.play("assets/sounds/menuUp." + soundEXT, 0.5 * SettingSubstate.masterVol * SettingSubstate.soundVol);
			}

			if (gamepad.anyJustPressed(["DPAD_DOWN", "DPAD_RIGHT", "LEFT_STICK_DIGITAL_DOWN", "LEFT_STICK_DIGITAL_RIGHT"]))
			{
				selected += 1;
				FlxG.sound.play("assets/sounds/menuDown." + soundEXT, 0.5 * SettingSubstate.masterVol * SettingSubstate.soundVol);
			}

			if (gamepad.anyJustPressed(["A", "START"]))
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

		/* Change this so it only chekcs if up or down keys get pressed
		if (FlxG.keys.justPressed.ANY)
		{
			resetBarFill();
		}
		*/

		if (FlxG.keys.anyJustPressed(["ENTER", "Z", "SPACE"]))
		{
			menuOpen(menuItems[selected]);
		}
	}

	private function menuOpen(menuSelected:String):Void
	{
		var sound:FlxSound = new FlxSound();
		sound.persist = true;
		sound.loadEmbedded("assets/sounds/menuConfirm." + soundEXT, false, true);
		sound.volume = 1 * SettingSubstate.masterVol * SettingSubstate.soundVol;
		sound.group = FlxG.sound.defaultSoundGroup;
		sound.play();

		switch (menuSelected)
		{
			case "Play":
				FlxG.switchState(new PlayState());
			case "Gallery":
				FlxG.switchState(new GalleryState());
			case "Credits":
				FlxG.switchState(new CredState());
			case "Hall of Shame":
				openSubState(new ScoreState(0xCC000000));
			case "Settings":
				FlxG.switchState(new SettingState());
			case "Join Our Discord":
				FlxG.openURL(discordLink);
			case "Exit":
				#if cpp
				Sys.exit(0);
				#end
			case "Buy on Nutaku!":
				FlxG.openURL(nutakuLink);
			default:
		}

	}

}