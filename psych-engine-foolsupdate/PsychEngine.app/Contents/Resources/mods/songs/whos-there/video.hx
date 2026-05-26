import hxvlc.flixel.FlxVideoSprite;
var evilv1;
var evilv2;
var canStartIntro = false;

function onStartCountdown()
{
    if (!canStartIntro) return Function_Stop;
    else
    {
        return Function_Continue;
    }
}

function onCreate() 
{
	evilv1 = new FlxVideoSprite();
	evilv1.bitmap.onFormatSetup.add(() ->
    {
		evilv1.setGraphicSize(FlxG.width, FlxG.height);
		evilv1.updateHitbox();
		evilv1.antialiasing = false;
		evilv1.cameras = [camHUD];
	});

    evilv1.bitmap.onOpening.add(() ->
    {
        canStartIntro = true;
        game.startCountdown();
    });

    evilv1.bitmap.onEndReached.add(() -> { if (evilv1 != null) { evilv1.destroy(); evilv1 = null; } });

	insert(0, evilv1);

	if (evilv1.load(Paths.video('evil1'), [':no-audio']))
    {
        new FlxTimer().start(0.02, () -> evilv1.play());
    }

	evilv2 = new FlxVideoSprite();
	evilv2.bitmap.onFormatSetup.add(() ->
    {
		evilv2.setGraphicSize(FlxG.width, FlxG.height);
		evilv2.updateHitbox();
		evilv2.antialiasing = false;
		evilv2.cameras = [camOther];
	});
    
	evilv2.load(Paths.video('evil2'),[':no-audio']);
	add(evilv2);

    // cacheVid disabled: Video4.cacheVid(Paths.video('evil2'));
}

function onEvent(ev,v1,v2) 
{
    if (ev == 'dumb video') 
    {
        switch (v1) 
        {
			case 'evil1end': if (evilv1 != null) evilv1.destroy();
            case 'evil2': evilv2.play();
        }
    }
}