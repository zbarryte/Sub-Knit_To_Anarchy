package
{
	public class SprBasket extends ZNode
	{
		public function SprBasket($x:Number=0, $y:Number=0)
		{
			super($x, $y, Glob.kSpritinator.kBasket);
		}
		
		public function collect($ball:SprBall):void {
			if ($ball.color != color) {
				$ball.kill();
			}
			else {
				$ball.bounceBackHard();
			}
		}
	}
}