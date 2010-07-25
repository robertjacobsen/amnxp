function getXP()
	return string.format("XP: %s / %s (%.2f%%) to level %d [%d remaining] [%d rested]", UnitXP"player", UnitXPMax"player", (UnitXP"player" / UnitXPMax"player") * 100, UnitLevel"player" + 1, UnitXPMax"player" - UnitXP"player", GetXPExhaustion() or 0)
end

local function Print(green, text)
	ChatFrame1:AddMessage(string.format("|cff33ff99%s|r: %s", green, text))
end

local xp = CreateFrame"Frame"
xp:RegisterEvent"CHAT_MSG_WHISPER"
xp:RegisterEvent"CHAT_MSG_BN_WHISPER"
xp:SetScript("OnEvent", function(self, event, ...)
	if arg1 == "xp" then
		if event == "CHAT_MSG_WHISPER" then 
			SendChatMessage(getXP(), whisper, this.lang, arg2)
		else
			local presenceID = BNet_GetPresenceID(arg2)
			ChatEdit_SetLastTellTarget(arg2)
			BNSendWhisper(presenceID, getXP())
		end
	end
end)

SlashCmdList['EXP'] = function(arg1)
	if(arg1 == "party") then
		SendChatMessage(getXP(), "PARTY", this.lang)
	elseif(arg1 == "guild") then 
		SendChatMessage(getXP(), "GUILD", this.lang)
	elseif(string.sub(arg1, 0, 7) == "whisper") then
		SendChatMessage(getXP(), "WHISPER", this.lang, string.sub(arg1, 9))
	elseif(string.sub(arg1, 0, 7) == "channel") then 
		SendChatMessage(getXP(), "CHANNEL", this.lang, string.sub(arg1, 9))
	elseif(arg1 == "help") then
		Print("<nothing>", "Prints your current XP to ChatFrame1.")
		Print("party", "Broadcasts your XP to the party")
		Print("guild", "Broadcasts your XP to your guild")
		Print("whisper <name>", "Whispers your XP to the the given person")
		Print("channel <number>", "Broadcasts your XP to the given channel")
		Print("help", "Shows this help menu")
	else
		ChatFrame1:AddMessage(getXP())
	end

end
SLASH_EXP1 = '/exp'
SLASH_EXP2 = '/xp'
