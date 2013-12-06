package
{	
	public class SprScarfSegment extends ZNode
	{
		public function SprScarfSegment($x:Number=0, $y:Number=0)
		{
			super($x, $y, Glob.kSpritinator.kScarfSegment);
		}
		
		public function copy():SprScarfSegment {
			var $class:Class = Glob.classOfObject(this);
			var $copy:SprScarfSegment = new $class(x,y);
			return $copy;
		}
	}
}