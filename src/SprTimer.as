package
{
	public class SprTimer extends ZNode
	{
		private var label:ZText;
		protected var _time:Number;
		public function get time():Number {return uint(_time);}
		public function set time($time:Number):void {
			_time = $time;
		}
		
		private var isPlaying:Boolean;
		
		public function SprTimer($start:Number,$x:Number=0, $y:Number=0)
		{
			super($x, $y);
			
			time = $start;
		}
		
		override public function update():void {
			super.update();
			if (!isPlaying) {return;}
			time -= Glob.elapsed;
			Glob.log(this + " " + time);
		}
		
		public function isDone():Boolean {
			return time <= 0;
		}
		
		public function start():void {
			isPlaying = true;
		}
	}
}