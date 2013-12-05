package
{
	public class SprScarf extends ZNode
	{
		public function SprScarf($x:Number=0, $y:Number=0, $simpleGraphic:Class=null)
		{
			super($x, $y, Glob.kSpritinator.kScarfSegment);
			immovable = true;
		}
		
		public function addSegment():void {
			yLocal += height;
		}
		
		public function removeSegment():void {
			yLocal -= height;
		}
	}
}