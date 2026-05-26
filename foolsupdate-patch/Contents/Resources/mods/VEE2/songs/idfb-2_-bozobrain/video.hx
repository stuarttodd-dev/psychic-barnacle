import hxvlc.flixel.FlxVideoSprite;
var bozo;

function onCreate() 
{
	bozo = new FlxVideoSprite();
	bozo.bitmap.onFormatSetup.add(() ->
	{
		bozo.setGraphicSize(FlxG.width, FlxG.height);
		bozo.updateHitbox();
		bozo.antialiasing = false;
		bozo.cameras = [camOther];
	});
	
	bozo.load(Paths.video('bozobrain'), [':no-audio']);
	insert(10, bozo);
}

function onEvent(ev,v1,v2) 
{
    if (ev == 'dumb video') 
    {
        switch (v1) 
        {
			case 'bozo': bozo.play();
			case 'bozo2': bozo.destroy();
        }
    }
}