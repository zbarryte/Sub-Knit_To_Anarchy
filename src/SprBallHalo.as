package
{
	public class SprBallHalo extends ZNode
	{
		private const kAnimIdle:String = "kAnimIdle";
		private const kFrameMax:uint = 4;
		
		public function SprBallHalo($x:Number=0, $y:Number=0)
		{
			super($x, $y);
			loadGraphic(Glob.kSpritinator.kBallHalo,true,false,40,40);
			addAnimation(kAnimIdle,[0,1,2,3,kFrameMax,3,2,1],10);
			play(kAnimIdle);
			alpha = 0;
		}
		
		override public function update():void {
			super.update();
			alpha = Number(kFrameMax - frame)/Number(kFrameMax);
		}
	}
}