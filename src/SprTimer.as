package
{	
	public class SprTimer extends ZNode
	{
		private var label:ZText;
		private var time:Number;
		
		private var isPlaying:Boolean;
		
		public function SprTimer($start:Number,$x:Number=0, $y:Number=0)
		{	
			super($x, $y);
			
			var $labelWidth:Number = 222;
			label = new ZText(x,y,$labelWidth);
			
			time = $start;
		}
		
		private function updateLabel():void {
			label.text = "TIME REMAINING: "+uint(time)+" secs";
		}
		
		override public function draw():void {
			super.draw();
			label.draw();
		}
		
		override public function update():void {
			super.update();
			if (!isPlaying) {return;}
			time -= Glob.elapsed;
			if (time <= 0) {time = 0;}
			updateLabel();
		}
		
		public function isDone():Boolean {
			return time <= 0;
		}
		
		public function start():void {
			isPlaying = true;
		}
	}
}