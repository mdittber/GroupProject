function setLogInfo(msg)
%setLogInfo(msg)
%   msg:        string that should be written to the log file

global config
dirLog = config.log
fid = fopen(dirLog, 'a+');
LogEntry = sprintf([getTimeDate(2), ' - ', msg, '\n']);
fwrite(fid, LogEntry, 'char');
fclose(fid);

end