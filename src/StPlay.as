package
{
	public class StPlay extends ZState
	{
		private var ballGroup:ZGroup;
		
		override protected function createScene():void {
			var $ball:SprBall = new SprBall();
			add($ball);
		}
	}
}