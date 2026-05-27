var shader = game.createRuntimeShader("adjustColor");

function onCreate() 
{
    // Gameplay only — HUD/health bar must not get random contrast every section.
    game.camGame.filters = [new ShaderFilter(shader)];
    shader.setFloat("contrast", 0);
}

function onSectionHit() 
{
    var num = FlxG.random.int(2, 50);
    shader.setFloat("contrast", num / 2);
}