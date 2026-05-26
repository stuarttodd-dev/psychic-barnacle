import hxvlc.flixel.FlxVideoSprite;
var a;
var b;

function onCreate() 
{
	a = new FlxVideoSprite();
	a.bitmap.onFormatSetup.add(() ->
	{
		a.setGraphicSize(FlxG.width, FlxG.height);
		a.updateHitbox();
		a.cameras = [camOther];
	});

	a.load(Paths.video('aewbcintro'), [':no-audio']);
	add(a);

	b = new FlxVideoSprite();
	b.bitmap.onFormatSetup.add(() ->
	{
		b.setGraphicSize(FlxG.width, FlxG.height);
		b.updateHitbox();
		b.cameras = [camOther];
	});

	b.load(Paths.video('outro'), [':no-audio']);
	add(b);
}

function onSongStart() 
{
	if (a.load(Paths.video('aewbcintro'), [':no-audio']))
		{
			a.play();
		}

	var oppPos = [for (i in game.opponentStrums) i.x];
	for (i in 0...4) 
    {
		if (!ClientPrefs.data.middleScroll) game.opponentStrums.members[i].x = game.playerStrums.members[i].x;
	}

    for (i in opponentStrums) i.x = -1000;
}

function onEvent(ev,v1,v2) 
{
    if (ev == 'dumb video') 
    {
        switch (v1) 
        {
			case 'destroy': FlxG.camera.flash(); if (a != null) a.destroy();
			case 'ending': b.play();
		}
	}
}