password = "5231"
dc = component.proxy(component.list("os_doorcontroller")())
kp = component.proxy(component.list("os_keypad")())
dc.close()
dc.setPassword("5231")
kp.setDisplay("")
function sleep(time)
  til = computer.uptime() + time
  while true do
    if computer.uptime() >= til then break end
  end
end
entered = ""
while true do
  event, _, pos, key = computer.pullSignal()
  if event == "keypad" then
    if key == "#" then
      if entered == password then
        entered = ""
        kp.setDisplay("CORRECT",2)
        dc.open("5231")
        computer.beep(600,.1)
        sleep(.1)
        computer.beep(600,.1)
        sleep(2)
        kp.setDisplay("")
        dc.close("5231")
      else
        entered = ""
        kp.setDisplay("ERROR",4)
        computer.beep(400,.3)
        sleep(0.7)
        kp.setDisplay("")
      end
    else
      entered = entered..key
      kp.setDisplay(entered,7)
    end
  end
end
