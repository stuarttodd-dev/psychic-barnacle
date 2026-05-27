-- FlxAnimate (hctwo / headcanon two): re-assert visibility after atlas load.
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
	if dadName == 'hctwo' or dadName == 'hctwofussy' or dadName == 'hctwoscared' or dadName == 'hctwodance' then
		fixFlxAnimateChar('dad')
	end
end
