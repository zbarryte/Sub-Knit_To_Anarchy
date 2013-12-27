package
{	
	public class SprTimer extends ZText
	{
		private var time:Number;
		
		private var isPlaying:Boolean;
		
		public function SprTimer($start:Number,$x:Number=0, $y:Number=0)
		{	
			super($x, $y,Glob.width);
			alignment = "left";
			
			time = $start;
			updateLabel();
		}
		
		private function updateLabel():void {
			text = "TIME REMAINING: "+uint(time)+" secs";
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