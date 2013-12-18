package
{	
	public class GLeveler
	{	
		public static const kSpawnWall:Array = [1];
		public static const kSpawnLauncher:Array = [2];
		public static const kSpawnBasketBlue:Array = [3];
		public static const kSpawnGranny:Array = [4];
		public static const kSpawnBasketRed:Array = [5];
		public static const kSpawnWallMagic:Array = [6];
		
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
	}
}