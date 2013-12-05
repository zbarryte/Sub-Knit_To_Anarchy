package
{
	public class GSpritinator
	{
		public const kGravAccel:Number = 10 * Glob.kLeveler.kTileWidthOrHeight; // tile length ~ 1 meter
		
		[Embed("assets/spr_ball.png")] public const kBall:Class;
		[Embed("assets/spr_launcher.png")] public const kLauncher:Class;
		[Embed("assets/spr_wall.png")] public const kWall:Class;
		[Embed("assets/spr_basket.png")] public const kBasket:Class;
	}
}