package
{
	public class GSpritinator
	{
		public const kGravAccel:Number = 22 * Glob.kLeveler.kTileWidthOrHeight; // tile length ~ 1 meter
		
		[Embed("assets/spr_ball.png")] public const kBall:Class;
		[Embed("assets/spr_launcher.png")] public const kLauncher:Class;
		[Embed("assets/spr_wall.png")] public const kWall:Class;
		[Embed("assets/spr_basket.png")] public const kBasket:Class;
		[Embed("assets/spr_granny.png")] public const kGranny:Class;
		[Embed("assets/spr_scarf_segment.png")] public const kScarfSegment:Class;
		[Embed("assets/spr_wall_magic.png")] public const kWallMagic:Class;
		[Embed("assets/spr_fire.png")] public const kFire:Class;
		
		public const kColorR:uint = 0xffff8888;
		public const kColorG:uint = 0xff00ff00;
		public const kColorB:uint = 0xff000088;
		private const kColors:Array = [kColorR,kColorG,kColorB,kColorR,kColorB];
		
		public const kDirL:uint = 0;
		public const kDirR:uint = 1;
		public const kDirU:uint = 2;
		public const kDirD:uint = 3;
		
		public function randomColor():uint {
			var $index:uint = Math.random()*(kColors.length);
			return kColors[$index];
		}
	}
}