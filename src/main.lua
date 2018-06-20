cqsj = require("cqsj");
cqsj:init();
mSleep(3000);
local rect = {1145,31,1272,54}
local diff  = {"0xCB9672-0x20281A"}
local whitelist  = "中州神威狱圣殿走廊";
local code,text = cqsj.gamehelper.readScreen(rect,diff,whitelist,"[external]","chi_sim")
sysLog("code:"..code);
sysLog("text:"..text);
if text == "神威狱" then
	cqsj:quick_task(cqsj.swyOne);
end
sysLog(string.len(text))
sysLog(string.len("中州"))
if string.find (text, "中州") ~= nil then
	sysLog("人物在中州");
end
--cqsj:zhaoling_task();
--cqsj:gold_shoumo();


