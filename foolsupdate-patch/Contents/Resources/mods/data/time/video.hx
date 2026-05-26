import hxvlc.flixel.FlxVideoSprite;
var time;
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
	time = new FlxVideoSprite();
	time.bitmap.onFormatSetup.add(() ->
    {
		time.setGraphicSize(FlxG.width, FlxG.height);
		time.updateHitbox();
		time.antialiasing = false;
		time.cameras = [camOther];
	});

	time.bitmap.onOpening.add(() ->
    {
        canStartIntro = true;
        game.startCountdown();
    });

	time.bitmap.onEndReached.add(() -> { if (time != null) { time.destroy(); time = null; } });

	add(time);

	if (time.load(Paths.video('time'), [':no-audio']))
    {
        time.play();
    }
}