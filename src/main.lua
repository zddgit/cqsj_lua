cqsj = require("cqsj");
cqsj:init();
mSleep(3000);
local rect = {1145,31,1272,54}
local diff  = {"0xC99874-0x2C3321"}
local whitelist  = "中州神威狱圣殿走廊猛兽高原魔宫太上玉清秘境全民宝地五层";
local code,text = cqsj.gamehelper.readScreen(rect,diff,whitelist,"[external]","chi_sim")
sysLog("code:"..code);
sysLog("text:"..text);
if string.find (text, "神威狱") ~= nil then
	cqsj:quick_task(cqsj.swyOne);
end
if string.find (text, "高原") ~= nil then
	cqsj:quick_task(cqsj.msgy);
end
if string.find (text, "圣殿魔宫") ~= nil then
	cqsj:quick_task(cqsj.sdmg);
end
if string.find (text, "秘境") ~= nil then
	cqsj:quick_task(cqsj.mj);
end
if string.find(text,"全民") ~=nil and  string.find(text,"五") then
	cqsj:quick_task(cqsj.bd_five);
end
cqsj:zhaoling_task();
cqsj:gold_shoumo();


