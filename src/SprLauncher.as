package
{
	public class SprLauncher extends ZNode
	{
		private const kScaleMax:Number = 1.33;
		
		public function SprLauncher($x:Number=0, $y:Number=0)
		{
			super($x, $y, Glob.kSpritinator.kLauncher);
			
			scale.x = 0;
			scale.y = 0;
		}
		
		public function newBall():SprBall {
			
			Glob.kAudiator.playBallLaunch();
			
			scale.x = kScaleMax;
			scale.y = kScaleMax;
			
			var $ball:SprBall = new SprBall(x,y);
			$ball.launch();
			return $ball;
		}
		
		override public function update():void {
			super.update();
			if (scale.x > 0) {
				scale.x -= 0.044;
				if (scale.x < 0) {scale.x = 0;}
			}
			if (scale.y > 0) {
				scale.y -= 0.044;
				if (scale.y < 0) {scale.y = 0;}
			}
			
			angle ++;
			
		}
	}
}