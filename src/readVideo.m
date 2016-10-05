colB = vision.VideoFileReader('C:\Users\Vikram\Documents\EDU\Summer 2012\SJ\sj.avi', 'AudioOutputPort', true);

audio = zeros(0,2);
i = 0;
while ~isDone(colB)
    i = i+1;
    [~,audF] = step(colB);
    audio = [audio; audF];
end