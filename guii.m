function varargout = guii(varargin)
% GUII MATLAB code for guii.fig
%      GUII, by itself, creates a new GUII or raises the existing
%      singleton*.
%
%      H = GUII returns the handle to a new GUII or the handle to
%      the existing singleton*.
%
%      GUII('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUII.M with the given input arguments.
%
%      GUII('Property','Value',...) creates a new GUII or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guii_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guii_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guii

% Last Modified by GUIDE v2.5 12-Jan-2017 19:00:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guii_OpeningFcn, ...
                   'gui_OutputFcn',  @guii_OutputFcn, ...
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

% --- Executes just before guii is made visible.
function guii_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guii (see VARARGIN)

% Choose default command line output for guii
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using guii.
if strcmp(get(hObject,'Visible'),'off')
    plot(rand(5));
end

% UIWAIT makes guii wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guii_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
cla;
popup_sel_index = get(handles.popupmenu1, 'Value');
switch popup_sel_index
    case 1
        plot(rand(5));
    case 2
        plot(sin(1:0.01:25.99));
    case 3
        bar(1:.5:10);
    case 4
        plot(membrane);
    case 5
        surf(peaks);
end


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    vectorsTableData = get(handles.vectors, 'data');
    scalarsTableData = get(handles.scalars, 'data');
    B_strTab = char(vectorsTableData(1,:));
    E_strTab = char(vectorsTableData(2,:));
    v0 = cell2mat(vectorsTableData(3,:));
    r0 = cell2mat(vectorsTableData(4,:));
    m = scalarsTableData(1);
    q = scalarsTableData(2);
    tmax = scalarsTableData(3);
    dt = scalarsTableData(4);
    dr = scalarsTableData(5);
    E = str3D2func(E_strTab);
    B = str3D2func(B_strTab);

    %cos w tym stylu chyba, tylko nie mam sil juz tego testowac
    f = @(t,v)[ v(4); v(5); v(6); 
        q/m * (E{1}(v(1),v(2),v(3)) + v(5) * B{3}(v(1),v(2),v(3)) - v(6) * B{2}(v(1),v(2),v(3)));
        q/m * (E{2}(v(1),v(2),v(3)) + v(6) * B{1}(v(1),v(2),v(3)) - v(4) * B{3}(v(1),v(2),v(3)));
        q/m * (E{3}(v(1),v(2),v(3)) + v(4) * B{2}(v(1),v(2),v(3)) - v(5) * B{1}(v(1),v(2),v(3)));];
    [tt, vv] = ode45(f,[0 tmax],[r0(1) r0(2) r0(3) v0(1) v0(2) v0(3)]);
    %syms t
    %ezplot3(vv(1), vv(2), vv(3),[0 tmax])

function funcCellArray = str3D2func(strTab)
    funcBeginning = '@(x,y,z)';
    x = str2func(strcat(funcBeginning,strTab(1,:)));
    y = str2func(strcat(funcBeginning,strTab(2,:)));
    z = str2func(strcat(funcBeginning,strTab(3,:)));
    funcCellArray = {x, y, z};

% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
