package
{
	import org.flixel.FlxSprite;
	
	public class ZNode extends FlxSprite
	{
		public var xLocal:Number;
		public var yLocal:Number;
		
		protected var _children:ZGroup;
		
		public function ZNode($x:Number=0,$y:Number=0,$simpleGraphic:Class=null)
		{
			xLocal = $x;
			yLocal = $y;
			super(xLocal,yLocal,$simpleGraphic);
			
			_children = new ZGroup();
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
			$child.x = x + $child.xLocal;
			$child.y = y + $child.yLocal;
		}
		
		override public function draw():void {
			if (!visible) {return;}
			super.draw();
			_children.draw();
		}
	}
}