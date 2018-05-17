cqsj={};
cqsj.retry = 0;
cqsj.task = 0;
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
					toast("完成任务");
					self.gamehelper:click(1,x,y);
					self:closeTaskList();
					self:zhaoling_task();
				else
					toast("未找到完成任务");
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
			end
		end
	else
		self.retry = self.retry +1;
		if self.retry < 3 then
			self:zhaoling_task();
		else
			toast("狩魔失败");
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
function cqsj:changlines()
	local time = os.time();
	math.randomseed(time);
	math.random(5);
	local line = math.random(5);
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
	local flag = 0;
	while true do
		local x, y = findColor({929, 531, 970, 571}, 
			"0|0|0x2e1911,0|2|0x77533f,0|4|0x5f3d29,-4|4|0xac886e,6|4|0xc6ac96,3|-5|0xf5f0eb",
			95, 0, 0, 0)
		if x > -1 then
			self.gamehelper:click(1,x,y,true,500);
			x, y = findColor({695,486,730,585}, 
				"0|0|0xfdf1dd,0|3|0x653b32,-6|3|0x890705,5|3|0x8c110c,5|0|0xdcc0aa,-5|0|0xf8f3ed",
				95, 0, 0, 0)
			if x > -1 then
				self.gamehelper:click(1,x,y,false);
				if self.gamehelper:isRun() then
					self:stopMove();
				end
				self:autoBlaming();
				flag = flag +1;
			else
				if flag > 0 then
					mSleep(1500); -- 等待拣去物品
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
end


return cqsj;