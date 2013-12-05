package
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxObject;
	
	public class ZTilemap extends FlxTilemap
	{
		public function ZTilemap()
		{
			super();
		}
		
		/**
		 * Returns a group of objects of the specified class, located at each spawn point.
		 * 
		 * @param	$spawn	Array of spawn points
		 * @param	$class	Class of object to be spawned, must extend <code>ZNode</code>
		 * 
		 * @return	Group of objects of given class, located at spawn points
		 */
		public function groupFromSpawn($spawn:Array,$class:Class):ZGroup {
			var $group:ZGroup = new ZGroup();
			for (var i:uint = 0; i < $spawn.length; i++) {
				var $array:Array = getTileInstances($spawn[i]);
				if ($array) {
					for (var j:uint = 0; j < $array.length; j++) {
						var $point:FlxPoint = pointForTile($array[j]);
						var $object:ZNode = new $class($point.x,$point.y);
						$object.x += (width/widthInTiles)/2.0 - $object.width/2.0;
						$object.y += (width/widthInTiles)/2.0 - $object.height/2.0;
						$group.add($object);
					}
				}
			}
			return $group;
		}
		
		/**
		 * Returns the screen point associated with a tile in the map.
		 * 
		 * @param	$tile	Index of tile in array
		 * 
		 * @return	Screen point associated with that tile
		 */
		public function pointForTile($tile:uint):FlxPoint {
			var $x:Number = x + (width/widthInTiles)*(int)($tile%widthInTiles);
			var $y:Number = y + (width/widthInTiles)*(int)($tile/widthInTiles);
			var $point:FlxPoint = new FlxPoint($x,$y);
			return $point;
		}
		
		/**
		 * Sets the collision callback function for a given spawn point
		 * 
		 * param	$spawn	Array of spawn points
		 * param	$callback	The function to be called for each collision
		 */
		public function setCallbackForSpawn($spawn:Array,$callback:Function):void {
			for (var i:uint = 0; i < $spawn.length; i++) {
				setTileProperties($spawn[i],FlxObject.ANY,$callback);
			}
		}
	}
}