function onSongStart() 
{
FlxG.drawFramerate = 24;
FlxG.updateFramerate = 24;
}

import backend.Highscore;

function onEndSong() 
{
FlxG.drawFramerate = ClientPrefs.data.framerate;
FlxG.updateFramerate = ClientPrefs.data.framerate;

Highscore.saveScore('cyans-new-groove', game.songScore, 1);

FlxG.switchState(()-> new states.FreeplayState());

FlxG.sound.music.pause();
FlxG.sound.music.stop();
FlxG.sound.playMusic(Paths.music('freeplayMenu'), 0);
return Function_Stop;
}

function onDestroy()
{
FlxG.drawFramerate = ClientPrefs.data.framerate;
FlxG.updateFramerate = ClientPrefs.data.framerate;
}