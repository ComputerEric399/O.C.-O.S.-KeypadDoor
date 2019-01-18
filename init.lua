--YEET
--The 'YEET' on line one is an identifier so don't delete it!

--Set up boot_invoke to call components.
local component_invoke = component.invoke
local function boot_invoke(address, method, ...)
  local result = table.pack(pcall(component_invoke, address, method, ...))
  if not result[1] then
    return nil, result[2]
  else
    return table.unpack(result, 2, result.n)
  end
end

--Find the floppy disk that the program is installing from.
local floppyAddress
for a, _ in component.list("filesystem") do
  local initFile = boot_invoke(a,"open","init.lua")
  if boot_invoke(a,"read", initFile,6) == "--YEET" then
    floppyAddress = a
    break
  end
end
if floppyAddress == nil then error("Can't find installation floppy!") end

--Find the disk drive address the program is installing to.
local diskDriveAddress
for a, _ in component.list("filesystem") do
  if a ~= floppyAddress and a ~= computer.tmpAddress() then
    diskDriveAddress = a
  end
end
if diskDriveAddress == nil then error("Can't fine disk drive to install to!") end

--Log the components
local logFile = boot_invoke(floppyAddress,"open","/log.txt","w")
for a, t in component.list() do
  boot_invoke(floppyAddress,"write",logFile,a.." | "..t.."\n")
end
boot_invoke(floppyAddress,"write",logFile,"\nFLOPPY --> "..floppyAddress.."\n")
if diskDriveAddress ~= nil then boot_invoke(floppyAddress,"write",logFile,"DISKDRIVE --> "..diskDriveAddress) end
boot_invoke(floppyAddress,"close",logFile)

--Copy/Install the files
for _, filename in pairs(boot_invoke(floppyAddress,"list","/files/")) do
  local handle = boot_invoke(floppyAddress,"open","/files/"..filename)
  local buffer = ""
  repeat
    data = boot_invoke(floppyAddress,"read",handle,math.huge)
    buffer = buffer..(data or "")
  until not data
  boot_invoke(floppyAddress,"close",handle)
  handle = boot_invoke(diskDriveAddress,"open","/"..filename,"w")
  boot_invoke(diskDriveAddress,"write",handle,buffer)
  boot_invoke(diskDriveAddress,"close",handle)
end

--Restart
computer.setBootAddress(diskDriveAddress)
computer.beep()
computer.shutdown(true)
