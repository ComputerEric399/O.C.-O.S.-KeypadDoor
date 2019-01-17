for a, _ in component.list("filesystem") do
  if not component.proxy(a).exists("/notme") then
    dcit = a
    break
  end
end
for a, _ in component.list("filesystem") do
  if component.proxy(a).exists("/notme") then
    dcif = a
    break
  end
end
if dcif ~= nil then
  if dcit ~= nil then
    for filename in dcif.list() do
      filecopyfrom = dcif.open("/Files/"..filename)
      filecopyto = dcit.open("/"..filename)
      while true do
        thing = dcif.read(filecopyfrom,1)
        if thing == nil then break end
        dcit.write(filecopyto,thing)
      end
      dcif.close(filecopyfrom)
      dcit.close(filecopyto)
    end
  else
    error("No Other Drive Found")  
  end
else
  error("Can't Install")
end
