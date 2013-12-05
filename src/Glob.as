package
{
	import org.flixel.FlxG;
	
	public class Glob
	{	
		public static const kDebugOn:Boolean = true;
		
		public static var width:Number = FlxG.width;
		public static var height:Number = FlxG.height;
		
		public static const kSpritinator:GSpritinator = new GSpritinator();
		public static const kLeveler:GLeveler = new GLeveler();
		public static const kController:GController = new GController();
		
		public static function log($data:Object):void {FlxG.log($data);}
	}
}