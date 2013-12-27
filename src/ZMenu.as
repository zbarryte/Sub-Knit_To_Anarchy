package
{
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;

	public class ZMenu extends FlxGroup
	{
		protected var _buttonIndex:int;
		protected var _overlay:FlxSprite;
		
		public function ZMenu($hasOverlay:Boolean=false)
		{
			super();
			reset();
			
			if ($hasOverlay) {
				_overlay = new FlxSprite();
				_overlay.makeGraphic(FlxG.width,FlxG.height,0xff000000);
				_overlay.alpha = 0.5;
			}
		}
		
		/**
		 * Overridden <code>add</code>
		 * 
		 * Adds a button to the menu.
		 * It must be a <code>ZButton</code>, otherwise no effect
		 * 
		 * @param	$btn	The button to be added.
		 * 
		 */
		override public function add($basic:FlxBasic):FlxBasic {
			var $btn:ZButton = $basic as ZButton;
			if (!$btn) {Glob.log("ERROR :: ZMenu function, add, given non-ZButton"); return null;}
			if (isEmpty()) {$btn.curse()}
			return super.add($btn);
		}
		
		/**
		 * Curse next button, going forward. Uncurse previous button.
		 */
		public function curseForward():void {
			if (isEmpty()) {return;}
			button.uncurse();
			buttonIndex ++;
			button.curse();
			
		}
		
		/**
		 * Curse next button, going backwards. Uncurse previous button.
		 */
		public function curseBackwards():void {
			if (isEmpty()) {return;}
			button.uncurse();
			buttonIndex --;
			button.curse();
		}
		
		/**
		 * The button currently cursed.
		 * It's located by button index.
		 */
		public function get button():ZButton {
			var $btn:ZButton = members[buttonIndex];
			return $btn;
		}
		
		/**
		 * The button Index marks which button is currently cursed.
		 */
		public function get buttonIndex():int {
			return _buttonIndex;
		}
		
		/**
		 * Sets the button Index without going out of bounds.
		 */
		public function set buttonIndex($btnIndex:int):void {
			_buttonIndex = $btnIndex;
			if (_buttonIndex > length - 1) {_buttonIndex = 0;}
			if (_buttonIndex < 0) {_buttonIndex = length - 1;}
		}
		
		/**
		 * Returns whether or not there are any buttons in the menu.
		 */
		private function isEmpty():Boolean {
			return length == 0;
		}
		
		/**
		 * Select the current button.
		 */
		public function select():void {
			button.select();
		}
		
		/**
		 * Reset the cursed button to be the first.
		 */
		public function reset():void {
			_buttonIndex = 0;
			if (!isEmpty()) {button.curse();}
			for (var i:uint = 1; i < length; i++) {
				var $btn:ZButton = members[i];
				$btn.uncurse();
			}
		}
		
		/**
		 * Overridden draw, draws the overlay under the buttons.
		 * Do not override this in children, unless you call <code>super</code>
		 */
		override public function draw():void {
			if (_overlay && _overlay.visible) {_overlay.draw();}
			super.draw();
		}
		
		/**
		 * Hides all buttons in the menu.
		 */
		public function hide():void {
			_overlay.visible = false;
			for (var i:uint = 0; i < length; i++) {
				var $btn:ZButton = members[i];
				$btn.visible = false;
			}
		}
		
		/**
		 * Shows all buttons in the menu.
		 */
		public function show():void {
			_overlay.visible = true;
			for (var i:uint = 0; i < length; i++) {
				var $btn:ZButton = members[i];
				$btn.visible = true;
			}
		}
	}
}