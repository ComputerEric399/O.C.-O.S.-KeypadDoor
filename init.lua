--find an other drive to install to
for a, _ in component.list("filesystem") do
  if not component.proxy(a).exists("/notme") then
    dcit = component.proxy(a)
    computer.setBootAddress(a)
    break
  end
end

--find myself the floppy
for a, _ in component.list("filesystem") do
  if component.proxy(a).exists("/notme") then
    dcif = component.proxy(a)
    break
  end
end

--log all components
log = dcif.open("/log.txt","w")
for k, v in pairs(component.list()) do
  label = ""
  if v == "filesystem" then label = " || "..component.proxy(k).getLabel() end
  dcif.write(log,k.."="..v..label.."\n")
end
dcif.close(log)

--move all files from floppy to drive
if dcit ~= nil then
  if dcif ~= nil then
    for _, filename in pairs(dcif.list("/Files/")) do
      filecopyfrom = dcif.open("/Files/"..filename,"r")
      data = ""
      while true do
        thing = dcif.read(filecopyfrom,1)
        if thing == nil then
          break
        else
          data = data..thing
        end
      end
      dcif.close(filecopyfrom)
      filecopyto = dcit.open("/"..filename,"w")
      dcit.write(filecopyto,data)
      dcit.close(filecopyto)
    end
  else
    error()  
  end
else
  error("Can't Install")
end

--restart
computer.beep()
computer.shutdown(true)
