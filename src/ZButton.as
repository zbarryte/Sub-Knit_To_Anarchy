package
{
	public class ZButton extends ZNode
	{
		protected var _selectCallback:Function;
		
		public function ZButton($selectCallback:Function,$text:String=null,$x:Number=0,$y:Number=0,$simpleGraphic:Class=null)
		{
			super($x,$y,$simpleGraphic);
			
			_selectCallback = $selectCallback;
			
			if ($text) {
				var $label:ZText = new ZText(0,0,width);
				$label.text = $text;
				$label.alignment = "center";
				$label.size = height/3.0;
				$label.yLocal = height/2.0 - $label.height/2.0;
				add($label);
				$label.scrollFactor.x = 0;
				$label.scrollFactor.y = 0;
			}
			
			uncurse();
			scrollFactor.x = 0;
			scrollFactor.y = 0;
		}
		
		/**
		 * Curses the button.
		 * Override this function to specify how the button reacts to being cursed.
		 */
		public function curse():void {
			// implemented by children
		}
		
		/** 
		 * Uncurses the button.
		 * Override this function to specify how the button reacts to being uncursed.
		 */
		public function uncurse():void {
			// implemented by children
		}
		
		/**
		 * Selects the button.
		 * Overriding this function will change any behavior specified by the button's selectCallback unless <code>super</code> is called.
		 * So call <code>super</code> if you're going to override this.
		 */
		public function select():void {
			if (_selectCallback!=null) {_selectCallback();}
		}
	}
}