cqsj = require("cqsj");
cqsj:init();
mSleep(3000);
local rectMap = {1145,31,1272,54}
local diffMap  = {"0xC99874-0x2C3321"}
local whitelistMap  = "中州神威狱圣殿走廊猛兽高原魔宫太上玉清秘境全民宝地一二三四五层定远废墟沉船";
local code,text = cqsj.gamehelper.readScreen(rectMap,diffMap,whitelistMap,"[external]","chi_sim")
sysLog("code:"..code);
sysLog("text:"..text);
if string.find (text, "神威狱") ~= nil and string.find (text, "一")  then
	cqsj.nowTask = 0;
	cqsj:quick_task(cqsj.swyOne);
end
if string.find (text, "神威狱") ~= nil and string.find (text, "二")  then
	cqsj.nowTask = 0;
	cqsj:quick_task(cqsj.swyTwo,3);
end
if string.find (text, "高原") ~= nil then
	cqsj.nowTask = 0;
	cqsj:quick_task(cqsj.msgy);
end
if string.find (text, "圣殿魔宫") ~= nil then
	cqsj:quick_task(cqsj.sdmg,1);
end
if string.find (text, "秘境") ~= nil then
	cqsj:quick_task(cqsj.mj);
end
if string.find(text,"全民") ~=nil and  string.find(text,"五") then
	cqsj:quick_task(cqsj.bd_five);
end
if string.find(text,"定远废墟") ~=nil and  string.find(text,"一") then
	cqsj:quick_task(cqsj.dyfx_one);
end
if string.find(text,"沉") ~=nil and  string.find(text,"二") then
	cqsj:quick_task(cqsj.cc_two);
end
cqsj:zhaoling_task();
cqsj:gold_shoumo();


