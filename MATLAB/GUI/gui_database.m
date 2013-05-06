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

% Last Modified by GUIDE v2.5 28-Apr-2013 15:31:32

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
Mpar = DButils.createMatrix(DB);
set(hObject,'data',Mpar);