import hxvlc.flixel.FlxVideoSprite;
var webcrasher;
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
	webcrasher = new FlxVideoSprite();
	webcrasher.bitmap.onFormatSetup.add(() ->
    {
		webcrasher.setGraphicSize(FlxG.width, FlxG.height);
		webcrasher.updateHitbox();
		webcrasher.antialiasing = false;
		webcrasher.cameras = [camHUD];
	});

	webcrasher.bitmap.onOpening.add(() ->
    {
        canStartIntro = true;
        game.startCountdown();
    });

	webcrasher.bitmap.onEndReached.add(() -> { if (webcrasher != null) { webcrasher.destroy(); webcrasher = null; } });

	insert(0,webcrasher);

	if (webcrasher.load(Paths.video('web'), [':no-audio']))
    {
        webcrasher.play();
    }
}

function onCreatePost() FlxG.camera.x += 200;

function onEvent(ev,v1,v2) 
{
    if (ev == 'dumb video') 
    {
        switch (v1) 
        {
			//case 'webcrasher': webcrasher.play();
			case 'destroy2':
				FlxG.camera.flash();
				if (webcrasher != null) webcrasher.destroy();
        }
    }
}