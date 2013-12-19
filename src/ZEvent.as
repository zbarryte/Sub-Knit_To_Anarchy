package
{
	import org.flixel.FlxBasic;
	
	public class ZEvent extends FlxBasic
	{
		protected var _time:Number;
		protected var _period:Number;
		protected var _event:Function;
		protected var _isLooped:Boolean;
		protected var _isPlaying:Boolean;
		protected var _killOnStop:Boolean;
		
		public function ZEvent($period:Number=0,$event:Function=null,$isLooped:Boolean=true,$killOnStop:Boolean=false)
		{
			super();
			_period = $period;
			_event = $event;
			_isLooped = $isLooped;
			resetTimer();
			play();
			_killOnStop = $killOnStop;
		}
		
		override public function update():void {
			if (!_isPlaying) {return;}
			super.update();
			_time += Glob.elapsed;
			if (_time >= _period) {
				fireEvent();
				if (_isLooped) {
					resetTimer();
				}
				else {
					stop();
				}
			}
		}
		
		protected function fireEvent():void {
			if (_event!=null) {_event();}
		}
		
		public function stop():void {
			resetTimer();
			_isPlaying = false;
			if (_killOnStop) {
				kill();
			}
		}
		
		public function play():void {
			_isPlaying = true;
		}
		
		protected function resetTimer():void {
			_time = 0;
		}
	}
}