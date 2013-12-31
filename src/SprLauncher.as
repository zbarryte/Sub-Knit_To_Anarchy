package
{
	public class SprLauncher extends ZNode
	{
		public function SprLauncher($x:Number=0, $y:Number=0)
		{
			super($x, $y, Glob.kSpritinator.kLauncher);
		}
		
		public function newBall():SprBall {
			
			Glob.kAudiator.playBallLaunch();
			
			var $ball:SprBall = new SprBall(x,y);
			$ball.launch();
			return $ball;
		}
	}
}