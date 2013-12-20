package
{
	public class SprScore extends ZNode
	{
		private var counter:uint;
		private var label:ZText;
		
		private var kCatchPoints:uint = 2000;
		
		public function SprScore($x:Number=0, $y:Number=0)
		{
			super($x, $y);
			counter = 0;
			
			var $width:Number = 222;
			label = new ZText(0,0,$width);
			width = $width;
			
			
		}
		
		override public function draw():void {
			label.draw();
		}
		
		override public function update():void {
			super.update();
			label.x = x;
			label.y = y;
			updateLabel();
		}
		
		private function updateLabel():void {
			label.text = "SCORE: "+counter+" pts";
		}
		
		public function addCatchPoints():void {
			counter += kCatchPoints;
		}
		
		
	}
}