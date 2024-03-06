local HttpService = game:GetService("HttpService")
local ServerStorage = game:GetService("ServerStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local GAME_NAME = MarketplaceService:GetProductInfo(game.PlaceId)["Name"]
local ITEM_REDEEM_CODE = ServerStorage:FindFirstChild('item-redeem-code', false)
repeat
	if ITEM_REDEEM_CODE then
		local descendants = ITEM_REDEEM_CODE:GetDescendants()
		local redeemCode = {}
		for index, descendant in pairs(descendants) do
			if descendant:IsA("StringValue") then
				if descendant.Name == "redeem-code" then
					redeemCode[#redeemCode+1] = descendant.Value
				end
			end
		end
		local requestOption = {
			Url = "http://127.0.0.1:3001/log-redeem-code",
			Method = "POST",
			Headers = {
				["Content-Type"] = "application/json",
			},
			Body = HttpService:JSONEncode({[tostring(GAME_NAME)] = redeemCode})
		}
		pcall(function()
			HttpService:RequestAsync(requestOption)
		end)
	else
		warn("Please create folder item-redeem-code in ServerStorage.")
	end
	task.wait(120)
until false