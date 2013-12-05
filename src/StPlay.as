package
{	
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	
	public class StPlay extends ZState
	{
		private var isPlaying:Boolean;
		
		private var levelFunctional:ZTilemap;
		private var wallGroup:ZGroup;
		private var ballGroup:ZGroup;
		private var basketGroup:ZGroup;
		private var launcherGroup:ZGroup;

		
		override protected function createScene():void {
			addLevel();
			addWallGroup();
			addBallGroup();
			addBasketGroup();
			addLauncherGroup();
			resume();
		}
		
		private function addLevel():void {
			levelFunctional = Glob.kLeveler.levelFunctional();
			if (Glob.kDebugOn) {add(levelFunctional);}
		}
		
		private function addWallGroup():void {
			wallGroup = levelFunctional.groupFromSpawn(GLeveler.kSpawnWall,SprWall);
			add(wallGroup);
		}
		
		private function addBallGroup():void {
			ballGroup = new ZGroup();
			add(ballGroup);
		}
		
		private function addBasketGroup():void {
			basketGroup = levelFunctional.groupFromSpawn(GLeveler.kSpawnBasket,SprBasket);
			add(basketGroup);
		}
		
		private function addLauncherGroup():void {
			launcherGroup = levelFunctional.groupFromSpawn(GLeveler.kSpawnLauncher,SprLauncher);
			add(launcherGroup);
		}
		
		override public function update():void {
			if (isPlaying) {
				super.update();
				updateScene();
			}
			else {updatePauseControls();}
		}
		
		private function updateScene():void {
			FlxG.collide(ballGroup,wallGroup);
			FlxG.collide(ballGroup,ballGroup);
		}
		
		private function updatePauseControls():void {
			//
		}
		
		override protected function updateControls():void {
			if (Glob.kController.justPressed(GController.kLaunchKey)) {
				launchBall();
			}
		}
		
		private function launchBall():void {
			for (var i:uint = 0; i < launcherGroup.length; i++) {
				var $launcher:SprLauncher = launcherGroup.members[i];
				var $ball:SprBall = $launcher.newBall();
				ballGroup.add($ball);
			}
		}
		
		private function pause():void {isPlaying = false;}
		private function resume():void {isPlaying = true;}
	}
}