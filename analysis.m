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

% Last Modified by GUIDE v2.5 20-Jun-2022 21:29:02

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
global Xmin Xmax Zmin Zmax time_step time_end;
global U W T PNH;
global X Z V Rich;
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
    pcolor(handles_MainWindow.X', handles_MainWindow.Z', V(:,:,time)); 
    colormap(handles.axes1,jet)
    hold on;
      if get(handles.checkbox2,'value') && choice == 'T'
          e1 = pcolor(handles_MainWindow.X', handles_MainWindow.Z', Rich(:,:,time));
          set(e1,'facealpha',0.5);
      end
    shading interp;
    if choice == 'T'
       caxis([990 1022]);
    end
    handles_MainWindow.cb = colorbar(handles.axes1);
    axis([Xmin,Xmax,Zmin,Zmax]);
    handles.axes1.XLabel.String = 'X, m'; 
    handles.axes1.YLabel.String = 'Y, m'; 
    handles.axes1.Title.String = [choice,', t = ' num2str(round(time * time_step,3)) ' sec'];
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
 filter = {'*.jpeg';'*.png';'*.mat';'*.*'};
    [filename, pathname] = uiputfile(filter,'Save as');
    GUI_fig_children=get(gcf,'children');
    Fig_Axes=findobj(GUI_fig_children,'type','Axes');
    fig=figure('Position',[10 10 1150 410],'visible','off');ax=axis;
    clf;
    Axes_temp = handles.axes1;
    if isequal(Fig_Axes(1),handles.axes1)
        Axes_temp = Fig_Axes(1);
    else
        Axes_temp = Fig_Axes(2);
    end
    new_handle=copyobj(Axes_temp,fig);
    fig_children=get(fig,'children');
    Fig_Axes=findobj(fig_children,'type','Axes');
    set(Fig_Axes,'Position',[15 3 60 20]);
    set(fig,'Position',[10 10 600 410])
     p.f = getframe(fig);
     p.im = frame2im(p.f);
     [p.gif, p.map] = rgb2ind(p.im, 256);
    imwrite(p.gif, p.map, [pathname filename])



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
global X Z Xmin Xmax Zmin Zmax time_end time_step;
global T U W PNH Rich kinetic potential ape Fr;
global handles_MainWindow choice choice_;
set(handles.edit5,'String', '');
[FileName, PathName] = uigetfile('*.mat','Select the file with initial data');
set(handles.edit5,'string', [PathName FileName]);

clear p
p = load(FileName);
T = p.T;
U = p.U;
W = p.W;
PNH = p.PNH;
 X = p.X;
 Z = p.Y;
 time_end = size(T,3);
 time_step = 0.00625%.0125;
 drho1 = (1022.56 - 997.87);
 T = 1022.56 - drho1/2 - T;
 T = T + 1022.56 - drho1/2; 
 [handles_MainWindow.X, handles_MainWindow.Z] = meshgrid (X,Z);
 Xmin = round(min(X),3);
 Xmax = round(max(X),3);
 Zmin = round(min(Z),3);
 Zmax = round(max(Z),3);
 set(handles.edit1,'String', Xmin);
 set(handles.edit3,'String', Xmax);
 set(handles.edit2,'String', Zmin);
 set(handles.edit4,'String', Zmax);
 set(handles.radiobutton10,'Value',0)
 set(handles.radiobutton7,'Value',1)

 time = round(get(handles.slider1,'Value'));
 disp(time)
 V = PNH;
 handles_MainWindow.title = 'H/m';
 e = ape;
 choice_  = 'ape';
 choice = 'PNH';
% switch choice
%     case 'T' 
%       V = T;
%     case 'U'
%       V = U;
%     case 'W'
%       V = W;
%     case 'PNH'
%       V = PNH;  
% end
% 
% switch choice_ 
%     case 'Ek' 
%       e = kinetic;
%     case 'Ep'
%       e = potential;
%     case 'ape'
%       e = ape; 
%     case 'Fr'
%       e = Fr;
% end
[handles_MainWindow.X, handles_MainWindow.Z] = meshgrid (X, Z);
   
      axes(handles.axes1);
      colormap jet;
      pcolor(handles_MainWindow.X', handles_MainWindow.Z', V(:,:,time));
      hold on;
      
      if get(handles.checkbox2,'value') && choice == 'T'
          e1 = pcolor(handles_MainWindow.X', handles_MainWindow.Z', Rich(:,:,time));
          set(e1,'facealpha',0.5);
      end
      
      shading interp;
      if choice == 'T'
         caxis([990 1022]);
      end
      handles_MainWindow.cb = colorbar;
      axis([Xmin,Xmax,Zmin,Zmax]);
      handles.axes1.XLabel.String = 'X, m'; 
      handles.axes1.YLabel.String = 'Y, m'; 
      if time == 1
          time = 0;
      end
      handles.axes1.Title.String = [choice,', t = ' num2str(round(time * time_step,3)), ' sec'];
      title(handles_MainWindow.cb, handles_MainWindow.title);
      set(gcf,'PaperPositionMode','auto');
      hold off;
      drawnow;
      
       x = 0:1:length(e)-1;
       
       plot(handles.axes2,x,e,'b');
       if ~isequal(choice_,'Fr')
          handles.axes2.YLabel.String = 'E[Дж/м]'; 
          handles.axes2.XLabel.String = 't(c)';
       else
          x = (x)*time_step;
           handles.axes2.YLabel.String = 'Fr'; 
           handles.axes2.XLabel.String = 'X';
       end

       handles.axes2.XGrid = 'on';
       handles.axes2.YGrid = 'on';

      



% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
global potential
global X Z T Xmin Xmax Zmin Zmax time_end time_step
global choice_
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6
choice_ = 'Ep';
set(handles.radiobutton10,'Value',0)
x = unique(X);
y = unique(Z);

step = (Xmax-Xmin)/size(X,1);
xx_ = [Xmin : step : Xmax];
for i = 1:size(X,1)
    x_(i) = xx_(i);
end
step1 = (Zmax-Zmin)/size(Z,1);
yy_ = Zmin : step1 : Zmax;
yy_=transpose(yy_);
for i = 1:size(Z,1)
    y_(i) = yy_(i);
end

fun2 = 9.81 * T .* Z';
for i = 1 : time_end
    potential(i) = trapz(x_, trapz(y_, squeeze(fun2(:,:,i)), 2));
end
axes(handles.axes2);
xx=1:1:time_end;
xx = xx*time_step;

plot(handles.axes2,xx,potential);
handles.axes2.XLabel.String = 't(c)'; 
handles.axes2.YLabel.String = 'E[Дж/м]'; 
handles.axes2.Title.String = 'Ep';
grid on

% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
global handles_MainWindow;
global choice;
global X Z U Xmin Xmax Zmin Zmax time_step;

set(handles.slider1,'Value', 1);
disp(get(handles.radiobutton6, 'Value'));
choice = 'U';
handles_MainWindow = handles;
colormap jet;   
    axes(handles.axes1);
    [handles_MainWindow.X, handles_MainWindow.Z] = meshgrid (X, Z);
    pcolor(handles_MainWindow.X', handles_MainWindow.Z', U(:,:,1));
    shading interp;
    hold on;
    handles_MainWindow.cb = colorbar;
    axis([Xmin,Xmax,Zmin,Zmax]);
    handles.axes1.XLabel.String = 'X, m'; 
    handles.axes1.YLabel.String = 'Y, m'; 
    handles.axes1.Title.String = [choice, ',t = ' num2str( 0 * time_step) ' sec'];
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
global X Z W Xmin Xmax Zmin Zmax time_step;

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
    handles.axes1.XLabel.String = 'X, m'; 
    handles.axes1.YLabel.String = 'Y, m'; 
    handles.axes1.Title.String = [choice, ',t = ', num2str( 0 * time_step),' sec'];
    handles_MainWindow.title = 'm/c';
    title (handles_MainWindow.cb, 'm/c');
    set(gcf,'PaperPositionMode','auto');
    hold off;
    drawnow;

% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
global handles_MainWindow;
global choice;
global X Z PNH Xmin Xmax Zmin Zmax time_step;
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4
set(handles.slider1,'Value', 1);
choice = 'PNH';
handles_MainWindow = handles;
   axes(handles.axes1);
   [handles_MainWindow.X, handles_MainWindow.Z] = meshgrid (X, Z);

    colormap jet;
    pcolor(handles_MainWindow.X', handles_MainWindow.Z', PNH(:,:,1));
    shading interp;
    hold on;
    handles_MainWindow.cb = colorbar;
    axis([Xmin,Xmax,Zmin,Zmax]);
    handles.axes1.XLabel.String = 'X, m'; 
    handles.axes1.YLabel.String = 'Y, m'; 
    handles.axes1.Title.String = [choice ,', t = ' num2str( 0 * time_step) ' sec'];
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
global T X Z Rich Xmin Xmax Zmin Zmax time_step;

set(handles.slider1,'Value', 1);

choice = 'T';
handles_MainWindow = handles;
axes(handles.axes1);
[handles_MainWindow.X, handles_MainWindow.Z] = meshgrid (X, Z);

    colormap jet;
    pcolor(handles_MainWindow.X', handles_MainWindow.Z', T(:,:,1));
    hold on;
    
      if get(handles.checkbox2,'value')
          e1 = pcolor(handles_MainWindow.X', handles_MainWindow.Z', Rich(:,:,1));
          set(e1,'facealpha',0.5);
      end
      
    shading interp;
    caxis([990 1022]);
    handles_MainWindow.cb = colorbar;
    axis([Xmin,Xmax,Zmin,Zmax]);
    handles.axes1.XLabel.String = 'X, m'; 
    handles.axes1.YLabel.String = 'Y, m'; 
    thandles.axes1.Title.String = [choice,', t = ' num2str( 0 * time_step) ' sec'];
    handles_MainWindow.title = 'kg/m^3';
    title (handles_MainWindow.cb, 'kg/m^3');
    set(gcf,'PaperPositionMode','auto');
    hold off;
    drawnow;


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
global kinetic
global X Z  T U W Xmin Xmax Zmin Zmax time_end time_step
global choice_

% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5
choice_ = 'Ek';
set(handles.radiobutton10,'Value',0)
x = unique(X);
y = unique(Z);

axes(handles.axes2);
step = (Xmax-Xmin)/size(X,1);
xx_ = [Xmin : step : Xmax];
for i = 1:700
    x_(i) = xx_(i);
end
step1 = (Zmax-Zmin)/size(Z,1);
yy_ = Zmin : step1 : Zmax;
yy_=transpose(yy_);
for i = 1:200
    y_(i) = yy_(i);
end
fun = T .* (U.^2 + W.^2);
for i = 1 : time_end
    kinetic(i) = trapz(x_, trapz(y_, squeeze(fun(:,:,i)), 2));
end


xx=1:1:time_end;
xx = xx*time_step;
plot(handles.axes2,xx,kinetic);
handles.axes2.XLabel.String = 't(c)'; 
handles.axes2.YLabel.String = 'E[Дж/м]'; 
handles.axes2.Title.String = 'Ek';
grid on

% --- Executes on button press in radiobutton7.
function radiobutton7_Callback(hObject, eventdata, handles)
global ape
global T X Z Xmin Xmax Zmin Zmax time_end time_step
global choice_
% hObject    handle to radiobutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton7
choice_ = 'ape';
set(handles.radiobutton10,'Value',0)
x = unique(X);
z = unique(Z);

axes(handles.axes2);
step = (Xmax-Xmin)/size(X,1);
xx_ = [Xmin : step : Xmax];
for i = 1:700
    x_(i) = xx_(i);
end
step1 = (Zmax-Zmin)/size(Z,1);
yy_ = Zmin : step1 : Zmax;
yy_=transpose(yy_);
for i = 1:200
    y_(i) = yy_(i);
end

fun3 = 9.81 * (T - T(:,:,1)).*z';
for i = 1 : time_end
    ape(i) = trapz(x_, trapz(y_, squeeze(fun3(:,:,i)), 2));
end


xx=1:1:time_end;
xx = xx*time_step;
plot(handles.axes2,xx,ape);
handles.axes2.XLabel.String = 't(c)'; 
handles.axes2.YLabel.String = 'E[Дж/м]'; 
handles.axes2.Title.String = 'APE';
grid on

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    filter = {'*.jpeg';'*.png';'*.mat';'*.*'};
    [filename, pathname] = uiputfile(filter,'Save as');
    GUI_fig_children=get(gcf,'children');
    Fig_Axes=findobj(GUI_fig_children,'type','Axes');
    fig=figure('Position',[10 10 1150 410],'visible','off');ax=axis;
    clf;
    Axes_temp = handles.axes2;
    if isequal(Fig_Axes(2),handles.axes2)
        Axes_temp = Fig_Axes(2);
    else
        Axes_temp = Fig_Axes(1);
    end
    new_handle=copyobj(Axes_temp,fig);
    fig_children=get(fig,'children');
    Fig_Axes=findobj(fig_children,'type','Axes');
    set(Fig_Axes,'Position',[15 3 60 20]);
    set(fig,'Position',[10 10 600 410])
     p.f = getframe(fig);
     p.im = frame2im(p.f);
     [p.gif, p.map] = rgb2ind(p.im, 256);
    imwrite(p.gif, p.map, [pathname filename])


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
global ape kinetic potential
global choice_ choice
global  X Z T U W PNH Fr Rich
global handles_MainWindow
global Xmin Xmax Zmin Zmax time_end time_step
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
    case 'Fr'
      e = Fr;
end
ymin = min(e);
ymax = max(e);
x = 0:1:time_end;
x = x*time_step;

if get(hObject,'Value') == 1
    
   cla(handles.axes1,'reset');
   cla(handles.axes2,'reset');
      
   [handles_MainWindow.X, handles_MainWindow.Z] = meshgrid (X, Z);
   
   step = round((time_end+1)/16);
   for i = 1:step:time_end - 6
      axes(handles.axes1);
      colormap jet;
      pcolor(handles_MainWindow.X', handles_MainWindow.Z', V(:,:,i));
      hold on;
      
      if get(handles.checkbox2,'value') && choice == 'T'
          e1 = pcolor(handles_MainWindow.X', handles_MainWindow.Z', Rich(:,:,i));
          set(e1,'facealpha',0.5);
      end
      
      shading interp;
      if choice == 'T'
         caxis([990 1022]);
      end
      handles_MainWindow.cb = colorbar;
      axis([Xmin,Xmax,Zmin,Zmax]);
      handles.axes1.XLabel.String = 'X, m'; 
      handles.axes1.YLabel.String = 'Y, m'; 
      handles.axes1.Title.String = [choice,', t = ' num2str(round(i * time_step,3)), ' sec'];
      title (handles_MainWindow.cb, handles_MainWindow.title);
      set(gcf,'PaperPositionMode','auto');
      hold off;
      drawnow;
      if get(hObject,'Value') == 0
        break;
      end
    
    if i ~= time_end - 1
       axes(handles.axes2)
       axis([0 time_end*time_step ymin ymax]);
       hold on;
       grid on
       if ~isequal(choice_,'Fr')
          handles.axes2.YLabel.String = 'E[Дж/м]'; 
          handles.axes2.XLabel.String = 't(c)';
       else
          handles.axes2.XLabel.String = 'X';
          handles.axes2.YLabel.String = 'Fr';
       end
       handles.axes2.Title.String;
       plot([x(i) x(i+step)],[e(i) e(i+step)],'b');
       hold off
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
 grid(handles.axes1,'on');
 grid(handles.axes2,'on');
 set(handles.checkbox1,'Value',0);
 set(handles.checkbox2,'Value',0);
 set(handles.slider1,'Value',0);
 set(handles.radiobutton10,'Value',0)
  set(handles.radiobutton1,'Value',0)
 set(handles.radiobutton2,'Value',0)
 set(handles.radiobutton3,'Value',0)
  set(handles.radiobutton4,'Value',0)
 set(handles.radiobutton5,'Value',0)
 set(handles.radiobutton6,'Value',0)
 set(handles.radiobutton7,'Value',0)


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
global  Z T U Rich
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
T0 = zeros(1,size(T,2));
for j=1:size(T,2)
    T0(j) = mean(T(:,j,:),'all');
end

d_T0= diff(T0);
d_z = -diff(Z);
dT0_dz = zeros(size(d_T0));
dT0_dz(2:size(T,2)) = d_T0./d_z';
N2=abs( 9.8 .* dT0_dz ./ T0 );

N2 = N2';

szdim3 = size(U,3);
szdim2 = size(U,2);
szdim1 = size(U,1);

d_u = diff(U,1,2);
d_z = -diff(Z);
du_dz = zeros(size(d_u));
for i = 1 : szdim1
  for j = 1 : szdim3
     du_dz(i, 2:szdim2, j) = d_u(i,:,j)./d_z';
  end
end

U2 = du_dz .* du_dz;

R = zeros(szdim1,szdim2,szdim3);
for i = 1 : szdim1
  for j = 1 : szdim3
    du_dz_z = U2(i,:,j);
    R(i,:,j) =  N2 ./ (du_dz_z');
  end
end

Rich = T;
   for i = 1:size(T,3)
      for j = 1:size(T,1)
          for k = 1:size(T,2)       
             if R(j,k,i) < 0.25
                 Rich(j,k,i) = R(j,k,i);
             end
           end
      end 
   end


% --- Executes on button press in radiobutton10.
function radiobutton10_Callback(hObject, eventdata, handles)
global Fr
global X U
global choice_
% hObject    handle to radiobutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton11
set(handles.radiobutton7,'Value',0)
set(handles.radiobutton6,'Value',0)
set(handles.radiobutton5,'Value',0)

choice_ = 'Fr';
c = 9.8*max(X);
mi = size(U, 1); 
mj = size(U, 2); 
mk = size(U, 3); 

U_tmp = zeros(mj,mk);
i1 = zeros(1,mi);
i2 = zeros(1,mi);
Fr = zeros(1,mi);
for i = 1 : mi
  for j = 1 : mj
      for k = 1 : mk
        U_tmp(j, k) = U(i,j,k);
      end
  end
  [row,col]=find( U_tmp==max(U_tmp(:)) );
  i1(i) = row(1);
  i2(i) = col(1);
  Fr(i) = U_tmp(i1(i), i2(i)) / c; 
end

axes(handles.axes2);
plot(X(1:mi), Fr);
handles.axes2.XLabel.String = 'X';
handles.axes2.YLabel.String = 'Fr';
grid on


