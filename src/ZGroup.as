package
{
	import org.flixel.FlxBasic;
	import org.flixel.FlxGroup;

	public class ZGroup extends FlxGroup
	{
		public function ZGroup($maxSize:uint=0)
		{
			super($maxSize);
		}
		
		override public function add($object:FlxBasic):FlxBasic {
			var $group:ZGroup = $object as ZGroup;
			if ($group) {
				for (var i:uint = 0; i < $group.length; i++) {
					super.add($group.members[i]);
				}
				return $object;
			}
			return super.add($object);
		}
		
		public function set color($color:uint):void {
			for (var i:uint = 0; i < length; i++) {
				members[i].color = $color;
			}
		}
	}
}