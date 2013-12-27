package
{	
	import flash.utils.Dictionary;
	
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	
	public class StPlay extends ZState
	{
		private var isPlaying:Boolean;
		private var isDone:Boolean;
		
		private var levelFunctional:ZTilemap;
		private var wallGroup:ZGroup;
		private var wallMagicGroup:ZGroup;
		private var ballGroup:ZGroup;
		private var basketGroup:ZGroup;
		private var launcherGroup:ZGroup;
		private var grannyGroup:ZGroup;
		private var scarfGroup:ZGroup;
		private var timer:SprTimer;
		private var score:SprScore;
		
		override protected function createScene():void {
			addLevel();
			addWallGroup();
			addWallMagicGroup();
			addBallGroup();
			addBasketGroup();
			addLauncherGroup();
			addCountdown();
			addGrannyGroup();
			addScarfGroup();
			addTimer();
			addScore();
			resume();
		}
		
		private function addLevel():void {
			levelFunctional = Glob.kLeveler.levelFunctional();
			//if (Glob.kDebugOn) {add(levelFunctional);}
		}
		
		private function addWallGroup():void {
			wallGroup = levelFunctional.groupFromSpawn(GLeveler.kSpawnWall,SprWall);
			add(wallGroup);
			
			var i:uint;
			var $dictX:Dictionary = new Dictionary();
			var $dictY:Dictionary;
			var $wall:SprWall;
			for (i = 0; i < wallGroup.length; i++) {
				$wall = wallGroup.members[i];
				
				$dictY = $dictX[$wall.x];
				if (!$dictY) {
					$dictY = new Dictionary();
					$dictX[$wall.x] = $dictY;
				}
				//var $dictY:Dictionary = new Dictionary();
				//$dictX[$wall.x] = $dictY;
				$dictY[$wall.y] = true;
			}
			
			for (i = 0; i < wallGroup.length; i++) {
				
				$wall = wallGroup.members[i];
				
				var $dictXL:Dictionary = $dictX[$wall.xToL()];
				var $dictXR:Dictionary = $dictX[$wall.xToR()];
				
				if (!$dictXL || !$dictXL[$wall.y]) {
					$wall.makeL();
				}
				else if (!$dictXR || !$dictXR[$wall.y]) {
					$wall.makeR();
				}
				else {
					$wall.makeC();
				}
			}
		}
		
		private function addWallMagicGroup():void {
			wallMagicGroup = levelFunctional.groupFromSpawn(GLeveler.kSpawnWallMagic,SprWallMagic);
			add(wallMagicGroup);
			var $callbackMagic:Function = function():void {
				for (var i:uint = 0; i < wallMagicGroup.length; i++) {
					var $wallMagic:SprWallMagic = wallMagicGroup.members[i];
					$wallMagic.change();
				}
			};
			var $eventMagic:ZEvent = new ZEvent(2.0,$callbackMagic);
			add($eventMagic);
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
			
			var i:uint;
			var $basket:SprBasket;
			var $dictX:Dictionary = new Dictionary();
			var $dictY:Dictionary;
			for (i = 0; i < basketGroup.length; i++) {
				$basket = basketGroup.members[i];
				$dictY = $dictX[$basket.x];
				if (!$dictY) {
					$dictY = new Dictionary();
					$dictX[$basket.x] = $dictY;
				}
				$dictY[$basket.y] = true;
			}
			for (i = 0; i < basketGroup.length; i++) {
				$basket = basketGroup.members[i];
				
				var $dictXL:Dictionary = $dictX[$basket.xToL()];
				var $dictXR:Dictionary = $dictY[$basket.xToR()];
				
				if (!$dictXL || !$dictXL[$basket.y]) {$basket.makeL()}
				else if (!$dictXR || !$dictXR[$basket.y]) {$basket.makeR()}
				else {$basket.makeC()}
			}
		}
		
		private function addLauncherGroup():void {
			launcherGroup = levelFunctional.groupFromSpawn(GLeveler.kSpawnLauncher,SprLauncher);
			add(launcherGroup);
		}
		
		private function addCountdown():void {
			
			var $countdown:SprCountdown = new SprCountdown(3,0.44,startGame,0,Glob.height/2.0);
			add($countdown);
		}
		
		private function startGame():void {
			
			timer.start();
			
			var $eventLauncher:ZEvent;
			var $callbackLauncher:Function = function():void {
				
				if (timer.isDone()) {return;}
				
				launchBall();
				$eventLauncher = new ZEvent(1 + Math.random()*2,$callbackLauncher,false,true);
				add($eventLauncher);
			};
			$callbackLauncher();
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
		
		private function addTimer():void {
			timer = new SprTimer(150);
			add(timer);
		}
		
		private function addScore():void {
			score = new SprScore();
			score.x = Glob.width - score.width;
			add(score);
		}
		
		override public function update():void {
			if (isPlaying && !isDone) {
				super.update();
				updateScene();
			}
			else if (isDone) {
				updateDoneScene();
			}
			else {updatePauseControls();}
		}
		
		private function updateScene():void {
			collideStuff();
			catchBallsInBaskets();
			endIfTimeIsOut();
		}
		
		private function updateDoneScene():void {
			// 
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
			
			// BALLS with MAGIC WALLS
			var $callbackBallWallMagic:Function = function($ball:SprBall,$wallMagic:SprWallMagic):void {
				$ball.bounceOffWall($wallMagic);
			};
			for (var i:uint = 0; i < wallMagicGroup.length; i++) {
				var $wallMagic:SprWallMagic = wallMagicGroup.members[i];
				if ($wallMagic.isThere()) {
					FlxG.collide(ballGroup,$wallMagic,$callbackBallWallMagic);
				}
			}
			
			// FOX in SOCKS?
		}
		
		private function catchBallsInBaskets():void {
			for (var i:uint = 0; i < basketGroup.length; i++) {
				var $basket:SprBasket = basketGroup.members[i];
				for (var j:uint = 0; j < ballGroup.length; j++) {
					var $ball:SprBall = ballGroup.members[j];
					if ($ball.alive && $ball.overlaps($basket)) {
						$basket.collect($ball);
						reactIfBallCaught($ball);
					}
				}
			}
		}
		
		private function reactIfBallCaught($ball:SprBall):void {
			if ($ball.alive) {
				
				//promptTextOnNode("CONFORMISM :(",$ball);
			}
			else {
				score.addCatchPoints();
				promptTextOnNode("ANARCHY",$ball);
			}
		}
		
		private function promptTextOnNode($text:String,$node:ZNode):void {
			var $msgWidth:Number = 444;
			var $msg:ZText = new ZText($node.x + $node.width/2.0 - $msgWidth/2.0,$node.y,$msgWidth,$text);
			$msg.color = 0xff000000;
			add($msg);
			$msg.alignment = "center";
			$msg.size = 22 + Math.random()*22;
			$msg.angle = -45 + Math.random()*90;
			$msg.shadow = 0xffffffff;
			
			var $deleteEvent:ZEvent;
			var $callbackDelete:Function = function():void {
				$msg.kill();
			};
			$deleteEvent = new ZEvent(0.44,$callbackDelete,false,true);
			add($deleteEvent);
		}
		
		private function endIfTimeIsOut():void {
			if (timer.isDone()) {
				end();
			}
		}
		
		private function updatePauseControls():void {
			//
		}
		
		override protected function updateControls():void {
			
			// TEST
			if (Glob.kController.justPressed(GController.kLaunchKey)) {
				Glob.switchState(StTitle);
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
		
		private function end():void {
			addEndText();
			isDone = true;
		}
		
		private function addEndText():void {
			var $endText:ZText = new ZText(0,Glob.height/2.0,Glob.width);
			$endText.alignment = "center";
			$endText.text = "ANARCHY OVER";
			$endText.size = 99;
			add($endText);
			$endText.y -= $endText.height/2.0;
		}
	}
}