function varargout = gui_database3(varargin)
% GUI_DATABASE3 MATLAB code for gui_database3.fig
%      GUI_DATABASE3, by itself, creates a new GUI_DATABASE3 or raises the existing
%      singleton*.
%
%      H = GUI_DATABASE3 returns the handle to a new GUI_DATABASE3 or the handle to
%      the existing singleton*.
%
%      GUI_DATABASE3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_DATABASE3.M with the given input arguments.
%
%      GUI_DATABASE3('Property','Value',...) creates a new GUI_DATABASE3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_database3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_database3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_database3

% Last Modified by GUIDE v2.5 09-May-2013 23:48:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_database3_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_database3_OutputFcn, ...
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


% --- Executes just before gui_database3 is made visible.
function gui_database3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_database3 (see VARARGIN)

% Choose default command line output for gui_database3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_database3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_database3_OutputFcn(hObject, eventdata, handles) 
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
%myDB

USER_QDOA = getappdata(0,'USER_QDOA');
Mpar = DButils.createMatrix(USER_QDOA);
[n,m] = size(Mpar);
edit  = cell(n,2);
edit(:,1) = {false};
edit(:,2) = {''};
set(hObject,'data',[edit, Mpar]);


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ps_selall.
function ps_selall_Callback(hObject, eventdata, handles)
% hObject    handle to ps_selall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Data = get(handles.uitable,'data');
Data(:,1) = {true};
set(handles.uitable,'data',Data);


% --- Executes on button press in pb_selnone.
function pb_selnone_Callback(hObject, eventdata, handles)
% hObject    handle to pb_selnone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Data = get(handles.uitable,'data');
Data(:,1) = {false};
set(handles.uitable,'data',Data);


% --- Executes on button press in pb_bandgap.
function pb_bandgap_Callback(hObject, eventdata, handles)
% hObject    handle to pb_bandgap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Data = get(handles.uitable,'data');
if sum(cell2mat(Data(:,1))) == 0
    disp('Please make a selection for plotting!');
else
    [n,m] = size(Data);
    l = 1;
    global config;
    for k=1:n
        if isequal(Data{k,1},true)
            ID = Data{k,20};
            path = [config.simulations, ID, '/QDO.mat'];
            load(path);
            QDOA(l) = QDO;
            l = l+1;
        end
    end
    plotBandGap(QDOA);
end

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

if eventdata.Indices(2) == 2 && strcmp(eventdata.NewData,'Simulation set (path)')
    global config
    Data = get(handles.uitable, 'data');
    row  = eventdata.Indices(1);
    col  = eventdata.Indices(2);
    path = Data{row,20};
    winopen([config.simulations, path]);
    Data{row,col} = eventdata.PreviousData;
    set(handles.uitable, 'data', Data);
end

% --- Executes on button press in pb_export.
function pb_export_Callback(hObject, eventdata, handles)
% hObject    handle to pb_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('Exporting QDOA...');
Data = get(handles.uitable,'data');
if sum(cell2mat(Data(:,1))) == 0
    disp('Nothing to export!');
else
    [n,m] = size(Data);
    l = 1;
    global config;
    for k=1:n
        if isequal(Data{k,1},true)
            ID = Data{k,20};
            path = [config.simulations, ID, '/QDO.mat'];
            load(path);
            QDOA(l) = QDO;
            l = l+1;
        end
    end
    assignin('base','ExportedQDOA',QDOA);
    disp('Export done! QDOA available in workspace as: ExportedQDOA');
end
