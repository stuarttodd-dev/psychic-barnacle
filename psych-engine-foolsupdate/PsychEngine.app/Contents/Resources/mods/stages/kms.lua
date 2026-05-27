function onCreate() 
setProperty('textmiss.alpha',1)
setProperty('bars.alpha',1)

-- BG 1543x878, horizon at y=447 from sprite top. Screen-fixed so letterbox window stays framed.
-- y=-400: large upward shift so grass/horizon fill the letterbox window (not low in frame).
makeLuaSprite('p1','backgrounds/kms/BG',-132,-400)
setScrollFactor('p1', 0, 0)
scaleObject('p1', 1, 1)
addLuaSprite('p1', false)
setProperty('p1.alpha', 1)
setProperty('camGame.bgColor', getColorFromHex('6EC5E8'))
if not hideCards then
makeLuaSprite('p', 'rendersnlogos/popcorn render',1500,50)
setProperty('p.alpha',0)
scaleObject('p',0.75,0.75)
setObjectCamera('p','camHUD')
addLuaSprite('p',false)

makeLuaSprite('logos', 'rendersnlogos/fkms',0,0)
screenCenter('logos','xy')
setProperty('logos.alpha',0)
setObjectCamera('logos','camHUD')
addLuaSprite('logos',true)
end

makeAnimatedLuaSprite('puss', 'backgrounds/kms/thisguyfuckingrocks',-5,680)
addAnimationByPrefix('puss', 'stupid', 'nutty stroll instance',24,true)
scaleObject('puss',1.75,1.75)
addLuaSprite('puss',true)
end

function onCreatePost()
setObjectOrder('dadGroup',getObjectOrder('puss')-1)
setProperty('bar1.alpha', 0)
setProperty('bar2.alpha', 0)
setProperty('isCameraOnForcedPos', true)
setProperty('camFollow.x', 640)
setProperty('camFollow.y', 780)
setProperty('defaultCamZoom', 1)
setProperty('camGame.zoom', 1)
runHaxeCode('FlxG.camera.snapToTarget();')
end

function onEvent(name,v1)
if name == 'Trigger' and v1 == 'renderin' then
doTweenAlpha('logoshit3','p',1,2,'quadOut')
doTweenX('logoshit5','p',800,1.75,'circOut')
doTweenAlpha('logoshit','logos',1,2,'quadOut')
elseif name == 'Trigger' and v1 == 'renderout' then
doTweenAlpha('logoshit2','logos',0,2,'quadOut')
doTweenX('logoshit6','p',1500,2,'quadIn')
doTweenAlpha('logoshit4','p',0,2,'quadOut')
elseif name == 'Trigger' and v1 == 'nutstart' then
doTweenX('pussytween','puss',850,3.1,'linear')
elseif name == 'Trigger' and v1 == 'nutstop' then
addAnimationByPrefix('puss', 'stop', 'nutty stop instance',24,false)
end
end

function onUpdatePost()
setProperty('bar1.alpha', 0)
setProperty('bar2.alpha', 0)

setProperty('iconP1.x',250)
setProperty('iconP2.x',850)
setProperty('iconP2.flipX',true)
setProperty('iconP1.flipX',true)
setProperty('healthBar.flipX',true)

if getProperty('isCameraOnForcedPos') then
setProperty('camFollow.x', 640)
setProperty('camFollow.y', 780)
end

if getProperty('puss.animation.curAnim.finished') and getProperty("puss.animation.curAnim.name") == 'stop' then
addAnimationByPrefix('puss', 'turn', 'nutty turn instance',24,false)
elseif getProperty('puss.animation.curAnim.finished') and getProperty("puss.animation.curAnim.name") == 'turn' then
addAnimationByPrefix('puss', 'stupid', 'nutty macarena instance',24,true)
setProperty('puss.x',815)
end
end
