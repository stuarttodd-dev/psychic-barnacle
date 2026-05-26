import hxvlc.flixel.FlxVideoSprite;
var dottedline;
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
	dottedline = new FlxVideoSprite();
	dottedline.bitmap.onFormatSetup.add(() ->
    {
		dottedline.setGraphicSize(FlxG.width, FlxG.height);
		dottedline.updateHitbox();
		dottedline.antialiasing = false;
		dottedline.cameras = [camOther];
	});

	dottedline.bitmap.onOpening.add(() ->
    {
        canStartIntro = true;
        game.startCountdown();
    });

	dottedline.bitmap.onEndReached.add(() -> { if (dottedline != null) { dottedline.destroy(); dottedline = null; } });

	add(dottedline);

	if (dottedline.load(Paths.video('dottedline')))
    {
        dottedline.play();
    }
}

//function onEvent(ev,v1,v2) if (ev == 'dumb video' && v1 == 'dottedline') dottedline.play();