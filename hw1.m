function varargout = hw1(varargin)
% HW1 MATLAB code for hw1.fig
%      HW1, by itself, creates a new HW1 or raises the existing
%      singleton*.
%
%      H = HW1 returns the handle to a new HW1 or the handle to
%      the existing singleton*.
%
%      HW1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HW1.M with the given input arguments.
%
%      HW1('Property','Value',...) creates a new HW1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before hw1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to hw1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help hw1

% Last Modified by GUIDE v2.5 31-Oct-2019 20:19:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @hw1_OpeningFcn, ...
                   'gui_OutputFcn',  @hw1_OutputFcn, ...
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


% --- Executes just before hw1 is made visible.

function myshow(f, axes1, axes2, axes3, axes4, axes5, axes6 )
step = 5;
axes(axes1); imshow(f, []);
F1 = dft2(f);
F = fftshift(F1);
axes(axes2);imshow(log(abs(F) + 1), []);    
axes(axes3);imshow(angle(F), []);
axes(axes4); surf(f(1:step:end,1:step:end))
axes(axes5); surf(log(abs(F(1:step:end,1:step:end))));
axes(axes6); surf(angle(F(1:step:end,1:step:end)));

%do as book p187 says
function F1 = dft2(f)  
[M,N] = size(f);
[V,X] = meshgrid(0:N-1,0:M-1);%attention the order of V and X
Fmid = zeros(M,N);      
F1 = zeros(M,N);
for y = 0:N-1
    ff = @(x) f(x+1,y+1);
    Fmid = Fmid + reshape(ff(X),[M N]).*exp( ((-2)*pi*1i*y / N).*V);
end
[V,U] = meshgrid(0:N-1,0:M-1);
for x = 0:M-1
    fff = @(v) Fmid(x+1,v+1);
    F1 = F1 + reshape(fff(V),[M N]).*exp( ((-2)*pi*1i*x / M).*U);
end





function hw1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to hw1 (see VARARGIN)

% Choose default command line output for hw1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes hw1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = hw1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider12_Callback(hObject, eventdata, handles)
% hObject    handle to slider12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(get(handles.radiobutton4,'Value')==1)
   sigma = get(handles.slider12,'Value');
   f = fspecial('gaussian',256,sigma);
   myshow(f, handles.axes1, handles.axes2,handles.axes3,handles.axes4,handles.axes5,handles.axes6);
end
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(get(handles.radiobutton3,'Value')==1)
   a = int32(get(handles.slider7,'Value'));
   x = int32(get(handles.slider8,'Value'));
   y = int32(get(handles.slider9,'Value'));
   width = int32(get(handles.slider10,'Value'));
   height = int32(get(handles.slider11,'Value'));
   if(width==0) 
       width=2;
   end
   if(height==0)
       height=2;
   end
   if(x==0)
       x=2;
   end
   if(y==0)
       y=2;
   end
   f = zeros(256,256);
   if(x-width/2<0)
       x1=0;
   else
       x1=int32(x-width/2);
   end
   
   if(x+width/2>256)
       x2=256;
   else
       x2=int32(x+width/2);
   end
   
   if(y-height/2<0)
       y1=0;
   else
       y1=int32(y-height/2);
   end
   
   if(y+height/2>256)
       y2=256;
   else
       y2=int32(y+height/2);
   end
   f(x1:x2,y1:y2)=1;
   f=imrotate(f,a,'nearest');
   myshow(f, handles.axes1, handles.axes2,handles.axes3,handles.axes4,handles.axes5,handles.axes6);
end
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(get(handles.radiobutton3,'Value')==1)
   a = int32(get(handles.slider7,'Value'));
   x = int32(get(handles.slider8,'Value'));
   y = int32(get(handles.slider9,'Value'));
   width = int32(get(handles.slider10,'Value'));
   height = int32(get(handles.slider11,'Value'));
   if(width==0) 
       width=2;
   end
   if(height==0)
       height=2;
   end
    if(x==0)
       x=2;
   end
   if(y==0)
       y=2;
   end
   f = zeros(256,256);
   if(x-width/2<0)
       x1=0;
   else
       x1=int32(x-width/2);
   end
   
   if(x+width/2>256)
       x2=256;
   else
       x2=int32(x+width/2);
   end
   
   if(y-height/2<0)
       y1=0;
   else
       y1=int32(y-height/2);
   end
   
   if(y+height/2>256)
       y2=256;
   else
       y2=int32(y+height/2);
   end
   f(x1:x2,y1:y2)=1;
   f=imrotate(f,a,'nearest');
   myshow(f, handles.axes1, handles.axes2,handles.axes3,handles.axes4,handles.axes5,handles.axes6);
end
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider9_Callback(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(get(handles.radiobutton3,'Value')==1)
   a = int32(get(handles.slider7,'Value'));
   x = int32(get(handles.slider8,'Value'));
   y = int32(get(handles.slider9,'Value'));
   width = int32(get(handles.slider10,'Value'));
   height = int32(get(handles.slider11,'Value'));
   if(width==0) 
       width=2;
   end
   if(height==0)
       height=2;
   end
    if(x==0)
       x=2;
   end
   if(y==0)
       y=2;
   end
   f = zeros(256,256);
   if(x-width/2<0)
       x1=0;
   else
       x1=int32(x-width/2);
   end
   
   if(x+width/2>256)
       x2=256;
   else
       x2=int32(x+width/2);
   end
   
   if(y-height/2<0)
       y1=0;
   else
       y1=int32(y-height/2);
   end
   
   if(y+height/2>256)
       y2=256;
   else
       y2=int32(y+height/2);
   end
   f(x1:x2,y1:y2)=1;
   f=imrotate(f,a,'nearest');
   myshow(f, handles.axes1, handles.axes2,handles.axes3,handles.axes4,handles.axes5,handles.axes6);
end
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider10_Callback(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(get(handles.radiobutton3,'Value')==1)
   a = int32(get(handles.slider7,'Value'));
   x = int32(get(handles.slider8,'Value'));
   y = int32(get(handles.slider9,'Value'));
   width = int32(get(handles.slider10,'Value'));
   height = int32(get(handles.slider11,'Value'));
   if(width==0) 
       width=2;
   end
   if(height==0)
       height=2;
   end
    if(x==0)
       x=2;
   end
   if(y==0)
       y=2;
   end
   f = zeros(256,256);
   if(x-width/2<0)
       x1=0;
   else
       x1=int32(x-width/2);
   end
   
   if(x+width/2>256)
       x2=256;
   else
       x2=int32(x+width/2);
   end
   
   if(y-height/2<0)
       y1=0;
   else
       y1=int32(y-height/2);
   end
   
   if(y+height/2>256)
       y2=256;
   else
       y2=int32(y+height/2);
   end
   f(x1:x2,y1:y2)=1;
   f=imrotate(f,a,'nearest');
   myshow(f, handles.axes1, handles.axes2,handles.axes3,handles.axes4,handles.axes5,handles.axes6);
end
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider11_Callback(hObject, eventdata, handles)
% hObject    handle to slider11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(get(handles.radiobutton3,'Value')==1)
   a = int32(get(handles.slider7,'Value'));
   x = int32(get(handles.slider8,'Value'));
   y = int32(get(handles.slider9,'Value'));
   width = int32(get(handles.slider10,'Value'));
   height = int32(get(handles.slider11,'Value'));
   if(width==0) 
       width=2;
   end
   if(height==0)
       height=2;
   end
    if(x==0)
       x=2;
   end
   if(y==0)
       y=2;
   end
   f = zeros(256,256);
   if(x-width/2<0)
       x1=0;
   else
       x1=int32(x-width/2);
   end
   
   if(x+width/2>256)
       x2=256;
   else
       x2=int32(x+width/2);
   end
   
   if(y-height/2<0)
       y1=0;
   else
       y1=int32(y-height/2);
   end
   
   if(y+height/2>256)
       y2=256;
   else
       y2=int32(y+height/2);
   end
   f(x1:x2,y1:y2)=1;
   f=imrotate(f,a,'nearest');
   myshow(f, handles.axes1, handles.axes2,handles.axes3,handles.axes4,handles.axes5,handles.axes6);
end
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(get(handles.radiobutton2,'Value')==1)
   a = get(handles.slider3,'Value')*pi/180;
   v = get(handles.slider4,'Value');
   b = get(handles.slider6,'Value');
   [C, R] = meshgrid(0:255, 0:255);
   f = sin(2*pi*v*(cos(a)*double(R) + sin(a)*double(C)) + b);
   myshow(f, handles.axes1, handles.axes2,handles.axes3,handles.axes4,handles.axes5,handles.axes6);
end
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(get(handles.radiobutton2,'Value')==1)
   a = get(handles.slider3,'Value')*pi/180;
   v = get(handles.slider4,'Value');
   b = get(handles.slider6,'Value');
   [C, R] = meshgrid(0:255, 0:255);
   f = sin(2*pi*v*(cos(a)*double(R) + sin(a)*double(C)) + b);
   myshow(f, handles.axes1, handles.axes2,handles.axes3,handles.axes4,handles.axes5,handles.axes6);
end
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(get(handles.radiobutton2,'Value')==1)
   a = get(handles.slider3,'Value')*pi/180;
   v = get(handles.slider4,'Value');
   b = get(handles.slider6,'Value');
   [C, R] = meshgrid(0:255, 0:255);
   f = sin(2*pi*v*(cos(a)*double(R) + sin(a)*double(C)) + b);
   myshow(f, handles.axes1, handles.axes2,handles.axes3,handles.axes4,handles.axes5,handles.axes6);
end
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(get(handles.radiobutton1,'Value')==1)
   x = int32(get(handles.slider1,'Value'));
   y = int32(get(handles.slider2,'Value'));
   x = x+1;
   y = y+1;
   f = zeros(256,256);
   f(x:x+4,y:y+4) = 1;  
   myshow(f, handles.axes1, handles.axes2,handles.axes3,handles.axes4,handles.axes5,handles.axes6);
end
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(get(handles.radiobutton1,'Value')==1)
   x = int32(get(handles.slider1,'Value'));
   y = int32(get(handles.slider2,'Value'));
   x = x+1;
   y = y+1;
   f = zeros(256,256);
   f(x:x+4,y:y+4) = 1;  
   myshow(f, handles.axes1, handles.axes2,handles.axes3,handles.axes4,handles.axes5,handles.axes6);
end
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
