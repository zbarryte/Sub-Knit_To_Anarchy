package
{
	//import org.flixel.FlxObject;
	
	public class SprBall extends ZNode
	{	
		private const kLaunchVelX:Number = 5 * Glob.kLeveler.kTileWidthOrHeight;
		private const kVelAverageX:Number = 2 * Glob.kLeveler.kTileWidthOrHeight;
		private const kBounceDecayY:Number = 0.5;
		private const kBounceDecayX:Number = 0.95;
		//private const kDragX:Number = 1 * Glob.kLeveler.kTileWidthOrHeight;
		
		protected var _prevVelX:Number;
		public function get prevVelX():Number {return _prevVelX;}
		public function set prevVelX($prevVelX:Number):void {
			_prevVelX = $prevVelX;
		}
		protected var _prevVelY:Number;
		public function get prevVelY():Number {return _prevVelY;}
		public function set prevVelY($prevVelY:Number):void {
			_prevVelY = $prevVelY;
		}
		
		protected var _fire:SprFire;
		protected var _halo:SprBallHalo;
		
		public function SprBall($x:Number=0, $y:Number=0)
		{
			super($x, $y, Glob.kSpritinator.kBall);
			
			acceleration.y = Glob.kSpritinator.kGravAccel;
			var $assignmentColor:uint = Glob.kSpritinator.randomColor();
			color = $assignmentColor;
						
			if ($assignmentColor == Glob.kSpritinator.kColorG) {
				_halo = new SprBallHalo();
				add(_halo);
				_halo.xLocal = width/2.0 - _halo.width/2.0;
				_halo.yLocal = height/2.0 - _halo.height/2.0;
			}
			
			maxVelocity.x = kLaunchVelX;
			
			prevVelX = 0;
			prevVelY = 0;
			
			//drag.x = kDragX;
			
			maxVelocity.y = kLaunchVelX*2.0;
			
			var $burnOut:Function = function():void {
				kill();
			};
			_fire = new SprFire($burnOut);
			_fire.xLocal = width/2.0 - _fire.width/2.0;
			_fire.yLocal = height/2.0 - _fire.height/2.0;
			add(_fire);
		}
		
		public function launch():void {
			velocity.x = kLaunchVelX;
		}
		
		public function bounceOffWall($wall:SprWall):void {
			
			// BOUNCE LEFT or RIGHT
			if (touchesNodeLeft($wall) || touchesNodeRight($wall)) {
				velocity.x = -prevVelX;
			}
			// BOUNCE UP or DOWN
			if (touchesNodeUp($wall)) {
				velocity.y = -prevVelY;
			}
			else if (touchesNodeDown($wall)) {
				velocity.y = -prevVelY * kBounceDecayY;
			}
		}
		
		public function bounceOffBall($ball:SprBall):void {
			
			if ($ball.isBurning()) {burn();}
			
			// BOUNCE LEFT or RIGHT
			if (touchesNodeLeft($ball) || touchesNodeRight($ball)) {
				velocity.x = -prevVelX + $ball.prevVelX;
			}
			// BOUNCE UP or BOUNCE DOWN
			if (touchesNodeUp($ball)) {
				velocity.y = -prevVelY + $ball.prevVelY;
			}
			else if (touchesNodeDown($ball)) {
				velocity.y = (-prevVelY * kBounceDecayY) + $ball.prevVelY;
			}
		}
		
		public function bounceOffScarf($scarf:SprScarf):void {
			// BOUNCE LEFT or RIGHT
			if (touchesNodeLeft($scarf) || touchesNodeRight($scarf)) {
				velocity.x = -prevVelX + $scarf.bounceFactor();
			}
			// BOUNCE UP or DOWN
			if (touchesNodeUp($scarf) || touchesNodeDown($scarf)) {
				velocity.y = -prevVelY + $scarf.bounceFactor();
			}
		}
		
		override public function update():void {
			super.update();
			if (velocity.x > kVelAverageX) {
				velocity.x *= kBounceDecayX;
			}
			prevVelX = velocity.x;
			prevVelY = velocity.y;
			
			var $dTheta:Number = velocity.x/width; // except, should actually calculate this
			angle += $dTheta;
		}
		
		public function bounceBackHardAndCatchFire():void {
			velocity.x = -velocity.x*0.75;
			velocity.y = -velocity.y*4;
			
			if (velocity.y > 0) {velocity.y *= -1;}
			
			burn();
		}
		
		public function burn():void {
			_fire.burn();
		}
		
		public function isBurning():Boolean {
			return _fire.isBurning();
		}
		
		/*
		public function burn():void {
			velocity.x = -velocity.x*1.22;
			velocity.y = -velocity.y*
		}
		*/
		
		/*
		private function bounce():void {
			if (isTouching(FlxObject.LEFT)) {
				velocity.x = kLaunchVelX;
			} else if (isTouching(FlxObject.RIGHT)) {
				velocity.x = -kLaunchVelX;
			}
			
			if ((justTouched(FlxObject.DOWN) && 0 < prevVelY) || (justTouched(FlxObject.UP) && prevVelY < 0)) {
				velocity.y = -prevVelY * 0.44;
			}
			
			if ((justTouched(FlxObject.LEFT) && prevVelX < 0) || (justTouched(FlxObject.RIGHT) && 0 < prevVelX)) {
				velocity.x = -prevVelX;
			}
			prevVelX = velocity.x;
			prevVelY = velocity.y;
		}
		*/
	}
}