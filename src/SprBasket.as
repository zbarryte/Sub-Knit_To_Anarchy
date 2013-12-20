package
{
	public class SprBasket extends ZNode
	{
		private const kFrameL:uint = 0;
		private const kFrameC:uint = 1;
		private const kFrameR:uint = 2;
		
		public function SprBasket($x:Number=0, $y:Number=0)
		{
			super($x, $y);
			
			loadGraphic(Glob.kSpritinator.kBasket, true, false, 32, 32);
		}
		
		public function collect($ball:SprBall):void {
			if ($ball.color != color) {
				$ball.kill();
			}
			else {
				$ball.bounceBackHard();
			}
		}
		
		public function makeL():void {frame = kFrameL;}
		public function makeC():void {frame = kFrameC;}
		public function makeR():void {frame = kFrameR;}
	}
}