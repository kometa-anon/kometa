--[[
    Luau Extended. A library that extends the default Luau functions.
    Made by: notweuz
    Probably will be used only by kometa.
    If you want to use it, go ahead.
]]

-- Making all needed tables writable. Screw you, default Luau.
setreadonly(table, false)
setreadonly(Instance, false)
setreadonly(math, false)

-- Old Functions
oldTableSort = table.sort
oldTableRemove = table.remove
oldTableInsert = table.insert

-- Table filter function
table.filter = function(originalTable, filterFunction, saveKeys)
    local newTable = {}
    for key, value in next, originalTable do
        if filterFunction(value, key, originalTable) then
            if saveKeys then
                newTable[key] = value
            else
                table.insert(newTable, value)
            end
        end
    end

    return newTable
end

-- Table Sort
table.sort = function(originalTable, sortFunction, ...)
    oldTableSort(originalTable, sortFunction, ...)
    return originalTable or nil
end

-- Table Insert
table.insert = function(originalTable, value, valuePosition)
    oldTableInsert(originalTable, valuePosition or #originalTable+1, value)
    return originalTable or nil
end

-- Table Remove
table.remove = function(originalTable, valuePosition)
    oldTableRemove(originalTable, valuePosition or #originalTable)
    return originalTable or nil
end

-- Table Shuffle
table.shuffle = function(originalTable)
    local newTable = {}
    for _ = 1, #originalTable do
        local randomIndex = math.random(1, #originalTable)
        table.insert(newTable, originalTable[randomIndex])
        table.remove(originalTable, randomIndex)
    end
    return newTable or nil
end

-- Table To JSON
table.toJSON = function(originalTable)
    return game:GetService("HttpService"):JSONEncode(originalTable)
end

-- Table From JSON
table.fromJSON = function(originalTable)
    return game:GetService("HttpService"):JSONDecode(originalTable)
end

-- Table To Vector3
table.toVector3 = function(originalTable)
    return Vector3.new(originalTable[1], originalTable[2], originalTable[3])
end

-- Table To Color3
table.toColor3 = function(originalTable)
    return Color3.fromRGB(originalTable[1], originalTable[2], originalTable[3])
end

-- Table Map
table.map = function(originalTable, mapFunction)
    local newTable = {}
    for key, value in next, originalTable do
        newTable[key] = mapFunction(value, key, originalTable)
    end
    return newTable or nil
end

-- Table For Each
table.forEach = function(originalTable, forEachFunction)
    for key, value in next, originalTable do
        forEachFunction(value, key, originalTable)
    end
    return originalTable or nil
end

-- Set Table's JSON to Clipboard
table.setJSONToClipboard = function(originalTable)
    setclipboard(tostring(table.toJSON(originalTable)))
end

-- Instance Create
Instance.create = function(instanceType, properties)
    local newInstance = Instance.new(instanceType)
    for property, value in next, properties do
        newInstance[property] = value
    end
    return newInstance or nil
end

-- Math Percent
math.percent = function(value, maxValue)
    return (value / maxValue) * 100
end

-- Math Random Float
math.randomFloat = function(min, max)
    return math.random() * (max - min) + min
end
