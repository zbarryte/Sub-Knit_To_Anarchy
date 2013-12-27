package
{
	public class SprCountdown extends ZText
	{
		private var count:uint;
		private var event:ZEvent;
		
		private const kLabelSize:uint = 88;
		private const kLabelSizeStart:uint = 11;
		
		public function SprCountdown($start:uint,$period:Number,$after:Function,$x:Number=0, $y:Number=0)
		{
			super($x, $y, Glob.width);
			
			alignment = "center";
			color = 0xffffff00;
			shadow = 0xff000000;
			
			count = $start;
			var $callback:Function = function():void {
				if (isDone()) {
					event.stop();
					$after();
					kill();
				}
				else {
					count--;
					updateLabel();
				}
			};
			event = new ZEvent($period,$callback,true,true);
			
			updateLabel();
		}
		
		override public function update():void {
			super.update();
			event.update();
			
			if (size < kLabelSize) {
				size += 4;
			}
		}
		
		public function isDone():Boolean {
			return count <=0;
		}
		
		private function updateLabel():void {
			text = ""+count+"";
			size = kLabelSizeStart;
		}
	}
}