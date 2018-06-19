cqsj = require("cqsj");
cqsj:init();
mSleep(3000);
--cqsj:zhaoling_task();
--cqsj:gold_shoumo();
local _hour,_min = tonumber(os.date("%H")),tonumber(os.date("%M"));
if _hour > 14 then
	-- cqsj:initSWY();
	-- cqsj:task(cqsj.swyOne);
	cqsj:quick_task(cqsj.swyOne);
end
--cqsj:task(cqsj.sdzlOne);

