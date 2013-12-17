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
		private var grannyGroup:ZGroup;
		private var scarfGroup:ZGroup;

		
		override protected function createScene():void {
			addLevel();
			addWallGroup();
			addBallGroup();
			addBasketGroup();
			addLauncherGroup();
			addGrannyGroup();
			addScarfGroup();
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
			basketGroup = new ZGroup();
			// RED
			var $basketGroupRed:ZGroup = levelFunctional.groupFromSpawn(GLeveler.kSpawnBasketRed,SprBasket);
			basketGroup.add($basketGroupRed);
			$basketGroupRed.color = Glob.kSpritinator.kColorR;
			// BLUE
			var $basketGroupBlue:ZGroup = levelFunctional.groupFromSpawn(GLeveler.kSpawnBasketBlue,SprBasket);
			basketGroup.add($basketGroupBlue);
			$basketGroupBlue.color = Glob.kSpritinator.kColorB;
			
			add(basketGroup);
		}
		
		private function addLauncherGroup():void {
			launcherGroup = levelFunctional.groupFromSpawn(GLeveler.kSpawnLauncher,SprLauncher);
			add(launcherGroup);
		}
		
		private function addGrannyGroup():void {
			grannyGroup = levelFunctional.groupFromSpawn(GLeveler.kSpawnGranny,SprGranny);
			add(grannyGroup);
		}
		
		private function addScarfGroup():void {
			scarfGroup = new ZGroup();
			for (var i:uint = 0; i < grannyGroup.length; i++) {
				var $granny:SprGranny = grannyGroup.members[i];
				var $scarf:SprScarf = $granny.scarf;
				scarfGroup.add($scarf);
			}
			add(scarfGroup);
		}
		
		override public function update():void {
			if (isPlaying) {
				super.update();
				updateScene();
			}
			else {updatePauseControls();}
		}
		
		private function updateScene():void {
			collideStuff();
			catchBallsInBaskets();
		}
		
		private function collideStuff():void {
			// BALLS with WALLS
			var $callbackBallWall:Function = function($ball:SprBall,$wall:SprWall):void {
				$ball.bounceOffWall($wall);
			};
			FlxG.collide(ballGroup,wallGroup,$callbackBallWall);
			
			// BALLS with BALLS
			var $callbackBallBall:Function = function($ball1:SprBall,$ball2:SprBall):void {
				$ball1.bounceOffBall($ball2);
				$ball2.bounceOffBall($ball1);
			};
			FlxG.collide(ballGroup,ballGroup,$callbackBallBall);
			
			// BALLS with SCARVES
			var $callbackBallScarf:Function = function($ball:SprBall,$scarf:SprScarf):void {
				$ball.bounceOffScarf($scarf);
			};
			FlxG.collide(ballGroup,scarfGroup,$callbackBallScarf);
			
			// GRANNIES with WALLS
			FlxG.collide(grannyGroup,wallGroup);
			
			// FOX in SOCKS?
		}
		
		private function catchBallsInBaskets():void {
			for (var i:uint = 0; i < basketGroup.length; i++) {
				var $basket:SprBasket = basketGroup.members[i];
				for (var j:uint = 0; j < ballGroup.length; j++) {
					var $ball:SprBall = ballGroup.members[j];
					if ($ball.alive && $ball.overlaps($basket)) {
						$basket.collect($ball);
						$ball.kill();
					}
				}
			}
		}
		
		private function updatePauseControls():void {
			//
		}
		
		override protected function updateControls():void {
			
			// LAUNCH BALL
			if (Glob.kController.justPressed(GController.kLaunchKey)) {
				launchBall();
			}
			
			// KNIT or UNKNIT
			if (Glob.kController.pressedAfter(GController.kKnitKey,GController.kUnknitKey)) {
				grannyKnit();
			}
			else if (Glob.kController.pressedAfter(GController.kUnknitKey,GController.kKnitKey)) {
				grannyUnknit();
			}
			
			// MOVE LEFT, MOVE RIGHT, or STOP
			if (Glob.kController.pressedAfter(GController.kLeft,GController.kRight)) {
				grannyMoveLeft();
			}
			else if (Glob.kController.pressedAfter(GController.kRight,GController.kLeft)) {
				grannyMoveRight();
			}
			else {
				grannyStop();
			}
			
		}
		
		private function launchBall():void {
			for (var i:uint = 0; i < launcherGroup.length; i++) {
				var $launcher:SprLauncher = launcherGroup.members[i];
				var $ball:SprBall = $launcher.newBall();
				ballGroup.add($ball);
			}
		}
		
		private function grannyKnit():void {
			for (var i:uint = 0; i < grannyGroup.length; i++) {
				var $granny:SprGranny = grannyGroup.members[i];
				$granny.knit();
			}
		}
		
		private function grannyUnknit():void {
			for (var i:uint = 0; i < grannyGroup.length; i++) {
				var $granny:SprGranny = grannyGroup.members[i];
				$granny.unknit();
			}
		}
		
		private function grannyMoveLeft():void {
			for (var i:uint = 0; i < grannyGroup.length; i++) {
				var $granny:SprGranny = grannyGroup.members[i];
				$granny.moveLeft();
			}
		}
		
		private function grannyMoveRight():void {
			for (var i:uint = 0; i < grannyGroup.length; i++) {
				var $granny:SprGranny = grannyGroup.members[i];
				$granny.moveRight();
			}
		}
		
		private function grannyStop():void {
			for (var i:uint = 0; i < grannyGroup.length; i++) {
				var $granny:SprGranny = grannyGroup.members[i];
				$granny.stop();
			}
		}
		
		private function pause():void {isPlaying = false;}
		private function resume():void {isPlaying = true;}
	}
}