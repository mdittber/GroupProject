function timestamp = getTimeDate(option)
% timestamp = getTimeDate(option)
%   Returns a timespamp with date and time, when the
%   function is called
%
%   option=1: for file names  yyyy-mm-dd_hh-mm-ss
%   option=2: for log entries yyyy/mm/dd hh:mm:ss

    switch option
        case 1
            temp = datestr(now,31);
            timestamp = [temp(1:10) ' '];
            timestamp = [timestamp temp(12:19)];
            timestamp(14) = ':';
            timestamp(17) = ':';
        otherwise
            temp = datestr(now,31);
            timestamp = [temp(1:10) ' '];
            timestamp = [timestamp temp(12:19)];
            timestamp(5) = '/';
            timestamp(8) = '/';
            timestamp(14) = ':';
            timestamp(17) = ':';
    end
end