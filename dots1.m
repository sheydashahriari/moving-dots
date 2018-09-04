dots.nDots = 100;                
dots.color = [255,255,255];      
dots.size = 5;                  
dots.center = [0,0];           
dots.apertureSize = [12,12];
dots.x = (rand(1,dots.nDots)-.5)*dots.apertureSize(1) + dots.center(1);
dots.y = (rand(1,dots.nDots)-.5)*dots.apertureSize(2) + dots.center(2);
figure(1)
clf
patch([-.5,-.5,.5,.5]*dots.apertureSize(1)+dots.center(1), ...
    [-.5,.5,.5,-.5]*dots.apertureSize(2)+dots.center(2),[.8,.8,.8]);
hold on
plot(dots.x,dots.y,'ko','MarkerFaceColor','b');
xlabel('X (deg)');
ylabel('Y (deg)');
axis equal
display.dist = 50;
display.width = 30;
tmp = Screen('Resolution',0);
display.resolution = [tmp.width,tmp.height];
pixpos.x = angle2pix(display,dots.x);
pixpos.y = angle2pix(display,dots.y);
pixpos.x = pixpos.x + display.resolution(1)/2;
pixpos.y = pixpos.y + display.resolution(2)/2;
figure(2)
clf
plot(pixpos.x,pixpos.y,'ko','MarkerFaceColor','b');
set(gca,'XLim',[0,display.resolution(1)]);
set(gca,'YLim',[0,display.resolution(2)]);
xlabel('X (pixels)');
ylabel('Y (pixels)');
axis equal
try
    display.skipChecks=1;
    display = OpenWindow(display);
    Screen('DrawDots',display.windowPtr,[pixpos.x;pixpos.y], dots.size, dots.color,[0,0],1);
    Screen('Flip',display.windowPtr);
    pause(2)
catch ME
    Screen('CloseAll');
    rethrow(ME)
end
Screen('CloseAll');
dots.speed = 3;       
dots.duration = 5;    
dots.direction = 30; 
dx = dots.speed*sin(dots.direction*pi/180)/display.frameRate;
dy = -dots.speed*cos(dots.direction*pi/180)/display.frameRate;
nFrames = secs2frames(display,dots.duration);
try
    display = OpenWindow(display);
    for i=1:nFrames
        pixpos.x = angle2pix(display,dots.x)+ display.resolution(1)/2;
        pixpos.y = angle2pix(display,dots.y)+ display.resolution(2)/2;
        Screen('DrawDots',display.windowPtr,[pixpos.x;pixpos.y], dots.size, dots.color,[0,0],1);
        dots.x = dots.x + dx;
        dots.y = dots.y + dy;
        Screen('Flip',display.windowPtr);
    end
catch ME
    Screen('CloseAll');
    rethrow(ME)
end
Screen('CloseAll');
l = dots.center(1)-dots.apertureSize(1)/2;
r = dots.center(1)+dots.apertureSize(1)/2;
b = dots.center(2)-dots.apertureSize(2)/2;
t = dots.center(2)+dots.apertureSize(2)/2;
dots.x = (rand(1,dots.nDots)-.5)*dots.apertureSize(1) + dots.center(1);
dots.y = (rand(1,dots.nDots)-.5)*dots.apertureSize(2) + dots.center(2);
try
    display = OpenWindow(display);
    for i=1:nFrames
        pixpos.x = angle2pix(display,dots.x)+ display.resolution(1)/2;
        pixpos.y = angle2pix(display,dots.y)+ display.resolution(2)/2;
        Screen('DrawDots',display.windowPtr,[pixpos.x;pixpos.y], dots.size, dots.color,[0,0],1);
        dots.x = dots.x + dx;
        dots.y = dots.y + dy;
        dots.x(dots.x<l) = dots.x(dots.x<l) + dots.apertureSize(1);
        dots.x(dots.x>r) = dots.x(dots.x>r) - dots.apertureSize(1);
        dots.y(dots.y<b) = dots.y(dots.y<b) + dots.apertureSize(2);
        dots.y(dots.y>t) = dots.y(dots.y>t) - dots.apertureSize(2);
        Screen('Flip',display.windowPtr);
    end
catch ME
    Screen('CloseAll');
    rethrow(ME)
end
Screen('CloseAll');
dots.lifetime = 12;
l = dots.center(1)-dots.apertureSize(1)/2;
r = dots.center(1)+dots.apertureSize(1)/2;
b = dots.center(2)-dots.apertureSize(2)/2;
t = dots.center(2)+dots.apertureSize(2)/2;
dots.x = (rand(1,dots.nDots)-.5)*dots.apertureSize(1) + dots.center(1);
dots.y = (rand(1,dots.nDots)-.5)*dots.apertureSize(2) + dots.center(2);
dots.life =    ceil(rand(1,dots.nDots)*dots.lifetime);
try
    display = OpenWindow(display);
    for i=1:nFrames
        pixpos.x = angle2pix(display,dots.x)+ display.resolution(1)/2;
        pixpos.y = angle2pix(display,dots.y)+ display.resolution(2)/2;
        Screen('DrawDots',display.windowPtr,[pixpos.x;pixpos.y], dots.size, dots.color,[0,0],1);
        dots.x = dots.x + dx;
        dots.y = dots.y + dy;
        dots.x(dots.x<l) = dots.x(dots.x<l) + dots.apertureSize(1);
        dots.x(dots.x>r) = dots.x(dots.x>r) - dots.apertureSize(1);
        dots.y(dots.y<b) = dots.y(dots.y<b) + dots.apertureSize(2);
        dots.y(dots.y>t) = dots.y(dots.y>t) - dots.apertureSize(2);
        dots.life = dots.life+1;
        deadDots = mod(dots.life,dots.lifetime)==0;
        dots.x(deadDots) = (rand(1,sum(deadDots))-.5)*dots.apertureSize(1) + dots.center(1);
        dots.y(deadDots) = (rand(1,sum(deadDots))-.5)*dots.apertureSize(2) + dots.center(2);
        Screen('Flip',display.windowPtr);
    end
catch ME
    Screen('CloseAll');
    rethrow(ME)
end
Screen('CloseAll');
try
    display = OpenWindow(display);
    goodDots = (dots.x-dots.center(1)).^2/(dots.apertureSize(1)/2)^2 + ...
        (dots.y-dots.center(2)).^2/(dots.apertureSize(2)/2)^2 < 1;
    pixpos.x = angle2pix(display,dots.x)+ display.resolution(1)/2;
    pixpos.y = angle2pix(display,dots.y)+ display.resolution(2)/2;
    Screen('DrawDots',display.windowPtr,[pixpos.x(goodDots);pixpos.y(goodDots)], dots.size, dots.color,[0,0],1);
    Screen('Flip',display.windowPtr);
    pause(5)
catch ME
    Screen('CloseAll');
    rethrow(ME)
end
Screen('CloseAll');
