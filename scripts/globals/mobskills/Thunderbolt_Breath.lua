---------------------------------------------
--  Thunderbolt
--
--  Description: Deals thunder damage to enemies within a fan-shaped area originating from the caster.
--  Type: Magical (Thunder)
--
--
---------------------------------------------
require("/scripts/globals/settings");
require("/scripts/globals/status");
require("/scripts/globals/monstertpmoves");
---------------------------------------------
function OnMobSkillCheck(target,mob,skill)
    -- not used in Uleguerand_Range
    if(mob:getZone() == 5) then
        return 1;
    end
    return 0;
end;

function OnMobWeaponSkill(target, mob, skill)

    local typeEffect = EFFECT_STUN;
    if(target:hasStatusEffect(typeEffect) == false) then
        local statmod = MOD_INT;
        local resist = applyPlayerResistance(mob,skill,target,mob:getMod(statmod)-target:getMod(statmod),0,8);
        if(resist > 0.1) then
            target:addStatusEffect(typeEffect,1,0,math.random(5,10));--power=1;tic=0;duration=120;
        end
    end

    local dmgmod = MobBreathMove(mob, target, 0.333, 0.625, ELE_THUNDER, 500);

    local dmg = MobFinalAdjustments(dmgmod,mob,skill,target,MOBSKILL_MAGICAL,MOBPARAM_THUNDEr,MOBPARAM_IGNORE_SHADOWS);

    target:delHP(dmg);
    return dmg;
end;
