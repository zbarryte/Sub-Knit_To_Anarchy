package
{
	import org.flixel.FlxGroup
	
	public class StPlay extends ZState
	{
		private var levelFunctional:ZTilemap;
		private var ballGroup:FlxGroup;
		private var launcherGroup:FlxGroup;

		
		override protected function createScene():void {
			addLevel();
			addBallGroup();
			addLauncherGroup();
		}
		
		private function addLevel():void {
			levelFunctional = Glob.kLeveler.levelFunctional();
			if (Glob.kDebugOn) {add(levelFunctional);}
		}
		
		private function addBallGroup():void {
			ballGroup = new FlxGroup();
			add(ballGroup);
		}
		
		private function addLauncherGroup():void {
			launcherGroup = Glob.kLeveler.groupFromSpawn(GLeveler.kSpawnLauncher,SprLauncher,levelFunctional);
			add(launcherGroup);
		}
		
		override protected function updateControls():void {
			if (Glob.kController.justPressed(["SPACE"])) {
				launchBall();
			}
		}
		
		private function launchBall():void {
			Glob.log(launcherGroup.length);
			for (var i:uint = 0; i < launcherGroup.length; i++) {
				var $launcher:SprLauncher = launcherGroup.members[i];
				var $ball:SprBall = $launcher.newBall();
				ballGroup.add($ball);
			}
		}
	}
}