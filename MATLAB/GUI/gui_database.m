function varargout = gui_database(varargin)
% GUI_DATABASE MATLAB code for gui_database.fig
%      GUI_DATABASE, by itself, creates a new GUI_DATABASE or raises the existing
%      singleton*.
%
%      H = GUI_DATABASE returns the handle to a new GUI_DATABASE or the handle to
%      the existing singleton*.
%
%      GUI_DATABASE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_DATABASE.M with the given input arguments.
%
%      GUI_DATABASE('Property','Value',...) creates a new GUI_DATABASE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_database_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_database_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_database

% Last Modified by GUIDE v2.5 26-Apr-2013 15:07:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_database_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_database_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui_database is made visible.
function gui_database_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_database (see VARARGIN)

% Choose default command line output for gui_database
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_database wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_database_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes during object creation, after setting all properties.
function uitable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
DB = DButils.createDB();
Mpar = DButils.createMatrix(DB)
set(hObject,'data',Mpar);

jscrollpane = findjobj(hObject);
jtable = jscrollpane.getViewport.getView;
 
% Now turn the JIDE sorting on
%jtable.setSortable(true);		% or: 
set(jtable,'Sortable','on');
jtable.setAutoResort(true);
jtable.setMultiColumnSortable(true);
jtable.setPreserveSelectionsAfterSorting(true);


% --- Executes on button press in r_ascend.
function r_ascend_Callback(hObject, eventdata, handles)
% hObject    handle to r_ascend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of r_ascend


% --- Executes on button press in r_descend.
function r_descend_Callback(hObject, eventdata, handles)
% hObject    handle to r_descend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of r_descend


% --- Executes on selection change in p_filter1.
function p_filter1_Callback(hObject, eventdata, handles)
% hObject    handle to p_filter1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns p_filter1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from p_filter1


% --- Executes during object creation, after setting all properties.
function p_filter1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p_filter1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in p_filter2.
function p_filter2_Callback(hObject, eventdata, handles)
% hObject    handle to p_filter2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns p_filter2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from p_filter2


% --- Executes during object creation, after setting all properties.
function p_filter2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p_filter2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in p_sort.
function p_sort_Callback(hObject, eventdata, handles)
% hObject    handle to p_sort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns p_sort contents as cell array
%        contents{get(hObject,'Value')} returns selected item from p_sort
% par = get(hObject,'Value');
% colnames = get(handles.uitable,'ColumnName');
% idx = strmatch(par,char(colnames));
% load('LookUp');
% sLookUp = DB.sort(LookUp,idx,'ascend');
% set(handles.uitable,'Data',sLookUp);

% --- Executes during object creation, after setting all properties.
function p_sort_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p_sort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% colnames = get(handles.uitable,'ColumnName');
% set(hObject,'String',colnames);


% --------------------------------------------------------------------
function uitable_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to uitable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when entered data in editable cell(s) in uitable.
function uitable_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected cell(s) is changed in uitable.
function uitable_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on uitable and none of its controls.
function uitable_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to uitable (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
% switch eventdata.Key
%     case '1'
%         disp('1')
%     case '2'
%         disp('2')
% end
