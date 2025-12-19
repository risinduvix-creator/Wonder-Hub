print([[     
-----------------------------------------------------------------------------------

   ██   ██  █████  ██   ██ █████  ██████ ██████          ██  ██ ██   ██ ██████ 
   ██   ██ ██   ██ ███  ██ ██  ██ ██      ██   ██        ██  ██ ██   ██ ██  ██ 
   ██   ██ ██   ██ ████ ██ ██   ██ █████  ██████         ██████ ██   ██ █████ 
   ██ █ ██ ██   ██ ██ ████ ██   ██ ██     ██ ██   ███    ██  ██ ██   ██ ██  ██ 
   ███████ ██   ██ ██  ███ ██  ██  ██     ██  ██         ██  ██ ██   ██ ██  ██ 
   ██   ██  █████  ██   ██ █████   ██████ ██   ██        ██  ██  █████  ██████ 

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

-- Safely fetch and run remote loader code with multiple request fallbacks
local function safeLoad(url)
	if not url or url == "" then
		notify("WonderHub", "No Sorry man...error on our side", 6)
		return
	end

	local body
	local ok, err = pcall(function()
		if type(fetch) == "function" then
			local res = fetch(url)
			body = res.Body or res.body
		elseif syn and syn.request then
			local r = syn.request({Url = url, Method = "GET"})
			body = r.Body or r.body
		elseif http and http.request then
			local r = http.request({Url = url, Method = "GET"})
			body = r.Body or r.body
		elseif tostring(game):match("Instance") and game.HttpGet then
			body = game:HttpGet(url)
		else
			local hs = game:GetService("HttpService")
			body = hs:GetAsync(url)
		end
	end)

	if not ok or not body then
		notify("WonderHub", "Failed to fetch loader: " .. tostring(err or "unknown"), 8)
		return
	end

	local run_ok, run_err = pcall(function()
		local fn = loadstring and loadstring(body) or load(body)
		if not fn then error("load failed") end
		fn()
	end)

	if run_ok then
		notify("WonderHub", "WonderHub loaded successfully", 6)
	else
		notify("WonderHub", "Error running loader: " .. tostring(run_err), 8)
	end
end

-- Attempt to load the remote loader (URL kept as originally provided)
safeLoad("https://raw.githubusercontent.com/risinduvix-creator/Wonder-Hub/refs/heads/main/Wonder-99nights.luas")
