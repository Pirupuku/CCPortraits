local function log(msg) DEFAULT_CHAT_FRAME:AddMessage(msg) end -- alias for convenience
local CCPortraits = CreateFrame("Frame", nil, UIParent);

local t = PlayerFrame:CreateFontString("Status", "OVERLAY", "GameTooltipText")
t:SetPoint("CENTER", PlayerFrame.portrait, "CENTER")
t:SetFont("Interface\\AddOns\\CCPortraits\\Fonts\\FrizQuaT_Bold.ttf", 32)
t:SetTextColor(255, 204, 0, 1)

local iconPath="Interface\\Addons\\CCPortraits\\UI-CLASSES-CIRCLES"

-- copied from TBC Client 2.4.3
local CLASS_BUTTONS = {
	["HUNTER"] = {
		0, -- [1]
		0.25, -- [2]
		0.25, -- [3]
		0.5, -- [4]
	},
	["WARRIOR"] = {
		0, -- [1]
		0.25, -- [2]
		0, -- [3]
		0.25, -- [4]
	},
	["ROGUE"] = {
		0.49609375, -- [1]
		0.7421875, -- [2]
		0, -- [3]
		0.25, -- [4]
	},
	["MAGE"] = {
		0.25, -- [1]
		0.49609375, -- [2]
		0, -- [3]
		0.25, -- [4]
	},
	["PRIEST"] = {
		0.49609375, -- [1]
		0.7421875, -- [2]
		0.25, -- [3]
		0.5, -- [4]
	},
	["WARLOCK"] = {
		0.7421875, -- [1]
		0.98828125, -- [2]
		0.25, -- [3]
		0.5, -- [4]
	},
	["DRUID"] = {
		0.7421875, -- [1]
		0.98828125, -- [2]
		0, -- [3]
		0.25, -- [4]
	},
	["SHAMAN"] = {
		0.25, -- [1]
		0.49609375, -- [2]
		0.25, -- [3]
		0.5, -- [4]
	},
	["PALADIN"] = {
		0, -- [1]
		0.25, -- [2]
		0.5, -- [3]
		0.75, -- [4]
	},
}

local ccBuffs = {
	"Interface\\Icons\\Spell_Holy_SealOfValor",					-- Blessing of Freedom (Paladin)
	"Interface\\Icons\\Spell_Holy_SealOfProtection",			-- Blessing of Protection (Paladin)
	"Interface\\Icons\\INV_Potion_13",							-- Light of Elune (Item)
	"Interface\\Icons\\INV_Potion_07", 							-- Living Action Potion (Item)
	"Interface\\Icons\\INV_Potion_04", 							-- Free Action Potion (Item)
	"Interface\\Icons\\INV_Potion_62", 							-- Limited Invulnerability Potion (Item)
}

local ccDebuffs = {
	"Interface\\Icons\\Spell_Shadow_GatherShadows", 			-- Blackout (Priest)
	"Interface\\Icons\\Spell_Shadow_ImpPhaseShift", 			-- Silence (Priest)
	"Interface\\Icons\\Spell_Shadow_PsychicScream", 			-- Psychic Scream (Priest)
	"Interface\\Icons\\Spell_Nature_StrangleVines", 			-- Entangling Roots (Druid)
	"Interface\\Icons\\Spell_Nature_Sleep", 					-- Hibernate (Druid) / Magic Dust (Item)
	"Interface\\Icons\\Ability_Druid_Bash", 					-- Bash (Druid)
	"Interface\\Icons\\Ability_Hunter_Pet_Bear", 				-- Feral Charge (Druid)
	"Interface\\Icons\\Ability_Druid_SupriseAttack", 			-- Pounce (Druid)
	"Interface\\Icons\\Spell_Frost_IceShock", 					-- Counterspell (Mage)
	"Interface\\Icons\\Spell_Nature_Polymorph", 				-- Polymorph (Mage)
	"Interface\\Icons\\Spell_Magic_PolymorphPig", 				-- Polymorph: Pig (Mage)
	"Interface\\Icons\\Spell_Fire_MeteorStorm", 				-- Impact (Mage)
	"Interface\\Icons\\Spell_Frost_IceStorm", 					-- Blizzard (Mage)
	"Interface\\Icons\\Spell_Frost_Glacier", 					-- Cone of Cold (Mage)
	"Interface\\Icons\\Spell_Frost_FrostArmor02", 				-- Frost Armor (Mage)
	"Interface\\Icons\\Spell_Frost_FrostNova", 					-- Frost Nova (Mage)
	"Interface\\Icons\\Spell_Frost_FrostBolt02", 				-- Frostbolt (Mage)
	"Interface\\Icons\\Spell_Frost_FrostArmor02", 				-- Ice Armor (Mage)
	"Interface\\Icons\\Spell_Frost_FrostArmor", 				-- Frostbite (Mage)
	"Interface\\Icons\\Ability_Devour", 						-- Intimidation (Hunter)
	"Interface\\Icons\\Ability_Druid_Cower", 					-- Scare Beast (Hunter)
	"Interface\\Icons\\Spell_Frost_Stun", 						-- Concussive Shot (Hunter)
	"Interface\\Icons\\Ability_GolemStormBolt", 				-- Scatter Shot (Hunter)
	"Interface\\Icons\\Spell_Frost_ChainsOfIce", 				-- Freezing Trap (Hunter)
	"Interface\\Icons\\Spell_Frost_FreezingBreath", 			-- Frost Trap (Hunter)
	"Interface\\Icons\\Ability_Rogue_Trip", 					-- Wing Clip (Hunter)
	"Interface\\Icons\\INV_Spear_02", 							-- Wyvern Sting (Hunter)
	"Interface\\Icons\\Spell_Shadow_GrimWard", 					-- Curse of Exhaustion (Warlock)
	"Interface\\Icons\\Spell_Shadow_DeathCoil", 				-- Death Coil (Warlock)
	"Interface\\Icons\\Spell_Shadow_Possession",				-- Fear (Warlock)
	"Interface\\Icons\\Spell_Shadow_DeathScream", 				-- Howl of Terror (Warlock)
	"Interface\\Icons\\Spell_Shadow_Cripple", 					-- Banish (Warlock)
	"Interface\\Icons\\Spell_Fire_Fire", 						-- Aftermath (Warlock)
	"Interface\\Icons\\Spell_Shadow_MindRot", 					-- Spell Lock (Warlock)
	"Interface\\Icons\\Spell_Shadow_MindSteal", 				-- Seduction (Warlock)
	"Interface\\Icons\\Ability_Warrior_Charge", 				-- Charge (Warrior)
	"Interface\\Icons\\Ability_ShockWave", 						-- Hamstring (Warrior)
	"Interface\\Icons\\Ability_Rogue_Sprint", 					-- Intercept (Warrior)
	"Interface\\Icons\\Ability_GolemThunderClap", 				-- Intimidating Shout (Warrior)
	"Interface\\Icons\\Spell_Shadow_DeathScream", 				-- Piercing Howl (Warrior)
	"Interface\\Icons\\Ability_ThunderBolt", 					-- Concussion Blow (Warrior)
	"Interface\\Icons\\Ability_Warrior_Revenge", 				-- Revenge (Warrior)
	"Interface\\Icons\\Ability_Warrior_ShieldBash", 			-- Shield Bash (Warrior)
	"Interface\\Icons\\Spell_Holy_SealOfMight", 				-- Hammer of Justice (Paladin)
	"Interface\\Icons\\Spell_Frost_FrostShock", 				-- Frost Shock (Shaman)
	"Interface\\Icons\\Spell_Nature_StrengthOfEarthTotem02", 	-- Earthbind Totem (Shaman)
	"Interface\\Icons\\Ability_CheapShot", 						-- Cheap Shot (Rogue)
	"Interface\\Icons\\Ability_Rogue_KidneyShot", 				-- Kidney Shot (Rogue)
	"Interface\\Icons\\Ability_Gouge", 							-- Gouge (Rouge)
	"Interface\\Icons\\Spell_Shadow_MindSteal", 				-- Blind (Rogue)
	"Interface\\Icons\\Ability_Sap", 							-- Sap (Rogue)
	"Interface\\Icons\\Spell_Nature_AstralRecal",				-- Horned Viking Helmet/Goblin Rocket Helmet (Item)
	"Interface\\Icons\\Ability_Ensnare",						-- Gnomish Net-o-Matic Projector (Item)
	"Interface\\Icons\\Spell_Frost_SummonWaterElemental",		-- Tidal Charm (Item)
}

-- event: UNIT_PORTRAIT_UPDATE
-- found this: 16.11.2013; can probably be used

local partyFrames = {
	[1] = PartyMemberFrame1,
	[2] = PartyMemberFrame2,
	[3] = PartyMemberFrame3,
	[4] = PartyMemberFrame4,
}

local function longestBuffDebuff()

	local tempBuff = 0
	local tempBuffIcon = ""
	local tempDebuff = 0
	local tempDebuffIcon = ""
	local result
	local resultIcon
	
	for i = 0, 35 do
		
		for index, value in ipairs(ccBuffs) do
			if GetPlayerBuffTexture(GetPlayerBuff(i, "HELPFUL")) == value then
				if tempBuff == 0 then
					tempBuff = GetPlayerBuffTimeLeft(GetPlayerBuff(i, "HELPFUL"))
					tempBuffIcon = GetPlayerBuffTexture(GetPlayerBuff(i, "HELPFUL"))
				end
				if tempBuff < GetPlayerBuffTimeLeft(GetPlayerBuff(i+1, "HELPFUL")) then
					tempBuff = GetPlayerBuffTimeLeft(GetPlayerBuff(i+1, "HELPFUL"))
					tempBuffIcon = GetPlayerBuffTexture(GetPlayerBuff(i+1, "HELPFUL"))
				else
					tempBuff = tempBuff
					tempBuffIcon = tempBuffIcon
				end
			end
		end
		
	end

	for j = 0, 20 do
	
		for index, value in ipairs(ccDebuffs) do
		
			if GetPlayerBuffTexture(GetPlayerBuff(j, "HARMFUL")) == value then
				if tempDebuff == 0 then
					tempDebuff = GetPlayerBuffTimeLeft(GetPlayerBuff(j, "HARMFUL"))
					tempDebuffIcon = GetPlayerBuffTexture(GetPlayerBuff(j, "HARMFUL"))
				end
				if tempDebuff < GetPlayerBuffTimeLeft(GetPlayerBuff(j+1, "HARMFUL")) then
					tempDebuff = GetPlayerBuffTimeLeft(GetPlayerBuff(j+1, "HARMFUL"))
					tempDebuffIcon = GetPlayerBuffTexture(GetPlayerBuff(j+1, "HARMFUL"))
				else
					tempDebuff = tempDebuff
					tempDebuffIcon = tempDebuffIcon
				end
			end
		end
		
	end
	
	if tempBuff > tempDebuff then
		result = tempBuff
		resultIcon = tempBuffIcon
	else
		result = tempDebuff
		resultIcon = tempDebuffIcon
	end
	
	return result, resultIcon
	
end

CCPortraits:SetScript("OnUpdate",  function()
	
	if PlayerFrame.portrait~=nil then
		local _, class = UnitClass("player")
		local timeLeft, iconLeft = longestBuffDebuff()
		
		if iconLeft ~= "" then
			PlayerFrame.portrait:SetTexCoord(0,1,0,1)
			SetPortraitToTexture(PlayerFrame.portrait, iconLeft)
		else
			PlayerFrame.portrait:SetTexture(iconPath, true)
			PlayerFrame.portrait:SetTexCoord(unpack(CLASS_BUTTONS[class]))
		end
		if timeLeft > 0 then
			t:SetText(format("%d", timeLeft))
		else
			t:SetText(nil)
		end

	end
	
	for i=1, GetNumPartyMembers() do
		if partyFrames[i].portrait~=nil then
			local _, class = UnitClass("party"..i)
			if not CLASS_BUTTONS[class] then return end
			partyFrames[i].portrait:SetTexture(iconPath, true)
			partyFrames[i].portrait:SetTexCoord(unpack(CLASS_BUTTONS[class]))
		end
	end
	
	if(UnitName("target")~=nil and UnitIsPlayer("target") ~= nil and TargetFrame.portrait~=nil) then
		local _, class = UnitClass("target")
		
		local timeLeft, iconLeft = longestBuffDebuff()
		
		if iconLeft ~= "" then
			TargetFrame.portrait:SetTexCoord(0,1,0,1)
			SetPortraitToTexture(TargetFrame.portrait, iconLeft)
		else
			TargetFrame.portrait:SetTexture(iconPath, true)
			TargetFrame.portrait:SetTexCoord(unpack(CLASS_BUTTONS[class]))
		end
		if timeLeft > 0 then
			t:SetText(format("%d", timeLeft))
		else
			t:SetText(nil)
		end
	elseif(UnitName("target")~=nil) then
		TargetFrame.portrait:SetTexCoord(0,1,0,1)
	end
	
	if(UnitName("targettarget")~=nil and UnitIsPlayer("targettarget") ~= nil and TargetofTargetFrame.portrait~=nil) then
		local _, class = UnitClass("targettarget")
		TargetofTargetFrame.portrait:SetTexture(iconPath, true)
		TargetofTargetFrame.portrait:SetTexCoord(unpack(CLASS_BUTTONS[class]))
	elseif(UnitName("targettarget")~=nil) then
		TargetofTargetFrame.portrait:SetTexCoord(0,1,0,1)
	end

end
)

