package
{
	public class SprFire extends ZNode
	{
		private const kAnimBurn:String = "kAnimBurn";
		private const kFrameIdle:uint = 3;
		
		protected var _isBurning:Boolean;
		
		public function SprFire($burnOut:Function,$x:Number=0, $y:Number=0)
		{
			super($x, $y);
			
			loadGraphic(Glob.kSpritinator.kFire,true,false,32,32);
			addAnimation(kAnimBurn,[0,1,2,1,0,1],2,false);
			var $burnCallback:Function = function($name:String=null,$frameNum:uint=0,frameIndex:uint=0):void {
				if ($name == kAnimBurn && finished) {
					$burnOut();
				}
			};
			addAnimationCallback($burnCallback);
			
			idle();
		}
		
		public function burn():void {play(kAnimBurn); _isBurning = true;}
		private function idle():void {frame = kFrameIdle;}
		
		public function isBurning():Boolean {
			return _isBurning;
		}
	}
}