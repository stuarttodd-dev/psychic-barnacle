-- FlxAnimate (dank4 / soulful four): re-assert visibility after atlas load.
function fixFlxAnimateChar(tag)
	runHaxeCode([[
		var tag:String = ']] .. tag .. [[';
		var char:Dynamic = Reflect.getProperty(game, tag);
		if (char == null || !char.isAnimateAtlas) return;
		char.visible = true;
		char.alpha = 1;
		if (char.atlas != null) {
			char.atlas.visible = true;
			char.atlas.alpha = 1;
		}
		if (char.atlas != null && char.atlas.anim != null && char.atlas.anim.curInstance == null && char.hasAnimation('idle')) {
			char.playAnim('idle', true);
		}
		char.copyAtlasValues();
	]]);
end

function onCreatePost()
	if boyfriendName == 'dank4' or boyfriendName == 'dank4start' or boyfriendName == 'dank4-dead' or boyfriendName == 'delete4' or boyfriendName == 'fried4' then
		fixFlxAnimateChar('boyfriend')
	end
end
