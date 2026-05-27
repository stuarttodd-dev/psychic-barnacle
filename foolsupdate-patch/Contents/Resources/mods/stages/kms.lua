function onCreate() 
setProperty('textmiss.alpha',1)
setProperty('bars.alpha',1)

-- BG art is 1543x878; horizon (sky→ground) is at pixel y=447 (51% from top).
-- Scroll 1,1 (world-space) + camera forced to y=840 in onCreatePost puts the
-- viewport at world y=480–1200 so the full BG is covered and the horizon lands
-- at ~51% of the screen with characters visible above it.
makeLuaSprite('p1','backgrounds/kms/BG',0,400)
setScrollFactor('p1', 1, 1)
scaleObject('p1', 1, 1)
addLuaSprite('p1', false)
setProperty('p1.alpha', 1)
setProperty('camGame.bgColor', getColorFromHex('000000'))
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

makeAnimatedLuaSprite('puss', 'backgrounds/kms/thisguyfuckingrocks',-5,840)
addAnimationByPrefix('puss', 'stupid', 'nutty stroll instance',24,true)
scaleObject('puss',1.75,1.75)
addLuaSprite('puss',true)
end

function onCreatePost()
setObjectOrder('dadGroup',getObjectOrder('puss')-1)
-- camera_speed=0 keeps followLerp=0 (camera never follows characters).
-- Force the camera to world y=840 so the BG viewport is y=480–1200,
-- covering the full image with the sky/ground horizon at ~51% of screen.
setProperty('camFollow.x', 640)
setProperty('camFollow.y', 840)
setProperty('isCameraOnForcedPos', true)
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
setProperty('iconP1.x',250)
setProperty('iconP2.x',850)
setProperty('iconP2.flipX',true)
setProperty('iconP1.flipX',true)
setProperty('healthBar.flipX',true)

if getProperty('puss.animation.curAnim.finished') and getProperty("puss.animation.curAnim.name") == 'stop' then
addAnimationByPrefix('puss', 'turn', 'nutty turn instance',24,false)
elseif getProperty('puss.animation.curAnim.finished') and getProperty("puss.animation.curAnim.name") == 'turn' then
addAnimationByPrefix('puss', 'stupid', 'nutty macarena instance',24,true)
setProperty('puss.x',815)
end
end