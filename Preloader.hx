package ;

import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
 
@:bitmap("art/preloaderArt.png") class LogoImage extends BitmapData { }
 
class Preloader extends flixel.system.FlxBasePreloader
{
    override public function new(MinDisplayTime:Float = 2, ?AllowedURLs:Array<String>) 
	{
		super(MinDisplayTime, AllowedURLs);
	}
     
    var logo:Sprite;
	
	override function create():Void
	{	
		this._width = Lib.current.stage.stageWidth;
        this._height = Lib.current.stage.stageHeight;
         
        var ratio:Float = this._width / 1280; //This allows us to scale assets depending on the size of the screen.
         
        logo = new Sprite();
        logo.addChild(new Bitmap(new LogoImage(0,0))); //Sets the graphic of the sprite to a Bitmap object, which uses our embedded BitmapData class.
        logo.scaleX = logo.scaleY = ratio;
        //logo.x = ((this._width) / 2) - ((logo.width) / 2);
        //logo.y = (this._height / 2) - ((logo.height) / 2);
        addChild(logo); //Adds the graphic to the NMEPreloader's buffer.
         
        super.create();
	}
	
	override public function update(percent:Float):Void
	{
		super.update(percent);
	}
}