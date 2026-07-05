local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- 1. TẠO TÂM NGẮM TRÒN GIỮA MÀN HÌNH (Giống trong ảnh 1000042533.jpg)
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "CustomCrosshair"

local Crosshair = Instance.new("Frame", ScreenGui)
Crosshair.Size = UDim2.new(0, 10, 0, 10) -- Kích thước tâm
Crosshair.Position = UDim2.new(0.5, -5, 0.5, -5) -- Căn chính giữa màn hình
Crosshair.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- Màu trắng
Crosshair.BackgroundTransparency = 0.3

local Corner = Instance.new("UICorner", Crosshair)
Corner.CornerRadius = UDim.new(1, 0) -- Bo tròn thành hình vòng tròn

-- Nút bấm để Bật/Tắt chế độ khóa góc nhìn
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 120, 0, 40)
ToggleButton.Position = UDim2.new(0.1, 0, 0.1, 0) -- Góc trên bên trái
ToggleButton.Text = "LOCK CAM: OFF"
ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.Draggable = true

local isLocked = false

-- 2. LOGIC KHÓA CAMERA XOAY THEO HƯỚNG NHÂN VẬT
ToggleButton.MouseButton1Click:Connect(function()
    isLocked = not isLocked
    if isLocked then
        ToggleButton.Text = "LOCK CAM: ON"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter -- Khóa chuột/tâm vào giữa
    else
        ToggleButton.Text = "LOCK CAM: OFF"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    end
end)

RunService.RenderStepped:Connect(function()
    if isLocked and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = localPlayer.Character.HumanoidRootPart
        -- Ép nhân vật quay mặt theo hướng xoay camera của bạn trên điện thoại
        local lookVector = camera.CFrame.LookVector
        hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + Vector3.new(lookVector.X, 0, lookVector.Z))
    end
end)
