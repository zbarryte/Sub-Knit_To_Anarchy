package
{
	public class SprCountdown extends ZNode
	{
		private var count:uint;
		private var event:ZEvent;
		private var label:ZText;
		
		private const kLabelSize:uint = 88;
		private const kLabelSizeStart:uint = 11;
		
		public function SprCountdown($start:uint,$period:Number,$after:Function,$x:Number=0, $y:Number=0)
		{
			super($x, $y);
			
			label = new ZText(x,y,Glob.width);
			label.alignment = "center";
			label.color = 0xffffff00;
			label.shadow = 0xff000000;
			
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
			
			if (label.size < kLabelSize) {
				label.size += 4;
			}
		}
		
		override public function draw():void {
			label.draw();
		}
		
		public function isDone():Boolean {
			return count <=0;
		}
		
		private function updateLabel():void {
			label.text = ""+count+"";
			label.size = kLabelSizeStart;
		}
	}
}