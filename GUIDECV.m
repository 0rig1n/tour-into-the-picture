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
set(hObject,'toolbar','figure') %��ʾ������
global img
% Update handles structure
handles.minx =0;
handles.miny =0;
handles.maxx =0;
handles.maxy =0;
guidata(hObject, handles);

% UIWAIT makes GUIDECV wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUIDECV_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.axes3,'visible','off'); 
ax2=axes('units','normalized','pos',[0.7 0.7 0.3 0.3]); % axes ����������
uistack(ax2,'top');  % �� UI �������ͼ�����������
ii=imread('2.png');
image(ii);
colormap gray  %�鿴�����õ�ǰ��ɫͼ
set(ax2,'handlevisibility','off','visible','off');

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
% �ж��ļ��Ƿ�Ϊ�գ�Ҳ���Բ������������ֱ�Ӷ���ͼƬҲ���Ե�
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

axes(handles.axes3); %ָ����Ҫ��յ�����
cla reset;
set(handles.axes3,'visible','off'); 


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%��ȡ֮ǰ������������
axes3 = gca;%��ȡ��ǰ��������
%xlim = get(axes3, 'xlim');
%ylim = get(axes3, 'ylim');
%������Ҫ��ʾ�������ͼ������imshow(img)
%set(axes3, 'xlim', xlim);%�ָ�֮ǰ������������
%set(axes3, 'ylim', ylim);
%k=waitforbuttonpress;%�ȴ���갴��
       %point1=get(gca,'Currentpoint');%��갴����
       %finalRect = rbbox; %
      % point2=get(gca,'Currentpoint');%����ɿ���
       %point1=point1(1,1:2);%��ȡ��������
       %point2=point2(1,1:2);
       %p1=min(floor(point1),floor(point2));%����λ��
       %p2=max(floor(point1),floor(point2));
       %offset=abs(floor(point1)-floor(point2));% offset(1)��ʾ��offset(2)��ʾ��
       %x = [p1(1) p1(1)+offset(1) p1(1)+offset(1) p1(1) p1(1)];
      % y = [p1(2) p1(2) p1(2)+offset(2) p1(2)+offset(2) p1(2)];
    

   h=imrect;%�����ʮ�֣�����ѡȡ����Ȥ����


%ͼ�оͻ���ֿ����϶��Լ��ı��С�ľ��ο�ѡ��λ�ú�

pos=getPosition(h);%pos���ĸ�ֵ���ֱ��Ǿ��ο�����Ͻǵ������ x y �� ��� ��Ⱥ͸߶�[0,0,0,0],
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
 min_y=floor(min_y)
 min_x=floor(min_x)
 max_y=floor(max_y)
 max_x=floor(max_x)
handles.minx=min_x;
handles.miny=min_y;
handles.maxx=max_x;
handles.maxy=max_y;





%global min_y
%global min_x
%global max_y
%global max_x
 

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 %h=imrect;%�����ʮ�֣�����ѡȡ����Ȥ����
[x,y] = ginput(1);

hold on
a=min(x);
b=min(y);%��ȡ�������1������������꣬x���������������y��������������
a=floor(a)
b=floor(b)
T=[a,b]
plot(a,b,'bo')
global pos1
global pos2
global pos3
global pos4
%line(T,pos1,'Color','red','LineStyle','--');
%line(T,pos2,'Color','red','LineStyle','--');
%line(T,pos3,'Color','red','LineStyle','--');
%line(T,pos4,'Color','red','LineStyle','--');

global max_y
global max_x
global min_y
global min_x

%min_x= handles.minx;
%min_y= handles.miny;
%max_x= handles.maxx;
%max_y= handles.maxy;
global img
 [m,n,p]=size(img)
    x_max = n
    y_max = m


    %image_name="sagrada_familia.png"
   % img=imread(image_name);
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

 

  

  

  


   

  
 


  
  

   