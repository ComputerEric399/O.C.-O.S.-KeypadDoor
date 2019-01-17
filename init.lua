for _, v in component.list("filesystem") do
  if not component.proxy(v).exists("/notme") then
    dait = v
    break
  end
end
for _, v in component.list("filesystem") do
  if component.proxy(v).exists("/notme") then
    daif = v
    break
  end
end
if daif ~= then
  if dait ~= nil then
    for file in daif.list() do
      from = daif.open("/Files/"..file)
      to dait.open("/"..file)
      while true do
        thing = daif.read(from,1)
        if thing == nil then break end
        dait.write(to,thing)
      end
      daif.close(from)
      dait.close(to)
    end
  else
    error("No Other Drive Found")  
  end
else
  error("Can't Install")
end
