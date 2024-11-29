package;

import flixel.FlxG;
import flixel.FlxSprite;

class NoteSplash extends FlxSprite
{
	public var colorSwap:ColorSwap = null;
	private var idleAnim:String;
	private var textureLoaded:String = null;

	var sc:Array<Float> = [1.3, 1.2, 1.1, 1, 1, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4];

	public function new(x:Float = 0, y:Float = 0, ?note:Int = 0) {
		super(x, y);

		var skin:String = 'noteSplashes';
		if(PlayState.SONG.splashSkin != null && PlayState.SONG.splashSkin.length > 0) skin = PlayState.SONG.splashSkin;

		NoteSplashData.loadProperties(skin);

		loadAnims(skin);
		
		colorSwap = new ColorSwap();
		shader = colorSwap.shader;

		setupNoteSplash(x, y, note);
		if (NoteSplashData.splashesAntialiasing == false)
			antialiasing = false;
		else
			antialiasing = ClientPrefs.globalAntialiasing;
	}

	public function setupNoteSplash(x:Float, y:Float, note:Int = 0, texture:String = null, hueColor:Float = 0, satColor:Float = 0, brtColor:Float = 0) {
		NoteSplashData.loadProperties(texture);

		if (NoteSplashData.centerToStrum)
			y = PlayState.instance.playerStrums.members[note].y;
		else
			y = y - Note.swagWidth;

		setPosition(x - Note.swagWidth * 0.95, y);
		setGraphicSize(Std.int(width * sc[PlayState.mania] * NoteSplashData.size));

		alpha = NoteSplashData.splashesAlpha;

		if (NoteSplashData.splashesAntialiasing == false)
			antialiasing = false;
		else
			antialiasing = ClientPrefs.globalAntialiasing;

		if(texture == null) {
			texture = 'noteSplashes';
			if(PlayState.SONG.splashSkin != null && PlayState.SONG.splashSkin.length > 0) texture = PlayState.SONG.splashSkin;
		}

		if(textureLoaded != texture) {
			loadAnims(texture);
		}

		if (NoteSplashData.ignoreColor){
			colorSwap.hue = 0;
			colorSwap.saturation = 0;
			colorSwap.brightness = 0;
		}
		else {
			colorSwap.hue = hueColor;
			colorSwap.saturation = satColor;
			colorSwap.brightness = brtColor;
		}

		var offsets:Array<Int> = [Std.int(Note.offsets[PlayState.mania][0] - NoteSplashData.offsetX), Std.int(Note.offsets[PlayState.mania][1] - NoteSplashData.offsetY)];
		offset.set(offsets[0], offsets[1]);

		var animNum:Int = FlxG.random.int(1, 2);

		if (animation.getByName('note' + Note.keysShit.get(PlayState.mania).get('pixelAnimIndex')[note] + '-' + animNum) == null)
			animation.play(texture, true);
		else
			animation.play('note' + Note.keysShit.get(PlayState.mania).get('pixelAnimIndex')[note] + '-' + animNum, true);
		if(animation.curAnim != null)animation.curAnim.frameRate = NoteSplashData.fps + FlxG.random.int(-NoteSplashData.fpsVariation, NoteSplashData.fpsVariation);
	}

	function loadAnims(skin:String) {
		frames = Paths.getSparrowAtlas(skin);
		for (i in 1...3) {
			animation.addByPrefix('note0-' + i, 'note splash purple ' + i, 24, false);
			if (animation.getByName('note0-' + i) == null)
				animation.addByPrefix('note0-' + i, 'note splash A ' + i, 24, false);
			animation.addByPrefix('note1-' + i, 'note splash blue ' + i, 24, false);
			if (animation.getByName('note1-' + i) == null)
				animation.addByPrefix('note1-' + i, 'note splash B ' + i, 24, false);
			animation.addByPrefix('note2-' + i, 'note splash green ' + i, 24, false);
			if (animation.getByName('note2-' + i) == null)
				animation.addByPrefix('note2-' + i, 'note splash C ' + i, 24, false);
			animation.addByPrefix('note3-' + i, 'note splash red ' + i, 24, false);
			if (animation.getByName('note3-' + i) == null)
				animation.addByPrefix('note3-' + i, 'note splash D ' + i, 24, false);
			animation.addByPrefix('note4-' + i, 'note splash E ' + i, 24, false);
			animation.addByPrefix('note5-' + i, 'note splash F ' + i, 24, false);
			animation.addByPrefix('note6-' + i, 'note splash G ' + i, 24, false);
			animation.addByPrefix('note7-' + i, 'note splash H ' + i, 24, false);
			animation.addByPrefix('note8-' + i, 'note splash I ' + i, 24, false);
			animation.addByPrefix('note9-' + i, 'note splash J ' + i, 24, false);
			animation.addByPrefix('note10-' + i, 'note splash K ' + i, 24, false);
			animation.addByPrefix('note11-' + i, 'note splash L ' + i, 24, false);
			animation.addByPrefix('note12-' + i, 'note splash M ' + i, 24, false);
			animation.addByPrefix('note13-' + i, 'note splash N ' + i, 24, false);
			animation.addByPrefix('note14-' + i, 'note splash O ' + i, 24, false);
			animation.addByPrefix('note15-' + i, 'note splash P ' + i, 24, false);
			animation.addByPrefix('note16-' + i, 'note splash Q ' + i, 24, false);
			animation.addByPrefix('note17-' + i, 'note splash R ' + i, 24, false);
			//animation.addByPrefix('note9-' + i, 'note splash E ' + i, 24, false);
			animation.addByPrefix(skin, skin, 24, false);
		}
	}

	override function update(elapsed:Float) {
		if(animation.curAnim != null)if(animation.curAnim.finished) kill();

		super.update(elapsed);
	}
}