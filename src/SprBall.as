package
{
	import org.flixel.FlxObject;
	
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
	}
}