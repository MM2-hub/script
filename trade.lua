-- LocalScript in StarterPlayerScripts

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- GUI container
local gui = Instance.new("ScreenGui")
gui.Name = "FakeTradeUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = math.huge
gui.Parent = playerGui

-- Trade Frame (Draggable)
local tradeFrame = Instance.new("Frame")
tradeFrame.Size = UDim2.new(0.4, 0, 0.3, 0)
tradeFrame.Position = UDim2.new(0.3, 0, 0.35, 0)
tradeFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
tradeFrame.ZIndex = 10
tradeFrame.Active = true            -- Required for dragging
tradeFrame.Draggable = true         -- Makes it movable
tradeFrame.Parent = gui

Instance.new("UICorner", tradeFrame).CornerRadius = UDim.new(0.05, 0)
Instance.new("UIStroke", tradeFrame).Thickness = 2

-- Function to create a toggle-style button
local function createToggleButton(parent, position, colorOn, colorOff, textOn, textOff)
	local toggleFrame = Instance.new("Frame")
	toggleFrame.Size = UDim2.new(0.4, 0, 0.2, 0)
	toggleFrame.Position = position
	toggleFrame.BackgroundColor3 = colorOff
	toggleFrame.ZIndex = 11
	toggleFrame.Parent = parent
	toggleFrame.ClipsDescendants = true
	Instance.new("UICorner", toggleFrame).CornerRadius = UDim.new(1, 0)

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = textOff
	label.Font = Enum.Font.GothamBold
	label.TextScaled = true
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.ZIndex = 12
	label.Parent = toggleFrame

	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 2
	stroke.Color = Color3.fromRGB(0, 0, 0)
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
	stroke.Parent = label

	local circle = Instance.new("TextButton")
	circle.Size = UDim2.new(0.5, 0, 1, 0)
	circle.Position = UDim2.new(0, 0, 0, 0)
	circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	circle.BackgroundTransparency = 0.3
	circle.Text = ""
	circle.ZIndex = 13
	circle.AutoButtonColor = false
	circle.Parent = toggleFrame
	Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)

	local toggled = false
	circle.MouseButton1Click:Connect(function()
		toggled = not toggled
		if toggled then
			circle:TweenPosition(UDim2.new(0.5, 0, 0, 0), "Out", "Sine", 0.2)
			toggleFrame.BackgroundColor3 = colorOn
			label.Text = textOn
		else
			circle:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Sine", 0.2)
			toggleFrame.BackgroundColor3 = colorOff
			label.Text = textOff
		end
	end)
end

-- Add Accept and Freeze buttons
createToggleButton(tradeFrame, UDim2.new(0.05, 0, 0.7, 0), Color3.fromRGB(0, 200, 0), Color3.fromRGB(180, 180, 180), "ACCEPT", "ACCEPT")
createToggleButton(tradeFrame, UDim2.new(0.55, 0, 0.7, 0), Color3.fromRGB(255, 0, 0), Color3.fromRGB(180, 180, 180), "FREEZE", "FREEZE")
