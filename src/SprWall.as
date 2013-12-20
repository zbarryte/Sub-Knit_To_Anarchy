package
{
	public class SprWall extends ZNode
	{
		private const kFrameL:uint = 0;
		private const kFrameC:uint = 1;
		private const kFrameR:uint = 2;
		
		public function SprWall($x:Number=0, $y:Number=0, $simpleGraphic:Class=null)
		{
			super($x, $y);
			
			loadGraphic(Glob.kSpritinator.kWall,true,false,32,32);
			
			immovable = true;
		}
		
		public function makeL():void {frame = kFrameL;}
		public function makeC():void {frame = kFrameC;}
		public function makeR():void {frame = kFrameR;}
	}
}