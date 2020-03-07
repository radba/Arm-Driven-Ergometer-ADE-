function RepeatedSignal = repeatPattern(Signal,numOfRepetition)

step = 0;


if( size(Signal,1) > size(Signal,2) )
    
    RepeatedSignal = zeros(size(Signal,1)*numOfRepetition,size(Signal,2));
    step = size(Signal,1);
    
else
    step = size(Signal,2);
    RepeatedSignal = zeros(size(Signal,1),size(Signal,2)*numOfRepetition);
    RepeatedSignal = RepeatedSignal';
    Signal = Signal';
    
    
    
end

startIndex = 1;


for index = 1:numOfRepetition
    
    RepeatedSignal(startIndex:index*step,:) = Signal;
    
    startIndex = index*step+1;
    
    
    
end





end