package
{
	public class SprScore extends ZText
	{
		private var counter:uint;
		
		private var kCatchPoints:uint = 2000;
		
		public function SprScore($x:Number=0, $y:Number=0)
		{
			super($x, $y, Glob.width);
			alignment = "right";
			counter = 0;
		}
		
		override public function update():void {
			super.update();
			updateLabel();
		}
		
		private function updateLabel():void {
			text = "SCORE: "+counter+" pts";
		}
		
		public function addCatchPoints():void {
			counter += kCatchPoints;
		}
		
		
	}
}