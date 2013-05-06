%% This gives the gui_database column headers sorting functionality

guiData = guidata(gui_database);
handle  = getfield(guiData,'uitable');

jscrollpane = findjobj(handle);
jtable = jscrollpane.getViewport.getView;
 
% Now turn the JIDE sorting on
jtable.setSortable(true);
jtable.setAutoResort(true);
jtable.setMultiColumnSortable(true);
jtable.setPreserveSelectionsAfterSorting(true);