local battery_timer = statusd.create_timer();

local function battery()
   local f = io.popen('acpi -b 2> /dev/null', 'r')
   local output = f:read('*all')
   f:close()

   if output == "" or output == "\n" then
      statusd.inform("battery", "?")
      statusd.inform("battery_hint", "normal")

      battery_timer:set(20000, battery)
      return
   end

   local _, _, state, charge = string.find(output, "Battery 0: ([a-zA-Z]*), ([0-9]*).*\n")

   hint = "important"

   if state == "Full" then
      state = ""
      hint = "normal"
   elseif state == "Charging" then
      state = "+"
   else
      state = "-"
      if tonumber(charge) < 25 then
         hint = "critical"
      end
   end

   statusd.inform("battery", charge.."%"..state)
   statusd.inform("battery_hint", hint)

   battery_timer:set(10000, battery)
end

battery()
