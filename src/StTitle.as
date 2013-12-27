package
{
	import org.flixel.*;
	
	public class StTitle extends ZState
	{
		
		private var mnu:ZMenu;
		
		override protected function createScene():void {
			addMenu();
			FlxG.bgColor = 0xffff0000;
		}
		
		private function addMenu():void {
			mnu = new ZMenu();
			
			// START
			var $callbackStart:Function = function():void {
				Glob.log("START");
			};
			var $textStart:String = "START";
			var $btnStart:BtnBasic = new BtnBasic($callbackStart,$textStart);
			$btnStart.x = Glob.width/2.0 - $btnStart.width/2.0;
			$btnStart.y = Glob.height/2.0 - $btnStart.height/2.0;
			mnu.add($btnStart);
			
			add(mnu);
		}
	}
}