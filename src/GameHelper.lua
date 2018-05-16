gamehelper = {}
local width,heigth = getScreenSize();
gamehelper.width = width;
gamehelper.heigth = heigth;
--记录400个点的颜色值
function gamehelper:recordScreenColorPoint()
	local screenColorPoints={},ww,hh;
	for i = 1,20 do
		screenColorPoints[i] ={};
		for j =1,20 do 
			screenColorPoints[i][j] = 0;
		end
	end
	if self.width>self.heigth then 
		ww=self.width
		hh=self.heigth
	else 
		ww=self.heigth 
		hh=self.width
	end
	keepScreen(true);
	for i=1,20 do
		for j=1,20 do
			screenColorPoints[i][j]=getColor(i*math.ceil(ww/21),j*math.ceil(hh/21))
		end
	end
	keepScreen(false)
	return screenColorPoints
end
--检测运动状态 true 运动 false 静止
function gamehelper:isRun()
	local countNumber = 0;
	local firstRecord = self:recordScreenColorPoint();
	mSleep(500);
	local secondRecord = self:recordScreenColorPoint();
	for i = 1,20 do
		for j=1,20 do
			if firstRecord[i][j] ~= secondRecord[i][j] then
				countNumber = countNumber + 1;
			end
		end
	end
	sysLog("不同的色素："..countNumber);
	if countNumber > 200 then
		return true;
	else
		return false;
	end
end
-- 识别指定区域屏幕上的非中文字符
function gamehelper.readScreen(rect_,diff_,whitelist_)
	local colorTbl = binarizeImage({ rect = rect_, diff = diff_}); -- 二值化 指定区域图片
	local ocr, msg = createOCR({ type = "tesseract", mode = 2 });
	local code, text = ocr:getText({ data = colorTbl, psm = 6, diff = diff_ ,whitelist = whitelist_});
	ocr:release()
	return code,text;
end
function gamehelper:readNumber(rect_,diff_,whitelist_)
	local num;
	local i=1;
	while i<10 do
		i = i + 1;
		local code, text = self.readScreen(rect_,diff_,whitelist_);
		local startIndex,endIndex = string.find(text,"^%d+");
		if startIndex~=nil and endIndex ~=nil then
			text = string.sub(text,startIndex,endIndex);
			num = tonumber(text);
			if num ~=nil then
				return num;
			end
		end
	end
	return num;
end
function gamehelper:click(fingerNum,x,y,isdelay,delayTime)
	touchDown(1,x,y);	
	mSleep(100);
	touchUp(1,x,y);
	if isdelay==nil then
		isdelay = true;
	end
	if delayTime == nil then
		delayTime = 1000;
	end
	if isdelay then
		mSleep(delayTime);
	end
	
end

return gamehelper;