package
{
	public class SprWall extends ZNode
	{
		public function SprWall($x:Number=0, $y:Number=0, $simpleGraphic:Class=null)
		{
			super($x, $y, Glob.kSpritinator.kWall);
			immovable = true;
		}
	}
}