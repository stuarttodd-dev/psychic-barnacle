import hxvlc.flixel.FlxVideoSprite;
var bossy;

function onCreate() 
{
	bossy = new FlxVideoSprite();
	bossy.bitmap.onFormatSetup.add(() ->
	{
		bossy.setGraphicSize(FlxG.width, FlxG.height);
		bossy.updateHitbox();
		bossy.antialiasing = false;
		bossy.cameras = [camOther];
	});
	
	bossy.load(Paths.video('bossy'), [':no-audio']);
	insert(0, bossy);
}

function onEvent(ev,v1,v2) 
{
    if (ev == 'dumb video') 
    {
        switch (v1) 
        {
			case 'bossy': bossy.play();
			case 'bossy2': bossy.destroy();
        }
    }
}