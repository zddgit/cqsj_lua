cqsj={};
cqsj.retry = 0;
cqsj.task = 0;
cqsj.swyOne = {{630,271},{692,359},{587,342},{474,390},{509,461},{482,530},{423,554},{360,529}};
cqsj.comeback={}; --回城石地址
cqsj.sdzlOne = {{211,427},{425,333},{546,312},{483,340},{423,365},{279,441},{375,428},{442,397},{516,357},{620,341},{473,431},{412,520},{577,458},{726,383}};
cqsj.line = 1;
--传奇世界初始化
function cqsj:init() 
	init("0", 1)
	self.gamehelper = require("GameHelper");
	setScreenScale(gamehelper.width,gamehelper.heigth);
	
end

--关闭任务栏
function cqsj:closeTaskTag()
	local x, y = findColor({241, 126, 266, 167}, 
		"0|0|0xffeea4,-1|3|0x5a3816,1|3|0x5b3922,-4|-1|0xfdfda0,4|-1|0xfffece",
		95, 0, 0, 0)
	
	if x > -1 then
		self.gamehelper:click(1,x,y);
	end
end
--展开任务栏
function cqsj:openTaskTag()
	local x, y = findColor({22, 127, 39, 164}, 
		"0|0|0xffeea4,-3|2|0x775233,2|2|0x694d25,2|0|0xfff4a4,-5|-9|0xf4e688,-5|10|0x85562f",
		95, 0, 0, 0)
	
	if x > -1 then
		self.gamehelper:click(1,x,y);
	end
end
--关闭任务列表
function cqsj:closeTaskList()
	local x, y = findColor({1126, 60, 1153, 84}, 
		"0|0|0xe5c57c,-3|0|0x401312,4|0|0x401312,4|-4|0xc9bc95,-4|-4|0xf7eba1,0|-4|0x581517,2|4|0x481c17",
		95, 0, 0, 0)
	if x > -1 then
		self.gamehelper:click(1,x,y);
	end
end
--点击任务标签
function cqsj:clickTaskTag()
	local x, y = findColor({32, 140, 88, 171}, 
		"0|0|0xf5c892,6|0|0xefb386,-4|0|0xecb080,-2|-9|0xf5c791,3|-9|0xf5c38e,23|-3|0xf3c992",
		95, 0, 0, 0)
	if x > -1 then
		self.gamehelper:click(1,x,y);
		return true;
	else
		return false;
	end
end

-- 一键诏令
function cqsj:zhaoling_task()
	self:openTaskTag();
	if self:clickTaskTag() then
		self.retry = 0;
		--诏令
		local x, y = findColor({137, 116, 159, 673}, 
			"0|0|0xd80fe7,5|1|0xd214e4,2|3|0xcd14e1,-5|3|0xbe17d6,-4|8|0xe00beb,7|9|0xe30cee",
			95, 0, 0, 0)
		if x > -1 then
			self.gamehelper:click(1,x,y);
			--立刻前往
			x, y = findColor({659, 615, 685, 641}, 
				"0|0|0xecc38d,7|-3|0xddb17f,0|6|0xe3b986,8|9|0xe8bd89,13|-3|0xeec48e,4|-9|0xf3ca92",
				95, 0, 0, 0)
			if x > -1 then
				self.gamehelper:click(1,x,y);
				self:fly();
				mSleep(6000);
				self:zhaoling_task();
			else
				-- 完成任务
				x, y = findColor({659, 615, 686, 641}, 
					"0|0|0xd1a678,-4|-6|0xeec48e,8|-3|0xf6cd95,6|11|0xf2c891,13|0|0xe8bf8a,12|-10|0xe2b683",
					95, 0, 0, 0)
				if x > -1 then
					self.gamehelper:click(1,x,y);
					self:closeTaskList();
					self:zhaoling_task();
				else
					toast("诏令结束");
					self:closeTaskList();
				end
				
			end
		else
			toast("诏令结束");
		end
	else
		self.retry = self.retry +1;
		if self.retry < 3 then
			self:zhaoling_task();
		else
			toast("诏令失败");
		end
	end
end
-- 一键狩魔
function cqsj:gold_shoumo()
	self:openTaskTag();
	if self:clickTaskTag() then
		-- 狩魔
		local x, y = findColor({138, 115, 160, 671}, 
			"0|0|0x64f967,-1|-5|0x59d76b,-6|-1|0x2e537d,-5|-4|0x65fb66,-7|3|0x59d771",
			95, 0, 0, 0)
		if x > -1 then
			self.gamehelper:click(1,x,y);
			-- 一键完成
			x, y = findColor({923, 616, 951, 641}, 
				"0|0|0xdcb381,-3|4|0xecc28d,10|-1|0xddb280,8|-1|0x855336,3|-1|0x79452c,2|2|0x623623",
				95, 0, 0, 0)
			if x > -1 then
				self.gamehelper:click(1,x,y);
				-- 确定
				x, y = findColor({738, 461, 761, 483}, 
					"0|0|0xf6cd96,-3|-3|0x754b31,2|-2|0x5d3220,-5|4|0xe7bd89,-2|4|0xd6aa7b,-11|0|0xb58861",
					95, 0, 0, 0)
				if x > -1 then
					self.gamehelper:click(1,x,y);
					self:closeTaskList();
					self:gold_shoumo();
				end
			else
				toast("狩魔结束");
				self:closeTaskList();
			end
		else
			toast("狩魔结束");
			self:closeTaskList();
		end
	else
		self.retry = self.retry +1;
		if self.retry < 3 then
			self:gold_shoumo();
		else
			toast("狩魔失败");
			self:closeTaskList();
		end
	end
end
-- 飞鞋
function cqsj:fly()
	local falg = true;
	local retry = 0;
	while falg do
		retry = retry+1;
		if retry > 50 then
			falg = false;
		end
		mSleep(100);
		local x, y = findColor({744, 536, 767, 558}, 
			"0|0|0x7d4f19,8|1|0x27709a,5|2|0x3e4c73,-3|2|0xb79639,-6|1|0x6eb8b9,10|-7|0x8b8574",
			95, 0, 0, 0)
		if x > -1 then
			self.gamehelper:click(1,x,y);
			falg = false;
		else
			sysLog("飞鞋失败");
		end
	end
end
-- 灵兽祭祀
function cqsj:animalSacrifice()
	self:openTaskTag();
	-- 点击任务栏祭祀
	local x, y = findColor({6, 175, 33, 290}, 
		"0|0|0xd912e9,-3|-2|0x9131bf,3|-2|0x614fac,6|-1|0xef08f7,-6|-1|0xd810e7,2|-7|0xf206f8",
		95, 0, 0, 0)
	if x > -1 then
		self.gamehelper:click(1,x,y);
		self:fly();
		local falg = true;
		while falg do 
			mSleep(100);
			--点击NPC祭祀
			x, y = findColor({554, 447, 579, 471}, 
				"0|0|0xbe946a,-2|-1|0x81543a,-4|-1|0xe1b785,4|-2|0x7a482e,6|-2|0xeec48e,2|-8|0xe4b985,-7|9|0xcfa376",
				95, 0, 0, 0)
			if x > -1 then
				falg = false;
				self.gamehelper:click(1,x,y);
				local falg2 = true;
				while falg2 do
					--点击灵兽祭祀
					x, y = findColor({671, 573, 697, 598}, 
						"0|0|0xd7ad7d,-2|-2|0x77442c,-4|-2|0xf3ca93,4|-2|0x6f3e27,6|-2|0xf2c992,3|-8|0xe9be89,-6|-8|0xf4cb94",
						95, 0, 0, 0)
					if x > -1 then
						self.gamehelper:click(1,x,y);
						--放入灵兽
						x, y = findColor({846, 561, 877, 588}, 
							"0|0|0xefc58f,-1|-2|0x5e2f1b,-5|11|0xdfb281,2|10|0xefc48f,5|-6|0xe0b482,-7|-9|0xf2c892",
							95, 0, 0, 0)
						if x > -1 then
							self.gamehelper:click(1,x,y);
							--真正的祭祀
							x, y = findColor({671, 573, 697, 598}, 
								"0|0|0xd7ad7d,-2|-2|0x77442c,-4|-2|0xf3ca93,4|-2|0x6f3e27,6|-2|0xf2c992,3|-8|0xe9be89,-6|-8|0xf4cb94",
								95, 0, 0, 0)
							if x > -1 then
								self.gamehelper:click(1,x,y);
							end
						else
							falg2 = false;
							-- 关闭祭祀
							x, y = findColor({1061, 81, 1087, 109}, 
								"0|0|0xebca7f,-9|9|0xd78243,9|8|0xb77541,6|-5|0xfef3a2,-5|-6|0xd4c8aa",
								95, 0, 0, 0)
							if x > -1 then
								self.gamehelper:click(1,x,y);
							end
						end
					else
						falg2 = false;
					end
				end
			end
		end
	else 
		sysLog("未找到");
	end
end
function cqsj:changlines(line)
	if line==nil then
		local time = os.time();
		math.randomseed(time);
		math.random(5);
		local line = math.random(5);
		while self.line == line do
			line = math.random(5);
		end
	end
	self.line = line;
	sysLog("线路:"..line);
	local x,y;
	x, y = findColor({191, 85, 210, 94}, 
		"0|0|0x3e190c,-8|0|0xefd6b1,-6|-2|0xdcc4a5,4|-2|0xd8c0a1,6|0|0xe3caa7",
		95, 0, 0, 0)
	if x > -1 then
		self.gamehelper:click(1,x,y);
		mSleep(1000);
		if line == 1 then
			x, y = findColor({317, 190, 561, 526}, 
				"0|0|0x38ca40,9|0|0xe7bd88,8|-6|0xefc58e,5|-4|0xe7bb87,9|9|0xe5bc88",
				95, 0, 0, 0)
			if x > -1 then
				self.gamehelper:click(1,x,y);
			end
		elseif line == 2 then
			x, y = findColor({317, 190, 561, 526}, 
				"0|0|0x35c640,12|0|0xebc18c,5|-5|0xdeb07d,8|-7|0xe4b682,8|9|0xe9c08b,5|9|0xf6cd96",
				95, 0, 0, 0)
			if x > -1 then
				self.gamehelper:click(1,x,y);
			end
		elseif line == 3 then
			x, y = findColor({317, 190, 561, 526}, 
				"0|0|0x31c340,8|-7|0xe3b581,8|1|0xe8be89,8|9|0xc1976a,4|7|0x633720,5|-4|0x8c512e",
				95, 0, 0, 0)
			if x > -1 then
				self.gamehelper:click(1,x,y);
			end
		elseif line == 4 then
			x, y = findColor({317, 190, 561, 526}, 
				"0|0|0x35c13d,6|0|0xd4a978,4|4|0xf3ca92,6|-2|0x864b2a,12|8|0xebc18c,7|-4|0x804121",
				95, 0, 0, 0)
			if x > -1 then
				self.gamehelper:click(1,x,y);
			end
		else 
			x, y = findColor({317, 190, 561, 526}, 
				"0|0|0x31c542,6|0|0xf0c690,14|3|0xe0b582,11|3|0x734125,13|0|0x7e4a2a,12|-6|0xf1c690",
				95, 0, 0, 0)
			if x > -1 then
				self.gamehelper:click(1,x,y);
			end
		end
		return true;
	else
		return false;
	end
end
-- 精英怪
function cqsj:killSmallBoss()
	-- flag >0 代表要击杀的目标解决完毕
	local flag = 0;
	local tempY = 313;
	while true do
		cqsj:colseBusyTag();
		--点击扫描要消灭的精英怪
		local x, y = findColor({929, 531, 970, 571}, 
			"0|0|0x2e1911,0|2|0x77533f,0|4|0x5f3d29,-4|4|0xac886e,6|4|0xc6ac96,3|-5|0xf5f0eb",
			95, 0, 0, 0)
		if x > -1 then
			self.gamehelper:click(1,x,y,true,500);
			--获取范围内所有有用的精英怪 
			x,y = findColor({695,tempY,732,623}, 
				"0|0|0xfdf1dd,0|3|0x653b32,-6|3|0x890705,5|3|0x8c110c,5|0|0xdcc0aa,-5|0|0xf8f3ed",
				95, 0, 0, 0)
			--不被期望的精英怪
			local _x,_y = findColor({693, tempY, 789, 688}, 
				"0|0|0xfdf1dd,34|0|0xf7f7f7,38|-2|0xe6e6e6,38|-6|0xd8d9d9,44|-2|0xf6f7f7,42|8|0xf3f3f3,47|8|0xd1d3d3,62|5|0xf8f8f8,57|-1|0xfbfbfb,66|-1|0xf2f2f2,62|-6|0xf9f9f9,62|9|0xdfe1e1",
				85, 0, 0, 0)
			
			if x > -1 and y~=_y then
				self.gamehelper:click(1,x,y,false);
				if self.gamehelper:isRun() then
					self:stopMove();
				end
				self:autoBlaming();
				flag = flag +1;
			else
				if y==_y then
					tempY = y
				end
				if flag > 0 then
					mSleep(3000); -- 等待拣去物品
				end
				self:colseAutoBlaming();
				return flag;
			end
			
		end
		
	end
	
end
-- 启动自动打怪
function cqsj:autoBlaming()
	local x, y = findColor({1213, 351, 1258, 389}, 
		"0|0|0x494735,-14|0|0xc8b7a6,-2|0|0x824f4a,-5|-5|0x564d39,5|-5|0x5e5140",
		95, 0, 0, 0)
	if x > -1 then
		self.gamehelper:click(1,x,y);
	end
end
-- 关闭自动打怪
function cqsj:colseAutoBlaming()
	local x, y = findColor({1219, 347, 1252, 382}, 
		"0|0|0x998866,-13|0|0xd1c0af,0|-16|0x351e13,2|-16|0x4c2d2a,2|-18|0xfaf8e7",
		95, 0, 0, 0)
	if x > -1 then
		self.gamehelper:click(1,x,y);
	end
end
-- 死亡检测(需要另外配置)
function cqsj:roleDead()
	local x, y = findColor({401, 474, 529, 515}, 
		"0|0|0xedc28d,7|-3|0xeec48e,-23|0|0xd9ad7c,-18|5|0xe3ba87,-15|3|0x4f2416,9|6|0xe7be8a",
		95, 0, 0, 0)
	if x > -1 then
		self.gamehelper:click(1,x,y);
	end
end
-- 查看地图
function cqsj:checkMap()
	local x, y = 1217,45
	if x > -1 then
		self.gamehelper:click(1,x,y);
	else
		sysLog("checkMap faile");
	end
	
end
function cqsj:findBoss()
	while true do
		self:killSmallBoss();
		self:checkMap();
		local point = findColors({823, 292, 841, 672}, 
			"0|0|0x311e18,0|-28|0x100a07,-4|-28|0x110a07,-5|-28|0x110b08,-4|-26|0x40281e,-5|-25|0x3c251b,-6|-25|0x20140d",
			95, 0, 0, 0)
		-- sysLog("查到精英："..#point);
		if #point ~= 0 then
			for var = 1, #point do
				if var ~=1 then
					self:checkMap();
				end
				local bossAddress = point[var];
				local x,y = bossAddress.x,bossAddress.y;
				self.gamehelper:click(1,x,y,true,200);
				self:closeTaskList();
				local flag = 0;
				while (self.gamehelper:isRun()) do
					flag = self:killSmallBoss();
					if flag > 0 then
						self:checkMap();
						self.gamehelper:click(1,x,y,true,200);
						self:closeTaskList();
					end
				end
			end
			self:changlines();
		end
	end
end
function cqsj:stopMove()
	local x,y = 133,550;
	local up_y,down_y = 540,560;
	--上移
	touchDown(1, x, y)
	mSleep(50)
	touchMove(1, x, up_y)
	mSleep(50)
	touchUp(1, x, up_y)  
	--下移
	touchDown(1, x, y)
	mSleep(50)
	touchMove(1, x, down_y)
	mSleep(50)
	touchUp(1, x, up_y) 
end
function cqsj:colseBusyTag()
	--网络差提示
	local x,y  = findColor({823, 204, 865, 249}, 
		"0|0|0xf6e18e,-7|7|0xd8884a,7|7|0xd58649,-8|-8|0xf8c65f,9|-9|0xfce25c",
		95, 0, 0, 0)
	if x > -1 then
		self.gamehelper:click(1,x,y);
	end
	--比拼提示
	
	--死亡提示
	self:roleDead();
	
	--关闭神威狱瓶子提示
	x, y = findColor({1150, 201, 1183, 234}, 
		"0|0|0xdeb673,-3|-3|0xf5eba1,2|-3|0xa08c74,4|4|0xe69856,-4|4|0xd19153",
		90, 0, 0, 0)
	if x > -1 then
		self.gamehelper:click(1,x,y);
	end
end
--初始化神威狱
function cqsj:initSWY()
	--执行回城石
	local x, y = findColor({828, 342, 1279, 706}, 
		"0|0|0x6cd6d6,-5|0|0x94dada,-4|3|0x314251,-2|5|0x3bd2b1,2|4|0x4feec2",
		85, 0, 0, 0)
	if x > -1 then
		self.comeback[1],self.comeback[2]= x,y;
		self.gamehelper:click(1,x,y,3000);
	end	
	--点击老兵
	x, y = findColor({393, 188, 715, 416}, 
		"0|0|0xebd26a,-3|0|0xcfa554,8|2|0xf8e674,8|-4|0xe8d169,-19|3|0xfbea76,23|0|0xf7e473,23|4|0xf1dc6f,9|8|0xe9d56b",
		85, 0, 0, 0)
	if x > -1 then
		sysLog("老兵找到");
		self.gamehelper:click(1,x,y,3000);
		--点击前往神威狱
		self.gamehelper:click(1,760,457,3000);
		--点击前往神威狱传送官
		x, y = findColor({335, 84, 591, 541}, 
			"0|0|0xeed66c,-19|0|0xdfbf61,-24|-2|0xf8e674,11|-2|0xe5c966,15|-6|0xf0dc6f,4|7|0xfeef78",
			85, 0, 0, 0)
		if x > -1 then
			sysLog("神威狱传送官找到");
			self.gamehelper:click(1,x,y,3000);
			--点击前往神威狱一层
			self.gamehelper:click(1,760,459,3000);
		end
		
	end
	
end
--刷材料任务
function cqsj:task(taskPoints)
	local length = #taskPoints;
	for i = 1,length,1 do
		if i==2 then
			self:changlines();
		end
		self:checkMap();
		local point = taskPoints[i];
		local x,y = point[1],point[2];
		self.gamehelper:click(1,x,y,true,200);
		self:closeTaskList();
		local flag = 0;
		while (self.gamehelper:isRun()) do
			flag = self:killSmallBoss();
			if flag > 0 then
				self:checkMap();
				self.gamehelper:click(1,x,y,true,200);
				self:closeTaskList();
			end
		end
		if i == length then
			while true do
				if not self.gamehelper:isRun() then
					self:changlines();
					self:task(taskPoints);
				else
					mSleep(1000);
				end
			end
		end
		
	end
end
function cqsj:quick_task(taskPoints)
	local length = #taskPoints;
	local i = 1;
	while true do
		
		--打开地图点击要去的位置，并关闭地图
		self:checkMap();
		local point = taskPoints[i];
		local x,y = point[1],point[2];
		self.gamehelper:click(1,x,y,true,200);
		self:closeTaskList();
		
		--在移动到具体位置的过程中搜寻要击杀的目标
		local flag = 0;
		while (self.gamehelper:isRun()) do
			flag = self:killSmallBoss();
			if flag > 0 then
				self:checkMap();
				self.gamehelper:click(1,x,y,true,200);
				self:closeTaskList();
			end
		end
		--到达指定位置，切换线路,击杀精英
		for line = 1,5,1 do 
			self:changlines(line);
			self:killSmallBoss();
		end
		--当循环到最后一次的时候，初始化i
		if i==length then
			sysLog("初始化i=0");
			i = 0;
		end
		i = i + 1;
	end
	
end

return cqsj;