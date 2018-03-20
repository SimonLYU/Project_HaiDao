--require
require("util")
require("active")
local bb = require("3rd.badboy")
local json = bb.json
--moudle
self = {}
--config
CONFIG_active = 1

--有选项页
function configUI()
	alert_width = 700
	alert_height = 900
	screen_width,screen_height = getScreenSize()
	if screen_width < alert_width then
	alert_width = screen_width - 40
	end
	if screen_height < alert_height then
	alert_height = screen_height - 40
	end
	
	local MyTable = {
	
		["style"] = "default",
		["width"] = alert_width,
		["height"] = alert_height,
		["config"] = "save_001.dat",
		["bg"] = "bg.png",
		["okname"] = "确定",
		["cancelname"] = "取消",
		["views"] = {
			{
				["type"] = "Page",
				["text"] = "总设置",
				["views"] = {
									{
						["type"] = "Label",
						["text"] = "ps:如果主岛内屏幕没有自动滑动，请彻底关掉游戏后重新进入，再开启脚本",
						["size"] = 25,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["type"] = "Label",
						["text"] = "基本功能",
						["size"] = 40,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["id"] = "CheckBoxGroup1",
						["type"] = "CheckBoxGroup",
						["size"] = 40,
						["list"] = "防止重载",
						["select"] = "0",
						["color"] = "255,255,255",
					},
				}
			},
		}
	}
	return MyTable

end

--main
function main()
	--init
	init("0", 1);
	setScreenScale(1242,2208)
	util.initMyHud()
	--UI
	local ret, results = showUI(json.encode(configUI()))    --table转json
	--点击确认返回1, 取消返回0
	if ret == 1 then
		--results 返回以id为key的Map类型数据,返回值为字符串
		if bb.strutils.contains(results["CheckBoxGroup1"],"0") then--防止重载
			CONFIG_active = 1
		else 
			CONFIG_active = 0
		end
	else
		dialog("主人拜拜,我们下次见哦~", 0)
		lua_exit()
	end
	--protect
	if CONFIG_active == 0 then
		dialog("主人,要记得选择功能哦~",0)
		main()
		return 0
	end
	--main function
	repeat
		resetIDLETimer()
		if CONFIG_active == 1 then
			active.func_keep_active()
		end
		mSleep(500)
	until(false)
end
main()
return self