package
{
	public class SprScarf extends ZNode
	{
		protected var _numSegments:uint;
		private function get numSegments():uint {return _numSegments;}
		private function set numSegments($numSegments:uint):void {
			if ($numSegments < kNumSegmentsMin || kNumSegmentsMax < $numSegments) {return;}
			_numSegments = $numSegments;
		}
		private const kNumSegmentsMin:uint = 0;
		private const kNumSegmentsMax:uint = 100;
		
		private var segment:SprScarfSegment;
		
		public function SprScarf($x:Number=0, $y:Number=0)
		{
			super($x, $y)
			
			segment = new SprScarfSegment();
			add(segment);
			
			immovable = true;
			numSegments = 0;
		}
		
		public function addSegment():void {
			numSegments++;
		}
		
		public function removeSegment():void {
			numSegments--;
		}
		
		override public function update():void {
			super.update();
			width = segment.width;
			height = numSegments * segment.height;
		}
		
		override public function draw():void {
			super.draw();
			for (var i:uint = 0; i < numSegments; i++) {
				var $segment:SprScarfSegment = segment.copy();
				$segment.y = y + ($segment.height * i);
				$segment.draw();
			}
		}
	}
}