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
      from = daif.open("/"..file)
    end
  else
    error("No Other Drive Found")  
  end
else
  error("Can't Install")
end
