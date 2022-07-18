function varargout = GUIDECV(varargin)
% GUIDECV MATLAB code for GUIDECV.fig
%      GUIDECV, by itself, creates a new GUIDECV or raises the existing
%      singleton*.
%
%      H = GUIDECV returns the handle to a new GUIDECV or the handle to
%      the existing singleton*.
%
%      GUIDECV('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIDECV.M with the given input arguments.
%
%      GUIDECV('Property','Value',...) creates a new GUIDECV or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUIDECV_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUIDECV_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDECV's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDECV, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUIDECV

% Last Modified by GUIDECV v2.5 29-Jun-2022 21:45:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUIDECV_OpeningFcn, ...
                   'gui_OutputFcn',  @GUIDECV_OutputFcn, ...
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


% --- Executes just before GUIDECV is made visible.
function GUIDECV_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUIDECV (see VARARGIN)

% Choose default command line output for GUIDECV
handles.output = hObject;
global pos1
global pos2
global pos3
global pos4
global max_y
global max_x
global min_y
global min_x
global x_max
global y_max
global vanishing_point
global m
global n
global p
global min_y_fore
global max_y_fore
global min_x_fore
global max_x_fore
global poss1
global poss2
global poss3
global poss4
global estimatedVertex
set(hObject,'toolbar','figure') %Show Toolbar
cameratoolbar('NoReset')%Show camera toolbar without presets
global img
global test
global FGVertex
global outFG
global foreobj
global pic_num
global foreground
global background
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUIDECV wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUIDECV_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.axes3,'visible','off'); % hide the axes
ax2=axes('units','normalized','pos',[0.75 0.75 0.25 0.25]); % Create axes
uistack(ax2,'top');  %Reorder the view cascade for UI components
addpath(genpath('./')); 
image_name="./img/tum_logo.png";
ii=imread(image_name);%Add tumlogo
image(ii);
colormap gray %View and set the current colormap
set(ax2,'handlevisibility','off','visible','off');% hide the axes

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes3);
[filename,pathname]=uigetfile({'*.bmp;*.jpg;*.png;*.jpeg;*.tif'},'select a picture');
str=[pathname filename];
% Check if the file is empty
global img
img = imread(str);
% imshow(im)
if isequal(filename,0)||isequal(pathname,0)
    warndlg('please select a picture first!','warning');
    return;
else
    img = imread(str);
    imshow(img);
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text2.
function text2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes3); %Specify the coordinates that need to be cleared
cla reset;
set(handles.axes3,'visible','off'); 



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes3 = gca;%Get the current axis
h=imrect;%The mouse turns into a cross to select the region of interest


%There will be a rectangular box that can be dragged and resized

pos=getPosition(h);%pos has four values，are the coordinates of the upper left corner of the rectangular box x y and the width and height of the box
hold on
global pos1
global pos2
global pos3
global pos4
pos1=[pos(1),pos(2)]
%pos1=[pos(2),pos(1)]
pos2=[pos(1)+pos(3),pos(2)]
%pos2=[pos(2)+pos(4),pos(1)]
pos3=[pos(1)+pos(3),pos(2)+pos(4)]
%pos3=[pos(2),pos(1)+pos(3)]
pos4=[pos(1),pos(2)+pos(4)]
%pos4=[pos(2)+pos(4),pos(1)+pos(3)]
global max_y
global max_x
global min_y
global min_x
 min_y=pos(2);
 max_y=pos(2)+pos(4);
 min_x=pos(1);
 max_x=pos(1)+pos(3);


 

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
[x,y] = ginput(1);

hold on
a=min(x);
b=min(y);%Get the pixel coordinates of a point clicked by the mouse, x saves the abscissa vector, y saves the ordinate vector
a=floor(a)
b=floor(b)
T=[a,b]
global vanishing_point
global estimatedVertex
vanishing_point=[b,a];
% plot(a,b,'bo')
global pos1
global pos2
global pos3
global pos4

global max_y
global max_x
global min_y
global min_x

global img
global x_max
global y_max
global m
global n
global p
global pic_num
global foreground
 [m,n,p]=size(img)
    x_max = n
    y_max = m

   x_vp = a;
   y_vp = b;

coordinat_sp(1,:)= pos4; %1
coordinat_sp(2,:) = pos3; %2
coordinat_sp(3,:) = pos2; %8
coordinat_sp(4,:) = pos1; %7


% gradient for the foreground
for i =1:4
    gradient(i) = (coordinat_sp(i,2)-y_vp)/(coordinat_sp(i,1)-x_vp)
end
%plot(x_sp,y_sp,'b')
estimatedVertex = zeros(2,12);
estimatedVertex(:,1) = pos4;
estimatedVertex(:,2) = pos3;
estimatedVertex(:,8) = pos2;
estimatedVertex(:,7) = pos1;

estimatedVertex(:,3) = [(y_max-y_vp)/gradient(1) + x_vp; y_max];
estimatedVertex(:,5) = [1; (1-x_vp)*gradient(1) + y_vp];
estimatedVertex(:,4) = [(y_max-y_vp)/gradient(2) + x_vp; y_max];
estimatedVertex(:,6) = [x_max; (x_max-x_vp)*gradient(2) + y_vp];
estimatedVertex(:,10) = [(1-y_vp)/gradient(3) + x_vp; 1];
estimatedVertex(:,12) = [x_max; (x_max-x_vp)*gradient(3) + y_vp];
estimatedVertex(:,9) = [(1-y_vp)/gradient(4) + x_vp; 1];
estimatedVertex(:,11) = [1; (1-x_vp)*gradient(4) + y_vp];


for i = 1:12
    plot([estimatedVertex(1,i),x_vp],[estimatedVertex(2,i),y_vp],'r-','lineWidth',3)
    text(estimatedVertex(1,i),estimatedVertex(2,i),num2str(i))
end

 plot([estimatedVertex(1,5),estimatedVertex(1,11)],[estimatedVertex(2,5),estimatedVertex(2,11)],'r-','lineWidth',3)
 plot([estimatedVertex(1,9),estimatedVertex(1,10)],[estimatedVertex(2,9),estimatedVertex(2,10)],'r-','lineWidth',3)
 plot([estimatedVertex(1,6),estimatedVertex(1,12)],[estimatedVertex(2,6),estimatedVertex(2,12)],'r-','lineWidth',3)
 plot([estimatedVertex(1,3),estimatedVertex(1,4)],[estimatedVertex(2,3),estimatedVertex(2,4)],'r-','lineWidth',3)
 
 pic_num=ceil(max(size(img(:,:)))/5);
 foreground = {};
  

   


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img
global x_max
global y_max
global max_y
global max_x
global min_y
global min_x
global m
global n
global p
global vanishing_point
global FGVertex
global outFG
global foreobj
global test
global foreground
global background
global pic_num
hold off
x_max=floor(x_max);
y_max=floor(y_max);
max_y=floor(max_y);
max_x=floor(max_x);
min_y=floor(min_y);
min_x=floor(min_x);
vanishing_point=floor(vanishing_point);
box=[min_y,max_y,min_x,max_x];
mx=0;my=0;mz=0;rx=0;ry=0;rz=0;
geo=[mx,my,mz,rx,ry,rz];

 [out,test]=Tour_into_the_3d_picture(img,vanishing_point,box);
 f = figure;
 surface_3d(out)
 hold on
 if numel(foreground) ~= 0
      surfaceFG_3d(foreground,out,FGVertex,foreobj,test,pic_num);
 end
  cameratoolbar('NoReset')
tb = cameratoolbar(f);
 xlabel('x')
 ylabel('y')
 zlabel('z')
 view(0,-80)


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  h=imrect;



global img
poss=getPosition(h);
hold on
global poss1
global poss2
global poss3
global poss4
poss1=[poss(1),poss(2)]
%pos1=[pos(2),pos(1)]
poss2=[poss(1)+poss(3),poss(2)]
%pos2=[pos(2)+pos(4),pos(1)]
poss3=[poss(1)+poss(3),poss(2)+poss(4)]
%pos3=[pos(2),pos(1)+pos(3)]
poss4=[poss(1),poss(2)+poss(4)]
%pos4=[pos(2)+pos(4),pos(1)+pos(3)]
global vanishing_point
global min_y_fore
global max_y_fore
global min_x_fore
global max_x_fore
global estimatedVertex
global FGVertex
global outFG
global foreobj
global test
global foreground
global background
min_y_fore=poss(2);
max_y_fore=poss(2)+poss(4);
min_x_fore=poss(1);
max_x_fore=poss(1)+poss(3);
[foreground, img]= maskBackground(img, min_y_fore,max_y_fore,min_x_fore,max_x_fore);
[FGVertex,foreobj]  = foregroundobj(foreground,vanishing_point,estimatedVertex,min_y_fore,max_y_fore,min_x_fore,max_x_fore);

  



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


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
