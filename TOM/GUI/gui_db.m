function gui_db(varargin)
%gui_db(varargin)
%   Function with no argument loads whole database
%   IF gui_db is called with a 

    if nargin == 0
        gui_databaseAll;
        sort_gui_database(0);
    elseif nargin == 1
        setappdata(0,'USER_QDOA',varargin{1})
        gui_databaseSelection;
        sort_gui_database(1);
    else
        disp('Please only call with one Qdot Array!');
    end
end

function sort_gui_database(selection)
% This gives the gui_database column headers sorting functionality

    switch selection
        case 0
            guiData = guidata(gui_databaseAll);
        case 1
            guiData = guidata(gui_databaseSelection);
    end
    handle  = getfield(guiData,'uitable');

    jscrollpane = findjobj(handle);
    jtable = jscrollpane.getViewport.getView;
 
    % Now turn the JIDE sorting on
    jtable.setSortable(true);
    jtable.setAutoResort(true);
    jtable.setMultiColumnSortable(true);
    jtable.setPreserveSelectionsAfterSorting(true);
end