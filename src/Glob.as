package
{
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	
	public class Glob
	{	
		public static const kDebugOn:Boolean = true;
		
		public static var width:Number = FlxG.width;
		public static var height:Number = FlxG.height;
		
		public static const kSpritinator:GSpritinator = new GSpritinator();
		public static const kLeveler:GLeveler = new GLeveler();
		public static const kController:GController = new GController();
		public static const kAudiator:GAudiator = new GAudiator();
		
		public static function log($data:Object):void {FlxG.log($data);}
		public static function classOfObject($obj:Object,$simpleBoolean:Boolean=false):Class {
			return FlxU.getClass(FlxU.getClassName($obj,$simpleBoolean));
		}
		public static function get elapsed():Number {return FlxG.elapsed;}
	}
}