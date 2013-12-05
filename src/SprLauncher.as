package
{
	public class SprLauncher extends ZNode
	{
		public function SprLauncher($x:Number=0, $y:Number=0, $simpleGraphic:Class=null)
		{
			super($x, $y, Glob.kSpritinator.kLauncher);
		}
		
		public function newBall():SprBall {
			var $ball:SprBall = new SprBall(x,y);
			$ball.launch();
			return $ball;
		}
	}
}