import hxvlc.flixel.FlxVideoSprite;
var sp;

function onCreate() 
{
	sp = new FlxVideoSprite();
	sp.bitmap.onFormatSetup.add(() ->
	{
		sp.setGraphicSize(FlxG.width, FlxG.height);
		sp.updateHitbox();
		sp.antialiasing = false;
		sp.cameras = [camHUD];
	});

	sp.load(Paths.video('spookyf'), [':no-audio']);
	// cacheVid disabled: Video4.cacheVid(Paths.video('spookyf'));
	insert(0, sp);
}

function onEvent(ev,v1,v2) if (ev == 'dumb video' && v1 == 'spooky') sp.play();