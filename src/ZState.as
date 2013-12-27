package
{
	import org.flixel.FlxState;
	
	public class ZState extends FlxState
	{
		protected var _isControllable:Boolean;
		
		public function ZState()
		{
			super();
			
			_isControllable = true;
		}
		
		override public function create():void {
			super.create();
			createScene();
			createDebug();
		}
		
		protected function createScene():void {
			// implemented by children
		}
		
		private function createDebug():void {
			if (!Glob.kDebugOn) {return;}
			var $text:ZText = new ZText(0,0,Glob.width);
			$text.text = "## DEBUG ON ##";
			$text.alignment = "center";
			add($text);
		}
		
		override public function update():void {
			super.update();
			if (_isControllable) {
				updateControls();
			}
		}
		
		protected function updateControls():void {
			// implemented by children
		}
	}
}