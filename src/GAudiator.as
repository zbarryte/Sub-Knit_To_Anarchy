package
{
	import org.flixel.FlxSound;
	
	public class GAudiator
	{
		[Embed(source="assets/song_play.mp3")] private static const kSongPlayMP3:Class;
		public static const kSongPlay:FlxSound = new FlxSound().loadEmbedded(kSongPlayMP3,true);
		
		[Embed(source="assets/sfx_ball_launch.mp3")] private const kSfxBallLaunchMP3:Class;
		private const kSfxBallLaunch:FlxSound = new FlxSound().loadEmbedded(kSfxBallLaunchMP3);
		
		[Embed(source="assets/sfx_die.mp3")] private const kSfxDieMP3:Class;
		private const kSfxDie:FlxSound = new FlxSound().loadEmbedded(kSfxDieMP3);
		
		[Embed(source="assets/sfx_fire.mp3")] private const kSfxFireMP3:Class;
		private const kSfxFire:FlxSound = new FlxSound().loadEmbedded(kSfxFireMP3);
		
		[Embed(source="assets/sfx_catch_000.mp3")] private const kSfxCatch000MP3:Class;
		private const kSfxCatch000:FlxSound = new FlxSound().loadEmbedded(kSfxCatch000MP3);
		
		[Embed(source="assets/sfx_catch_001.mp3")] private const kSfxCatch001MP3:Class;
		private const kSfxCatch001:FlxSound = new FlxSound().loadEmbedded(kSfxCatch001MP3);
		
		[Embed(source="assets/sfx_catch_002.mp3")] private const kSfxCatch002MP3:Class;
		private const kSfxCatch002:FlxSound = new FlxSound().loadEmbedded(kSfxCatch002MP3);
		
		private const kCatchSounds:Array = [kSfxCatch000,kSfxCatch001,kSfxCatch002];
		
		public function GAudiator()
		{
		}
		
		public function play($song:FlxSound):void {$song.play();}
		public function stop($song:FlxSound):void {$song.stop();}
		
		public function playFire():void {play(kSfxFire); kSfxFire.volume = 0.22;}
		
		public function playDie():void {play(kSfxDie); kSfxDie.volume = 0.22;}
		
		public function playBallLaunch():void {play(kSfxBallLaunch); kSfxBallLaunch.volume = 0.44;}
			
		public function playCatch():void {play(randCatch());}
		
		private function randCatch():FlxSound {
			var $index:uint = Math.random()*(kCatchSounds.length);
			var $sound:FlxSound = kCatchSounds[$index];
			$sound.volume = 0.33;
			return $sound;
		}
	}
}