package
{	
	public class GLeveler
	{
		import org.flixel.FlxObject;
		import org.flixel.FlxPoint;
		import org.flixel.FlxGroup;
		
		public static const kSpawnLauncher:Array = [3];
		
		public function GLeveler() {
			num = 0;
		}
		
		public const kTileWidthOrHeight:Number = 32;
		
		public function levelFunctional():ZTilemap {
			var $csv:Class = functionalCSV();
			var $level:ZTilemap = new ZTilemap();
			$level.loadMap(new $csv,kTilesFunc,kTileWidthOrHeight,kTileWidthOrHeight);
			return $level;
		}
		
		// FUNCTIONAL
		[Embed("assets/tiles_functional.png")] private const kTilesFunc:Class;
		[Embed("assets/mapCSV_functional_001.csv",mimeType="application/octet-stream")] private const kFunc001:Class;
		
		private const functionalCSVs:Array = [kFunc001];
		
		private function functionalCSV():Class {return functionalCSVs[num];}
		
		protected var _num:uint;
		public function get num():uint {return _num;}
		public function set num($num:uint):void {
			if ($num < 0 || functionalCSVs.length <= $num) {return;}
			_num = $num;
		}
		
		/**
		 * Returns a group of objects of the specified class, located at each spawn point.
		 */
		public function groupFromSpawn($spawn:Array,$class:Class,$level:ZTilemap):FlxGroup {
			var $group:FlxGroup = new FlxGroup();
			for (var i:uint = 0; i < $spawn.length; i++) {
				var $array:Array = $level.getTileInstances($spawn[i]);
				if ($array) {
					for (var j:uint = 0; j < $array.length; j++) {
						var $point:FlxPoint = pointForTile($array[j],$level);
						var $object:FlxObject = new $class($point.x,$point.y);
						$object.x += ($level.width/$level.widthInTiles)/2.0 - $object.width/2.0;
						$object.y += ($level.width/$level.widthInTiles)/2.0 - $object.height/2.0;
						$group.add($object);
					}
				}
			}
			return $group;
		}
		
		/**
		 * Returns the screen point associated with a tile in the map.
		 */
		public function pointForTile($tile:uint,$map:ZTilemap):FlxPoint {
			var $x:Number = $map.x + ($map.width/$map.widthInTiles)*(int)($tile%$map.widthInTiles);
			var $y:Number = $map.y + ($map.width/$map.widthInTiles)*(int)($tile/$map.widthInTiles);
			var $point:FlxPoint = new FlxPoint($x,$y);
			return $point;
		}
		
		
	}
}