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
			
			loadGraphic(Glob.kSpritinator.kFire,true,false,40,40);
			scale.x = 40./32.;
			scale.y = 40./32.;
			addAnimation(kAnimBurn,[rf,rf,rf,rf,rf,rf,rf,rf,rf,rf,rf,rf,rf,rf,rf,rf,rf,rf,rf,rf,rf,rf],22,false);
			var $burnCallback:Function = function($name:String=null,$frameNum:uint=0,frameIndex:uint=0):void {
				if ($name == kAnimBurn && finished) {
					$burnOut();
				}
			};
			addAnimationCallback($burnCallback);
			
			idle();
		}
		
		public function burn():void {play(kAnimBurn); _isBurning = true; Glob.kAudiator.playFire();}
		private function idle():void {frame = kFrameIdle;}
		
		public function isBurning():Boolean {
			return _isBurning;
		}
		
		override public function update():void {
			if (_isBurning) {
				scale.y = (rf*4 + 40.)/32.;
			}
			super.update();
		}
		
		private function get rf():uint {
			return  Math.random()*3;
		}
	}
}