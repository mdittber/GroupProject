function setProgressInfo(msg, fObject, hObject)
%setProgessInfo(msg, fObject, hObject)
%   msg:        string that should be displayed
%               type 'hline' for a horizontal line
%   fObject:    figure, where the information
%               will be displayed (gui_simulate,...)
%   hObject:    Tag (as string) of the object in the figure,
%               where the information will be displayed
%               (t_progess,...)

guiData = guidata(fObject);
handle  = getfield(guiData, hObject);
current = get(handle,'String');
if strcmp(msg,'hline')
    new = repmat('*',1,59);
else
    new = [getTimeDate(2), ' - ', msg];
end
str = [current;{new}];
set(handle,'String',str);

end