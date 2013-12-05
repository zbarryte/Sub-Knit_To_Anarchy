package
{
	import org.flixel.FlxBasic;
	import org.flixel.FlxCamera;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	
	public class SprBall extends ZNode
	{	
		private const kLaunchVel:Number = 5 * Glob.kLeveler.kTileWidthOrHeight;
		private var prevVelX:Number;
		private var prevVelY:Number;
		
		public function SprBall($x:Number=0, $y:Number=0)
		{
			super($x, $y, Glob.kSpritinator.kBall);
			
			acceleration.y = Glob.kSpritinator.kGravAccel;
		}
		
		public function launch():void {
			velocity.x = kLaunchVel;
		}
		
		override public function update():void {
			super.update();
			bounce();
		}
		
		private function bounce():void {
			if ((justTouched(FlxObject.DOWN) && 0 < prevVelY) || (justTouched(FlxObject.UP) && prevVelY < 0)) {
				velocity.y = -prevVelY * 0.44;
			}
			if ((justTouched(FlxObject.LEFT) && prevVelX < 0) || (justTouched(FlxObject.RIGHT) && 0 < prevVelX)) {
				velocity.x = -prevVelX * 0.88;
			}
			prevVelX = velocity.x;
			prevVelY = velocity.y;
		}
		
		/*
		override public function overlapsPoint($point:FlxPoint, $inScreenSpace:Boolean=false, $camera:FlxCamera=null):Boolean {
			Glob.log("entering overlaps point");
			var $distSq:Number = Math.pow(x - $point.x,2) + Math.pow(y - $point.y,2);
			if ($distSq <= Math.pow(width/2.0,2)) {Glob.log("overlaps point"); return true;}
			return super.overlapsPoint($point,$inScreenSpace,$camera);
		}
		
		override public function overlapsAt($x:Number, $y:Number, $objectOrGroup:FlxBasic, $inScreenSpace:Boolean=false, $camera:FlxCamera=null):Boolean {
			Glob.log("entering overlaps at");
			var $distSq:Number = Math.pow($x - x,2) + Math.pow($y - y,2);
			if ($distSq <= Math.pow(width/2.0,2)) {Glob.log("overlaps at"); return true;}
			return super.overlapsAt($x,$y,$objectOrGroup,$inScreenSpace);
		}
		
		override public function overlaps($objectOrGroup:FlxBasic, $inScreenSpace:Boolean=false, $camera:FlxCamera=null):Boolean {
			Glob.log("entering overlaps");
			return super.overlaps($objectOrGroup,$inScreenSpace,$camera);
		}
		*/
	}
}