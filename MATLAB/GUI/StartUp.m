function varargout = StartUp(varargin)
% STARTUP MATLAB code for StartUp.fig
%      STARTUP, by itself, creates a new STARTUP or raises the existing
%      singleton*.
%
%      H = STARTUP returns the handle to a new STARTUP or the handle to
%      the existing singleton*.
%
%      STARTUP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STARTUP.M with the given input arguments.
%
%      STARTUP('Property','Value',...) creates a new STARTUP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before StartUp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to StartUp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help StartUp

% Last Modified by GUIDE v2.5 21-Mar-2013 17:45:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @StartUp_OpeningFcn, ...
                   'gui_OutputFcn',  @StartUp_OutputFcn, ...
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


% --- Executes just before StartUp is made visible.
function StartUp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to StartUp (see VARARGIN)

% Choose default command line output for StartUp
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Initialize program
%init;

% UIWAIT makes StartUp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = StartUp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pb_visualize.
function pb_visualize_Callback(hObject, eventdata, handles)
% hObject    handle to pb_visualize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gui_visualize;


% --- Executes on button press in pb_simulate.
function pb_simulate_Callback(hObject, eventdata, handles)
% hObject    handle to pb_simulate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gui_simulate;


% --- Executes on button press in pb_database.
function pb_database_Callback(hObject, eventdata, handles)
% hObject    handle to pb_database (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gui_database;
sort_gui_database;