_G.ChestFarm = true
_G.__FarmRunning = false
_G.TrackScan = false
_G.__ScanRunning = false
_G.SafeMode = false

local Players = game:GetService("Players")
local t1 = {
	value1 = game:GetService("RunService"),
	value2 = Players.LocalPlayer
}
local PlayerGui = t1.value2:WaitForChild("PlayerGui")
local ChestFarmMenu = PlayerGui:FindFirstChild("ChestFarmMenu")

if ChestFarmMenu then
	ChestFarmMenu:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")

ScreenGui.Name = "ChestFarmMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = PlayerGui

local Frame = Instance.new("Frame")

Frame.Name = "Main"
Frame.Size = UDim2.new(0, 220, 0, 200)
Frame.Position = UDim2.new(0, 20, 0, 120)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)

local TextLabel = Instance.new("TextLabel")

TextLabel.Size = UDim2.new(1, 0, 0, 28)
TextLabel.BackgroundTransparency = 1
TextLabel.Text = "🟣 Chest Farm"
TextLabel.Font = Enum.Font.GothamBold
TextLabel.TextSize = 15
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.Parent = Frame
t1.value3 = Instance.new("TextButton")
t1.value3.Name = "Scan"
t1.value3.Size = UDim2.new(1, -20, 0, 36)
t1.value3.Position = UDim2.new(0, 10, 0, 36)
t1.value3.BackgroundColor3 = Color3.fromRGB(60, 90, 180)
t1.value3.Text = "SCAN: OFF"
t1.value3.Font = Enum.Font.GothamBold
t1.value3.TextSize = 15
t1.value3.TextColor3 = Color3.fromRGB(255, 255, 255)
t1.value3.Parent = Frame
Instance.new("UICorner", t1.value3).CornerRadius = UDim.new(0, 8)
t1.value4 = Instance.new("TextLabel")
t1.value4.Name = "Status"
t1.value4.Size = UDim2.new(1, -20, 0, 118)
t1.value4.Position = UDim2.new(0, 10, 0, 80)
t1.value4.BackgroundTransparency = 1
t1.value4.Text = "Status: FARM 🟢\nLoot: 0 | Skip: 0\nLocked: 0\nScan: -"
t1.value4.Font = Enum.Font.Gotham
t1.value4.TextSize = 13
t1.value4.TextColor3 = Color3.fromRGB(200, 200, 200)
t1.value4.TextWrapped = true
t1.value4.Parent = Frame
t1.value5 = 80
t1.value6 = 0
t1.value7 = 3
t1.value8 = 0.02
t1.value9 = 0.05
t1.value10 = 3
t1.value11 = 0.1
t1.value12 = 0.3
t1.value13 = 0.6
t1.value14 = 100
t1.value15 = 0.4
t1.value16 = 150
t1.value17 = 36000
t1.value18 = 1200
t1.value19 = 0.6
t1.value20 = 0
t1.value21 = 0
t1.value22 = 0
_G.ScanInfo = "-"

function t1.value23(p1)
	local LockGui = p1:FindFirstChild("LockGui", true)

	if not LockGui then
		return false
	end

	local ok, result = pcall(function()
		return LockGui.Enabled
	end)
	local v11

	if ok then
		v11 = result == false
	else
		v11 = ok
	end

	if v11 then
		return false
	end

	for _, descendant in ipairs(LockGui:GetDescendants()) do
		if descendant:IsA("ImageLabel") then
			local ok2 = pcall(function()
				return descendant.Visible
			end)
			local ImageTransparency = nil

			local function v16()
				ImageTransparency = descendant.ImageTransparency
			end

			ImageTransparency = 0
			pcall(v16)

			if ok2 then
				ok2 = descendant.Visible

				if ok2 then
					local v17 = ImageTransparency

					ok2 = (tonumber(v17) or 0) < 0.5
				end
			end

			if ok2 then
				return true
			end
		end
	end

	if not ok then
		return ok and true or false
	end

	ok = result == true

	return ok and true or false
end
function t1.value24(p2)
	print("[ChestFarm] " .. tostring(p2))
end
function t1.value25()
	local Character = t1.value2.Character

	if not Character then
		return Character
	end

	Character = Character:FindFirstChild("HumanoidRootPart")

	return Character
end
function t1.value26()
	local Character = t1.value2.Character

	if not Character then
		return Character
	end

	Character = Character:FindFirstChildOfClass("Humanoid")

	return Character
end

t1.value27 = nil

function t1.value28()
	local v20 = t1.value26()

	return (not v20 or v20.MaxHealth <= 0) and 0 or v20.Health / v20.MaxHealth
end

t1.value27 = {}
t1.value29 = nil

function t1.value30()
	local Character = t1.value2.Character

	if Character then
		for _, descendant in ipairs(Character:GetDescendants()) do
			if descendant:IsA("BasePart") then
				if t1.value27[descendant] == nil then
					t1.value27[descendant] = descendant.CanCollide
				end

				if descendant.CanCollide then
					descendant.CanCollide = false
				end
			end
		end
	end
end
function t1.value31()
	for k, v in pairs(t1.value27) do
		local Parent

		if k then
			Parent = k.Parent
		else
			Parent = k
		end

		if Parent then
			pcall(function()
				k.CanCollide = v
			end)
		end
	end

	table.clear(t1.value27)
end

local function v27()
	if t1.value29 then
		return
	end

	t1.value27 = {}
	t1.value29 = t1.value1.Stepped:Connect(function()
		if _G.SafeMode then
			t1.value30()

			return
		end

		t1.value31()

		if not t1.value29 then
			t1.value24("NOCLIP OFF.")

			return
		end

		t1.value29:Disconnect()
		t1.value29 = nil
		t1.value24("NOCLIP OFF.")
	end)
	t1.value24("NOCLIP ON (safe mode).")
end

t1.value2.CharacterAdded:Connect(function(_)
	task.wait(0.3)

	local _ = _G.SafeMode
end)

function t1.value32()
	local v29 = t1.value26()
	local Sit

	if v29 then
		Sit = v29.Sit
	else
		Sit = v29
	end

	if not Sit then
		return false
	end

	pcall(function()
		v29.Sit = false
		v29.Jump = true
	end)
	task.wait(0.4)

	local v31 = t1.value26()
	local Sit2

	if v31 then
		Sit2 = v31.Sit
	else
		Sit2 = v31
	end

	if not Sit2 then
		t1.value24("Dismounted from train seat.")

		return true
	end

	pcall(function()
		v31.Sit = false
	end)
	task.wait(0.3)
	t1.value24("Dismounted from train seat.")

	return true
end

t1.value33 = nil

function t1.value34(p3)
	local Character = p3 or t1.value2.Character

	if not Character then
		return
	end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid") or Character:WaitForChild("Humanoid", 5)

	if not Humanoid then
		return
	end

	if t1.value33 then
		t1.value33:Disconnect()
	end

	Humanoid.Seated:Connect(function(p4)
		if not p4 then
			return
		end

		task.wait(0.1)

		local Sit = Humanoid.Sit

		if Sit then
			Sit = not _G.SafeMode
		end

		if not Sit then
			return
		end

		pcall(function()
			Humanoid.Sit = false
			Humanoid.Jump = true
		end)
		t1.value24("Auto-dismounted from seat.")
	end)
end

t1.value34(t1.value2.Character)
t1.value2.CharacterAdded:Connect(function(character)
	task.wait(0.3)
	t1.value34(character)
	_G.SafeMode = false
end)

function t1.value35()
	local function v36()
		local v37 = _G.SafeMode and "SAFE ⛑️ REGEN" or (_G.ChestFarm and "FARM 🟢" or (_G.TrackScan and "SCAN 🟢" or "IDLE"))

		t1.value4.Text = "Status: " .. v37 .. "\nLoot: " .. t1.value20 .. " | Skip: " .. t1.value21 .. "\nLocked (needs boss): " .. t1.value22 .. "\nScan: " .. tostring(_G.ScanInfo or "-")
	end

	pcall(v36)
end
function t1.value36(p5)
	local v38 = p5.FindFirstChild(p5, "Chest", true)
	local ProximityPrompt = v38 and v38:FindFirstChildOfClass("ProximityPrompt")

	if ProximityPrompt then
		return ProximityPrompt
	else
		for _, descendant in ipairs(p5:GetDescendants()) do
			if descendant:IsA("ProximityPrompt") then
				return descendant
			end
		end

		return nil
	end
end

t1.value37 = nil

function t1.value38(p6, p7)
	local ipairs_ = ipairs
	local workspace_ = workspace
	local t2 = {}

	for _, descendant in ipairs_(workspace_.GetDescendants(workspace_)) do
		local isModel = descendant:IsA("Model")

		if isModel then
			isModel = descendant ~= t1.value2.Character
		end

		if isModel then
			local Humanoid = descendant:FindFirstChildOfClass("Humanoid")

			if Humanoid then
				Humanoid = Humanoid.Health > 0
			end

			if Humanoid then
				local ok, result = pcall(function()
					return descendant:GetPivot()
				end)

				if ok then
					ok = (result.Position - p6).Magnitude <= p7
				end

				if ok then
					table.insert(t2, {
						Model = descendant,
						Name = descendant.Name
					})
				end
			end
		end
	end

	return t2
end
function t1.value39(p8)
	local Position = t1.value25()

	if Position then
		Position = Position.Position
	end

	local ipairs_ = ipairs
	local workspace_ = workspace
	local v54 = Position or nil
	local v55 = p8 or 1000000000
	local v56 = nil

	for _, descendant in ipairs_(workspace_.GetDescendants(workspace_)) do
		local v59

		if descendant:IsA("Model") then
			local ok, result = pcall(function()
				return descendant:GetAttribute("RuntimeChestModel")
			end)

			if ok then
				if result then
					result = not t1.value23(descendant)
				end
			else
				result = ok
			end

			if result then
				local ok2, result2 = pcall(function()
					return descendant:GetPivot()
				end)

				if ok2 and result2 then
					local Magnitude

					if v54 then
						Magnitude = (result2.Position - v54).Magnitude
					else
						Magnitude = v54
					end

					v59 = Magnitude or 0

					if v59 < v55 then
						v56 = {
							Model = descendant,
							Pos = result2.Position,
							Dist = v59
						}
					else
						v59 = v55
					end
				else
					v59 = v55
				end
			else
				v59 = v55
			end
		else
			v59 = v55
		end

		v55 = v59
	end

	return v56
end
function t1.value40()
	local Position = t1.value25()

	if Position then
		Position = Position.Position
	end

	t1.value22 = 0

	local v66 = Position or nil
	local t3 = {}

	for _, descendant in ipairs(workspace:GetDescendants()) do
		if descendant:IsA("Model") then
			local ok, result = pcall(function()
				return descendant:GetAttribute("RuntimeChestModel")
			end)

			if ok and result then
				if t1.value23(descendant) then
					local v72 = t1

					v72.value22 = v72.value22 + 1
				else
					local ok2, result2 = pcall(function()
						return descendant:GetPivot()
					end)

					if ok2 and result2 then
						local insert = table.insert
						local s1 = "Model"
						local s2 = "Pos"
						local Position2 = result2.Position
						local s3 = "Dist"
						local Magnitude

						if v66 then
							Magnitude = (result2.Position - v66).Magnitude
						else
							Magnitude = v66
						end

						insert(t3, {
							[s1] = descendant,
							[s2] = Position2,
							[s3] = Magnitude or 0
						})

						if #t3 >= 60 then
							break
						end
					end
				end
			end
		end
	end

	table.sort(t3, function(p9, p10)
		return p9.Dist < p10.Dist
	end)
	t1.value35()

	return t3
end

t1.value37 = nil

function t1.value41()
	if _G.SafeMode then
		return
	end

	_G.SafeMode = true

	local v81 = t1.value25()

	if not v81 then
		v27()
		t1.value24(string.format("HP %.0f%% - SAFE MODE, floated %d studs up + regen.", t1.value28() * 100, t1.value14))
		t1.value35()

		return
	end

	t1.value37 = v81.Position + Vector3.new(0, t1.value14, 0)

	local function v82()
		v81.AssemblyLinearVelocity = Vector3.zero
		v81.CFrame = CFrame.new(t1.value37)
		v81.Anchored = true
	end

	pcall(v82)
	v27()
	t1.value24(string.format("HP %.0f%% - SAFE MODE, floated %d studs up + regen.", t1.value28() * 100, t1.value14))
	t1.value35()
end
function t1.value42()
	if not _G.SafeMode then
		return
	end

	_G.SafeMode = false

	local v83 = t1.value25()

	if not v83 then
		t1.value24(string.format("HP recovered (%.0f%%) - resuming.", t1.value28() * 100))
		t1.value35()

		return
	end

	pcall(function()
		v83.Anchored = false
	end)
	t1.value24(string.format("HP recovered (%.0f%%) - resuming.", t1.value28() * 100))
	t1.value35()
end
function t1.value43()
	t1.value41()

	while _G.SafeMode do
		if not (_G.ChestFarm or _G.TrackScan) then
			t1.value42()

			return false
		end

		if t1.value28() >= t1.value13 then
			t1.value42()

			return true
		end

		local v84 = t1.value25()
		local v85

		if v84 then
			v85 = not v84.Anchored
		else
			v85 = v84
		end

		if v85 then
			local function v86()
				if not t1.value37 then
					v84.Anchored = true

					return
				end

				v84.CFrame = CFrame.new(t1.value37)
				v84.Anchored = true
			end

			pcall(v86)
		end

		task.wait(t1.value15)
	end

	return false
end

t1.value44 = nil

function t1.value44(p11)
	if not p11 then
		return
	end

	for i = 1, t1.value7 do
		local function v88()
			if t1.value6 > 0 then
				fireproximityprompt(p11, t1.value6)
			else
				fireproximityprompt(p11)
			end
		end

		pcall(v88)

		if i < t1.value7 then
			task.wait(t1.value8)
		end
	end
end
function t1.value45(p12)
	if _G.SafeMode then
		return "safe-mode"
	end

	local v89 = t1.value25()

	if not v89 then
		return "no-hrp"
	end

	t1.value32()
	pcall(function()
		v89.AssemblyLinearVelocity = Vector3.zero
		v89.CFrame = CFrame.new(p12.Pos + Vector3.new(0, 3, 2), p12.Pos)
	end)
	task.wait(0.2)

	local Model = t1.value39(20)
	local Parent, v92, Name, v94, v95

	if not Model then
		v102 = Model or p12.Model

		if v102 then
			Parent = v102.Parent
		else
			Parent = v102
		end

		if Parent then
			if t1.value23(v102) then
				return "locked"
			else
				v92 = t1.value36(v102)

				if v92 and v92.Enabled then
					Name = v102.Name
					t1.value44(v92)
					task.wait(t1.value9)

					if v102.Parent then
						v94 = t1
						v94.value20 = v94.value20 + 1
						t1.value24("Fired " .. Name .. " - moving to next.")
					else
						v95 = t1
						v95.value20 = v95.value20 + 1
						t1.value24("Looted: " .. Name)
					end

					t1.value35()

					return "ok"
				else
					return "no-prompt"
				end
			end
		else
			return "gone"
		end
	end

	Model = Model.Model

	local Model2 = Model or p12.Model

	if Model2 then
		Parent = Model2.Parent
	else
		Parent = Model2
	end

	if Parent then
		if t1.value23(Model2) then
			return "locked"
		else
			v92 = t1.value36(Model2)

			if v92 and v92.Enabled then
				Name = Model2.Name
				t1.value44(v92)
				task.wait(t1.value9)

				if Model2.Parent then
					v94 = t1
					v94.value20 = v94.value20 + 1
					t1.value24("Fired " .. Name .. " - moving to next.")
				else
					v95 = t1
					v95.value20 = v95.value20 + 1
					t1.value24("Looted: " .. Name)
				end

				t1.value35()

				return "ok"
			else
				return "no-prompt"
			end
		end
	else
		return "gone"
	end
end
function t1.value46()
	local function v97()
		if _G.TrackScan then
			t1.value3.Text = "SCAN: ON"
			t1.value3.BackgroundColor3 = Color3.fromRGB(50, 170, 80)
		else
			t1.value3.Text = "SCAN: OFF"
			t1.value3.BackgroundColor3 = Color3.fromRGB(60, 90, 180)
		end
	end

	pcall(v97)
	t1.value35()
end
function t1.value47()
	local Drill = workspace:FindFirstChild("Drill")

	if Drill then
		local ok, result = pcall(function()
			return Drill:GetPivot()
		end)

		if ok and result then
			return result.Position
		end
	end

	local Position = t1.value25()

	if not Position then
		return Position or Vector3.new(-740, 20, -771.5)
	end

	Position = Position.Position

	return Position or Vector3.new(-740, 20, -771.5)
end
function t1.value48()
	if _G.__ScanRunning then
		return
	end

	_G.__ScanRunning = true

	local v103 = t1.value47()
	local X = v103.X
	local Z = v103.Z
	local ScanX = _G.ScanX
	local v106 = type(ScanX) == "number"

	if v106 then
		v106 = X <= _G.ScanX

		if v106 then
			v106 = _G.ScanX <= t1.value17
		end
	end

	local scanX

	if v106 then
		X = _G.ScanX
		t1.value24("Resuming scan from x=" .. math.floor(X) .. ".")
		scanX = X
	else
		_G.ScanX = X
		scanX = X
	end

	local Y = t1.value25()

	if Y then
		Y = Y.Position.Y
	end

	t1.value24(string.format("START scan x=%.0f -> %.0f, step %d", scanX, t1.value17, t1.value16))

	local v109 = Y or 20

	while _G.TrackScan and (t1.value28() >= t1.value12 or t1.value43()) do
		if t1.value28() < t1.value11 then
			t1.value24("HP critically low - STOP scan.")
			_G.TrackScan = false

			break
		end

		if t1.value17 < scanX then
			t1.value24("Scan COMPLETE (end of track).")
			_G.ScanX = nil
			_G.TrackScan = false

			break
		end

		local v110 = t1.value25()

		if v110 then
			t1.value32()

			local vector3New = Vector3.new
			local vector3 = nil

			local function v113()
				v110.AssemblyLinearVelocity = Vector3.zero
				v110.CFrame = CFrame.new(vector3)
			end

			vector3 = vector3New(scanX, v109, Z)
			pcall(v113)
			_G.ScanInfo = "x=" .. math.floor(scanX) .. "/" .. t1.value17
			t1.value35()
			task.wait(t1.value19)

			local v114, v115, v116 = ipairs(t1.value40())
			local v117 = vector3
			local t4 = {}

			while true do
				local v119

				v116, v119 = v114(v115, v116)

				if not v116 then
					break
				end

				if (v119.Pos - v117).Magnitude <= t1.value18 then
					table.insert(t4, v119)
				end
			end

			if #t4 > 0 then
				t1.value24("x=" .. math.floor(scanX) .. ": " .. #t4 .. " chests matched -> teleporting to loot...")

				local v120, v121, v122 = ipairs(t4)

				while true do
					local v123

					v122, v123 = v120(v121, v122)

					if not v122 or (not _G.TrackScan or t1.value28() < t1.value12 and not t1.value43()) then
						break
					end

					local Parent = v123.Model.Parent

					if Parent then
						Parent = not t1.value23(v123.Model)
					end

					if Parent then
						local v125 = t1.value38(v123.Pos, t1.value5)

						if #v125 > 0 then
							local v126 = t1

							v126.value21 = v126.value21 + 1
							t1.value24("SKIP " .. v123.Model.Name .. ": " .. #v125 .. " enemies nearby.")
							t1.value35()
						else
							local t5 = { pcall(t1.value45, v123) }
							local v128 = t5[2]

							if not t5[1] then
								t1.value24("Error: " .. tostring(v128))
							end
						end
					end

					task.wait(0.15)
				end

				local v129 = t1.value25()

				if v129 then
					pcall(function()
						v129.AssemblyLinearVelocity = Vector3.zero
						v129.CFrame = CFrame.new(v117)
					end)
				end

				task.wait(0.2)
			end

			scanX = scanX + t1.value16
			_G.ScanX = scanX
		else
			task.wait(1)
		end

		task.wait(0.1)
	end

	_G.__ScanRunning = false
	_G.ScanInfo = "-"

	if not _G.SafeMode then
		t1.value46()
		t1.value24("STOP scan.")

		return
	end

	t1.value42()
	t1.value46()
	t1.value24("STOP scan.")
end

t1.value3.MouseButton1Click:Connect(function()
	_G.TrackScan = not _G.TrackScan

	if _G.TrackScan then
		_G.ChestFarm = false
	else
		t1.value42()
	end

	t1.value46()
	t1.value35()

	if _G.TrackScan then
		task.spawn(t1.value48)
	else
		t1.value24("Scan OFF.")
	end
end)
t1.value46()
task.spawn(function()
	local v130 = nil

	if _G.__FarmRunning then
		return
	end

	_G.__FarmRunning = true
	t1.value24("START farm (auto). 0 boss attacks.")

	local v131 = t1.value25()
	local CFrame_ = v131 and v131.CFrame or nil

	while _G.ChestFarm and (t1.value28() >= t1.value12 or t1.value43()) do
		if t1.value28() < t1.value11 then
			t1.value24("HP critically low - STOP.")

			local v133 = t1.value25()

			if v133 and CFrame_ then
				pcall(function()
					v133.CFrame = CFrame_ + Vector3.new(0, 5, 0)
				end)
			end

			_G.ChestFarm = false

			break
		end

		local v134 = t1.value40()

		if #v134 == 0 then
			local value22 = t1.value22

			v130 = v130 + 1

			if value22 > 0 then
				t1.value24("Scan " .. v130 .. ": 0 unlocked, " .. t1.value22 .. " LOCKED.")
			else
				t1.value24("Scan " .. v130 .. ": no chest.")
			end

			if v130 >= 40 then
				t1.value24("STOP after 40 empty scans.")
				_G.ChestFarm = false

				break
			end

			task.wait(t1.value10)
		else
			v130 = 0

			for _, v in ipairs(v134) do
				if not _G.ChestFarm or t1.value28() < t1.value12 and not t1.value43() then
					break
				end

				local v138 = t1.value38(v.Pos, t1.value5)

				if #v138 > 0 then
					local v139 = t1

					v139.value21 = v139.value21 + 1
					t1.value24("SKIP " .. v.Model.Name .. ": " .. #v138 .. " enemies nearby.")
					t1.value35()
				else
					local ok, result = pcall(t1.value45, v)

					if not ok then
						t1.value24("Error: " .. tostring(result))
					end
				end

				task.wait(0.15)
			end

			task.wait(0.3)
		end
	end

	_G.__FarmRunning = false

	if not _G.SafeMode then
		t1.value35()
		t1.value24("STOP farm.")

		return
	end

	t1.value42()
	t1.value35()
	t1.value24("STOP farm.")
end)
t1.value24("Menu OK. Farm auto-ON. Click SCAN for track sweep. Auto-dismount + Safe Mode + NoClip + Leave-on-loot.")
