package
{
	import org.flixel.FlxSprite;
	
	public class ZNode extends FlxSprite
	{
		public var xLocal:Number;
		public var yLocal:Number;
		
		protected var _graphic:Class;
		protected var _children:ZGroup;
		
		public function ZNode($x:Number=0,$y:Number=0,$simpleGraphic:Class=null)
		{
			xLocal = $x;
			yLocal = $y;
			super(xLocal,yLocal,$simpleGraphic);
			
			_children = new ZGroup();
			_graphic = $simpleGraphic;
		}
		
		override public function loadGraphic($graphic:Class,$animated:Boolean=false,$reverse:Boolean=false,$width:uint=0,$height:uint=0,$unique:Boolean=false):FlxSprite {
			_graphic = $graphic;
			return super.loadGraphic($graphic,$animated,$reverse,$width,$height,$unique);
		}
		
		public function add($child:ZNode):void {
			_children.add($child);
		}
		
		override public function update():void {
			super.update();
			for (var i:uint = 0; i < _children.length; i++) {
				var $child:ZNode = _children.members[i];
				updateChildProperties($child);
			}
		}
		
		private function updateChildProperties($child:ZNode):void {
			$child.velocity = velocity;
			$child.acceleration = acceleration;
			$child.x = x + $child.xLocal;
			$child.y = y + $child.yLocal;
		}
		
		override public function draw():void {
			if (!visible || !_graphic) {return;}
			super.draw();
			_children.draw();
		}
		
		protected function touchesNodeLeft($node:ZNode):Boolean {
			return touchesNodeInDirection($node,Glob.kSpritinator.kDirL);
		}
		
		protected function touchesNodeRight($node:ZNode):Boolean {
			return touchesNodeInDirection($node,Glob.kSpritinator.kDirR);
		}
		
		protected function touchesNodeUp($node:ZNode):Boolean {
			return touchesNodeInDirection($node,Glob.kSpritinator.kDirU);
		}
		
		protected function touchesNodeDown($node:ZNode):Boolean {
			return touchesNodeInDirection($node,Glob.kSpritinator.kDirD);
		}
		
		private function touchesNodeInDirection($node:ZNode,$direction:uint):Boolean {
			var $isTouching:Boolean = false;
			
			var $nodeX_L:Number = $node.x;
			var $nodeX_R:Number = $node.x + $node.width;
			var $nodeY_U:Number = $node.y;
			var $nodeY_D:Number = $node.y + $node.height;
			var $X_L:Number = x;
			var $X_R:Number = x + width;
			var $Y_U:Number = y;
			var $Y_D:Number = y + height;
			
			if ($direction == Glob.kSpritinator.kDirL && $X_L == $nodeX_R) {$isTouching = true;}
			if ($direction == Glob.kSpritinator.kDirR && $X_R == $nodeX_L) {$isTouching = true;}
			if ($direction == Glob.kSpritinator.kDirU && $Y_U == $nodeY_D) {$isTouching = true;}
			if ($direction == Glob.kSpritinator.kDirD && $Y_D == $nodeY_U) {$isTouching = true;}
			
			return $isTouching;
		}
	}
}