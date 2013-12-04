package
{
	import org.flixel.FlxG;
	
	public class Glob extends FlxG
	{
		public function Glob()
		{
			super();
		}
		
		public static const kDebugOn:Boolean = true;
		
		public static var width:Number = FlxG.width;
		public static var height:Number = FlxG.height;
		
		public static const kSpritinator:GSpritinator = new GSpritinator();
	}
}