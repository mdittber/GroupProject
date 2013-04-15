function setProgessInfo(msg, fObject, hObject)
%setProgessInfo(msg)
%   msg:        string that should be displayed
%   fObject:    figure, where the information
%               will be displayed (gui_simulate,...)
%   hObject:    Tag (as string) of the object in the figure,
%               where the information will be displayed
%               (t_progess,...)

guiData = guidata(fObject);
handle  = getfield(guiData, hObject);
current = get(handle,'String');
new = [getTimeDate(2), ' - ', msg];
str = [current;{new}];
set(handle,'String',str);

end