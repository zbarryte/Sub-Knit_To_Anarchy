package
{
	public class SprGranny extends ZNode
	{
		public var scarf:SprScarf;
		
		private const kMoveAccel:Number = 20 * Glob.kLeveler.kTileWidthOrHeight;
		private const kDragX:Number = kMoveAccel;
		
		public function SprGranny($x:Number=0, $y:Number=0)
		{
			super($x, $y, Glob.kSpritinator.kGranny);
			
			scarf = new SprScarf(0,height/2.0);
			add(scarf);
			
			drag.x = kDragX;
		}
		
		public function knit():void {
			scarf.addSegment();
		}
		
		public function unknit():void {
			scarf.removeSegment();
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