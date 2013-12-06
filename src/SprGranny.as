package
{
	public class SprGranny extends ZNode
	{
		public var scarf:SprScarf;
		
		private const kMoveAccel:Number = 5 * Glob.kLeveler.kTileWidthOrHeight;
		private const kDragX:Number = kMoveAccel;
		
		protected var _numStitches:int;
		private function get numStitches():int {return _numStitches;}
		private function set numStitches($numStitches:int):void {
			_numStitches = $numStitches;
			if (_numStitches < kNumStitchesMin) {
				scarf.removeSegment();
				_numStitches = kNumStitchesMax;
			}
			else if (kNumStitchesMax < _numStitches) {
				scarf.addSegment();
				_numStitches = kNumStitchesMin;
			}
		}
		private const kNumStitchesMin:uint = 0;
		private const kNumStitchesMax:uint = 5;
		
		public function SprGranny($x:Number=0, $y:Number=0)
		{
			super($x, $y, Glob.kSpritinator.kGranny);
			
			scarf = new SprScarf(0,height/2.0); // class of scarf could be specified at init
			add(scarf);
			
			numStitches = 0;
			
			drag.x = kDragX;
		}
		
		public function knit():void {
			numStitches++;
		}
		
		public function unknit():void {
			numStitches--;
		}
		
		public function moveLeft():void {
			acceleration.x = -kMoveAccel;
		}
		
		public function moveRight():void {
			acceleration.x = kMoveAccel;
		}
		
		public function stop():void {
			acceleration.x = 0;
		}
	}
}