require("util")
active = {}

STEP_active = 0
MAX_active_step = 3

function active.func_keep_active()
	x, y = findColorInRegionFuzzy(0x75c8f0, 99, 22, 1100, 100, 1120, 0, 0)
	if x > -1 then--城内
		util.hudToast("现在正在帮主人防止重载哦~")
		if STEP_active == 0 then
			util.move(900,400,950,400)
		elseif STEP_active == 1 then
			util.move(1000,800,1000,750)
		elseif STEP_active == 2 then
			util.move(1000,400,950,400)
		elseif STEP_active == 3 then
			util.move(1000,750,1000,800)
		end
		STEP_active = STEP_active + 1
		if STEP_active > MAX_active_step then
			STEP_active = 0
		end
	else--城外
		util.hudToast("定位不在主岛内,返回主岛后将会开启防止重载功能~")
	end
	mSleep(4500)
end

return active