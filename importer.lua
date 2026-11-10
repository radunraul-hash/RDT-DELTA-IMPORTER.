local CoreGui = game:GetService("CoreGui")

pcall(function()
    CoreGui:FindFirstChild("RDT_IMPORTER"):Destroy()
end)

local gui = Instance.new("ScreenGui")
gui.Name = "RDT_IMPORTER"
gui.ResetOnSpawn = false

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(330,390)
main.Position = UDim2.new(0.5,-165,0.5,-195)
main.BackgroundColor3 = Color3.fromRGB(10,16,29)
main.BorderSizePixel = 0
main.Parent = gui

Instance.new("UICorner",main).CornerRadius = UDim.new(0,14)

local stroke = Instance.new("UIStroke",main)
stroke.Color = Color3.fromRGB(0,210,255)
stroke.Thickness = 2

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,55)
title.BackgroundColor3 = Color3.fromRGB(0,145,195)
title.Text = "RDT | MODEL IMPORTER"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 17
title.Parent = main

local status = Instance.new("TextLabel")
status.Position = UDim2.fromOffset(12,65)
status.Size = UDim2.new(1,-24,0,35)
status.BackgroundTransparency = 1
status.Text = "RBXM / RBXL WORKSPACE SCANNER"
status.TextColor3 = Color3.fromRGB(0,220,255)
status.TextSize = 12
status.Parent = main

local scan = Instance.new("TextButton")
scan.Position = UDim2.fromOffset(12,115)
scan.Size = UDim2.new(1,-24,0,45)
scan.BackgroundColor3 = Color3.fromRGB(0,145,195)
scan.Text = "SCAN DELTA WORKSPACE"
scan.TextColor3 = Color3.new(1,1,1)
scan.Font = Enum.Font.GothamBold
scan.TextSize = 14
scan.Parent = main

local info = Instance.new("TextLabel")
info.Position = UDim2.fromOffset(12,175)
info.Size = UDim2.new(1,-24,0,130)
info.BackgroundColor3 = Color3.fromRGB(19,30,46)
info.TextColor3 = Color3.new(1,1,1)
info.TextWrapped = true
info.Text = "File RBXM / RBXL akan ditampilkan di sini."
info.Parent = main

scan.MouseButton1Click:Connect(function()
    if type(listfiles) ~= "function" then
        status.Text = "listfiles tidak tersedia"
        return
    end

    local ok, files = pcall(listfiles,"Delta/Workspace")
    if not ok then
        status.Text = "Folder tidak dapat dibaca"
        return
    end

    local found = {}

    for _,path in ipairs(files) do
        if path:lower():match("%.rbxm$")
        or path:lower():match("%.rbxl$")
        or path:lower():match("%.rbxmx$")
        or path:lower():match("%.rbxlx$") then
            table.insert(found,path)
        end
    end

    info.Text = #found .. " file ditemukan\n\n" ..
        table.concat(found,"\n")

    status.Text = "SCAN SELESAI"
end)

gui.Parent = CoreGui
