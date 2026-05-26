import hxvlc.flixel.FlxVideoSprite;
var o1;
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
	o1 = new FlxVideoSprite();
	o1.bitmap.onFormatSetup.add(() ->
	{
		o1.setGraphicSize(FlxG.width, FlxG.height);
		o1.updateHitbox();
		o1.antialiasing = false;
		o1.cameras = [camOther];
	});

	o1.bitmap.onOpening.add(() ->
	{
        canStartIntro = true;
        game.startCountdown();
    });

	o1.bitmap.onEndReached.add(() -> { if (o1 != null) { o1.destroy(); o1 = null; } });

	add(o1);

	if (o1.load(Paths.video('OneshotStart'), [':no-audio']))
    {
        o1.play();
    }
}

function onSongStart() 
{
	var oppPos = [for (i in game.opponentStrums) i.x];
	for (i in 0...4) 
    {
		if (!ClientPrefs.data.middleScroll) game.opponentStrums.members[i].x = game.playerStrums.members[i].x;
	}

    for (i in opponentStrums) i.x = -1000;
}