function varargout = analysis(varargin)
% ANALYSIS MATLAB code for analysis.fig
%      ANALYSIS, by itself, creates a new ANALYSIS or raises the existing
%      singleton*.
%
%      H = ANALYSIS returns the handle to a new ANALYSIS or the handle to
%      the existing singleton*.
%
%      ANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANALYSIS.M with the given input arguments.
%
%      ANALYSIS('Property','Value',...) creates a new ANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before analysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to analysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help analysis

% Last Modified by GUIDE v2.5 15-Jul-2021 19:41:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @analysis_OpeningFcn, ...
                   'gui_OutputFcn',  @analysis_OutputFcn, ...
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


% --- Executes just before analysis is made visible.
function analysis_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to analysis (see VARARGIN)

% Choose default command line output for analysis
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes analysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = analysis_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
global handles_MainWindow;
global choice;
global Xmin Xmax Zmin Zmax;
global U W T PNH;
global X Z V;
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

time = round(get(handles.slider1,'Value'));
[handles_MainWindow.X, handles_MainWindow.Z] = meshgrid (X,Z);
axes(handles.axes1);
switch choice
    case 'T' 
      V = T;
    case 'U'
      V = U;
    case 'W'
      V = W;
    case 'PNH'
      V = PNH;  
end
          
    colormap jet;
    pcolor(handles_MainWindow.X', handles_MainWindow.Z', V(:,:,time));
    shading interp;
    hold on;
    if choice == 'T'
       caxis([990 1022]);
    end
    handles_MainWindow.cb = colorbar;
    axis([Xmin,Xmax,Zmin,Zmax]);
    xlabel ('X, m'); 
    ylabel ('Z, m'); 
    title ([choice,', t = ' num2str(time * 0.125) ' sec']);
    title (handles_MainWindow.cb, handles_MainWindow.title);
    set(gcf,'PaperPositionMode','auto');
    hold off;
    drawnow;

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit1_Callback(hObject, eventdata, handles)
global Xmin;
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
Xmin = str2double(get(hObject,'String'));   


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, ~, handles)
global Zmin;
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
Zmin = str2double(get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
global Xmax;
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
Xmax = str2double(get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
global Zmax;
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
Zmax = str2double(get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global handles_MainWindow;
    [filename, pathname] = uiputfile({'*.mat'},'Save as');
    F = handles_MainWindow.F;
    save([pathname filename], 'F');


function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global X Z Xmin Xmax Zmin Zmax;
global T U W PNH;
set(handles.edit5,'String', '');
[FileName, PathName] = uigetfile('*.mat','Select the file with initial data(density, horizontal velocity)');
    set(handles.edit5,'string', [PathName FileName]);
p = load(FileName);
T = p.T;
U = p.U;
W = p.W;
PNH = p.PNH;
 X = p.X;
 Z = p.Y;
 drho1 = (1022.56 - 997.87);
 T = 1022.56 - drho1/2 - T;
 T = T + 1022.56 - drho1/2; 
 Xmin = round(min(X),3);
 Xmax = round(max(X),3);
 Zmin = round(min(Z),3);
 Zmax = round(max(Z),3);
 set(handles.edit1,'String', Xmin);
 set(handles.edit3,'String', Xmax);
 set(handles.edit2,'String', Zmin);
 set(handles.edit4,'String', Zmax);



% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
global potential
global handles_MainWindow;
global X Z T Xmin Xmax Zmin Zmax
global choice_
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6
choice_ = 'Ep';
x = unique(X);
y = unique(Z);

[X_ Z_] = meshgrid(x,y);
step = (Xmax-Xmin)/700;
xx_ = [Xmin : step : Xmax];
for i = 1:700
    x_(i) = xx_(i);
end
step1 = (Zmax-Zmin)/200;
yy_ = Zmin : step1 : Zmax;
yy_=transpose(yy_);
for i = 1:200
    y_(i) = yy_(i);
end

fun2 = 9.81 * T .* Z';
for i = 1 : 1031
    potential(i) = trapz(x_, trapz(y_, squeeze(fun2(:,:,i)), 2));
end
axes(handles.axes2);
xx=1:1:1031;
handles_MainWindow.E = plot(xx,potential);
ylabel ('E[Дж/м]'); 
xlabel ('t(c)');
grid on

% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
global handles_MainWindow;
global choice;
global U X Z Xmin Xmax Zmin Zmax;

set(handles.slider1,'Value', 0);
disp(get(handles.radiobutton6, 'Value'));
choice = 'U';
handles_MainWindow = handles;
   [handles_MainWindow.X, handles_MainWindow.Z] = meshgrid (X, Z);
    colormap jet;   
    axes(handles.axes1);
    pcolor(handles_MainWindow.X', handles_MainWindow.Z', U(:,:,1));
    shading interp;
    hold on;
    handles_MainWindow.cb = colorbar;
    axis([Xmin,Xmax,Zmin,Zmax]);
    xlabel ('X, m'); 
    ylabel ('Z, m'); 
    title ([choice, ',t = ' num2str( 0 * 0.125) ' sec']);
    handles_MainWindow.title = 'm/c';
    title (handles_MainWindow.cb, 'm/c');
    set(gcf,'PaperPositionMode','auto');
    hold off;
    drawnow;

% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3
global handles_MainWindow;
global choice;
global X Z W Xmin Xmax Zmin Zmax;

set(handles.slider1,'Value', 0);

choice = 'W';
handles_MainWindow = handles;
   axes(handles.axes1);
   [handles_MainWindow.X, handles_MainWindow.Z] = meshgrid (X, Z);
    colormap jet;
    pcolor(handles_MainWindow.X', handles_MainWindow.Z', W(:,:,1));
    shading interp;
    hold on;
    handles_MainWindow.cb = colorbar;
    axis([Xmin,Xmax,Zmin,Zmax]);
    xlabel ('X, m'); 
    ylabel ('Z, m'); 
    title ([choice, ',t = ' num2str( 0 * 0.125) ' sec']);
    handles_MainWindow.title = 'm/c';
    title (handles_MainWindow.cb, 'm/c');
    set(gcf,'PaperPositionMode','auto');
    hold off;
    drawnow;

% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
global handles_MainWindow;
global choice;
global X Z PNH Xmin Xmax Zmin Zmax;
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4
set(handles.slider1,'Value', 0);
choice = 'PNH';
handles_MainWindow = handles;
   axes(handles.axes1);
   [handles_MainWindow.X, handles_MainWindow.Z] = meshgrid (X,Z);
    colormap jet;
    pcolor(handles_MainWindow.X', handles_MainWindow.Z', PNH(:,:,1));
    shading interp;
    hold on;
    handles_MainWindow.cb = colorbar;
    axis([Xmin,Xmax,Zmin,Zmax]);
    xlabel ('X, m'); 
    ylabel ('Z, m'); 
    title ([choice ,', t = ' num2str( 1 * 0.125) ' sec']);
    handles_MainWindow.title = 'H/m';
    title (handles_MainWindow.cb, 'H/m');
    set(gcf,'PaperPositionMode','auto');
    hold off;
    drawnow;


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
global handles_MainWindow;
global choice;
global X Z T Xmin Xmax Zmin Zmax;

set(handles.slider1,'Value', 0);

choice = 'T';
handles_MainWindow = handles;
axes(handles.axes1);
[handles_MainWindow.X, handles_MainWindow.Z] = meshgrid (X, Z);

    colormap jet;
    handles_MainWindow.F = pcolor(handles_MainWindow.X', handles_MainWindow.Z', T(:,:,1));
    shading interp;
    hold on;
    caxis([990 1022]);
    handles_MainWindow.cb = colorbar;
    axis([Xmin,Xmax,Zmin,Zmax]);
    xlabel ('X, m'); 
    ylabel ('Z, m'); 
    title ([choice,', t = ' num2str( 0 * 0.125) ' sec']);
    handles_MainWindow.title = 'kg/m^3';
    title (handles_MainWindow.cb, 'kg/m^3');
    set(gcf,'PaperPositionMode','auto');
    hold off;
    drawnow;


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
global kinetic
global handles_MainWindow
global X Z  T U W Xmin Xmax Zmin Zmax
global choice_

% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5
choice_ = 'Ek';
x = unique(X);
y = unique(Z);

axes(handles.axes2);
[X_ , Z_] = meshgrid(x,y);
step = (Xmax-Xmin)/700;
xx_ = [Xmin : step : Xmax];
for i = 1:700
    x_(i) = xx_(i);
end
step1 = (Zmax-Zmin)/200;
yy_ = Zmin : step1 : Zmax;
yy_=transpose(yy_);
for i = 1:200
    y_(i) = yy_(i);
end
fun = T .* (U.^2 + W.^2);
for i = 1 : 1031
    kinetic(i) = trapz(x_, trapz(y_, squeeze(fun(:,:,i)), 2));
end

ylabel ('E[Дж/м]'); 
xlabel ('t(c)');
xx=1:1:1031;
handles_MainWindow.E = plot(xx,kinetic);
grid on

% --- Executes on button press in radiobutton7.
function radiobutton7_Callback(hObject, eventdata, handles)
global ape
global handles_MainWindow;
global T X Z Xmin Xmax Zmin Zmax
global choice_
% hObject    handle to radiobutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton7
choice_ = 'ape';
x = unique(X);
z = unique(Z);

axes(handles.axes2);
[X_ Z_] = meshgrid(x,z);
step = (Xmax-Xmin)/700;
xx_ = [Xmin : step : Xmax];
for i = 1:700
    x_(i) = xx_(i);
end
step1 = (Zmax-Zmin)/200;
yy_ = Zmin : step1 : Zmax;
yy_=transpose(yy_);
for i = 1:200
    y_(i) = yy_(i);
end

fun3 = 9.81 * (T - T(:,:,1)).*z';
for i = 1 : 1031
    ape(i) = trapz(x_, trapz(y_, squeeze(fun3(:,:,i)), 2));
end

ylabel ('E[Дж/м]'); 
xlabel ('t(c)');
xx=1:1:1031;
handles_MainWindow.E = plot(xx,ape);
grid on

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global handles_MainWindow;
    [filename, pathname] = uiputfile({'*.mat'},'Save as');
    E = handles_MainWindow.E;
    save([pathname filename], 'E');


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
global ape kinetic potential
global choice_ choice
global  X Z T U W PNH
global handles_MainWindow
global Xmin Xmax Zmin Zmax
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
switch choice
    case 'T' 
      V = T;
    case 'U'
      V = U;
    case 'W'
      V = W;
    case 'PNH'
      V = PNH;  
end
switch choice_ 
    case 'Ek' 
      e = kinetic;
    case 'Ep'
      e = potential;
    case 'ape'
      e = ape; 
end
ymin = min(e);
ymax = max(e);
x = [1:1:1031];

if get(hObject,'Value') == 1
    
   cla(handles.axes1,'reset');
   cla(handles.axes2,'reset');
      
   [handles_MainWindow.X, handles_MainWindow.Z] = meshgrid (X, Z);
   
   for i = 1:size(V, 3) 
      axes(handles.axes1);
      colormap jet;
      pcolor(handles_MainWindow.X', handles_MainWindow.Z', V(:,:,i));
      shading interp;
      hold on;
      if choice == 'T'
         caxis([990 1022]);
      end
      handles_MainWindow.cb = colorbar;
      axis([Xmin,Xmax,Zmin,Zmax]);
      xlabel ('X, m'); 
      ylabel ('Z, m'); 
      title ([choice,', t = ' num2str(i * 0.125) ' sec']);
      title (handles_MainWindow.cb, handles_MainWindow.title);
      set(gcf,'PaperPositionMode','auto');
      hold off;
      drawnow;
      if get(hObject,'Value') == 0
        break;
      end
    
    if i ~= 1030
       axes(handles.axes2)
       axis([1 1031 ymin ymax]);
       hold on;
       grid on
       plot([x(i) x(i+1)],[e(i) e(i+1)],'b','LineWidth', 2);
       hold off
       ylabel ('E[Дж/м]'); 
       xlabel ('t(c)');
    end
   end
   set(handles.checkbox1,'Value',0);
end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
global Xmin Xmax Zmin Zmax
global X Z
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 Xmin = round(min(X),3);
 Xmax = round(max(X),3);
 Zmin = round(min(Z),3);
 Zmax = round(max(Z),3);
 set(handles.edit1,'String', Xmin);
 set(handles.edit3,'String', Xmax);
 set(handles.edit2,'String', Zmin);
 set(handles.edit4,'String', Zmax);
 cla(handles.axes1,'reset');
 cla(handles.axes2,'reset');
 set(handles.checkbox1,'Value',0);
 set(handles.slider1,'Value',0);
 
