package
{
	public class SprWallMagic extends SprWall
	{
		private const kAnimAppear:String = "kAnimAppear";
		private const kAnimVanish:String = "kAnimVanish";
		
		public function SprWallMagic($x:Number=0, $y:Number=0, $simpleGraphic:Class=null)
		{
			super($x,$y);
			loadGraphic(Glob.kSpritinator.kWallMagic,true,false,32,32);
			
			addAnimation(kAnimAppear,[3,2,1,0],11,false);
			addAnimation(kAnimVanish,[0,1,2,3],11,false);
			
			vanish();
		}
		
		public function vanish():void {
			play(kAnimVanish);
		}
		
		public function appear():void {
			play(kAnimAppear);
		}
		
		public function isThere():Boolean {
			return frame == 0;
		}
		
		public function change():void {
			if (isThere()) {vanish();}
			else {appear();}
		}
	}
}