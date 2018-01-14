   function varargout = head2head(varargin)
% head2head MATLAB code for head2head.fig
%      head2head, by itself, creates a new head2head or raises the existing
%      singleton*.
%
%      H = head2head returns the handle to a new head2head or the handle to
%      the existing singleton*.
%
%      head2head('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in head2head.M with the given input arguments.
%
%      head2head('Property','Value',...) creates a new head2head or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before head2head_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to head2head_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help head2head

% Last Modified by GUIDE v2.5 14-Jan-2018 10:33:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @head2head_OpeningFcn, ...
                   'gui_OutputFcn',  @head2head_OutputFcn, ...
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


% --- Executes just before head2head is made visible.
function head2head_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA
% varargin   command line arguments to head2head (see VARARGIN)

% Choose default command line output for head2head
handles.Ccurrent=0;
handles.qtime = 5;
t = timer;
t.StartFcn = @(~,~)startclock;
t.TimerFcn = @(~,~)updateclock;
t.StopFcn = @(~,~)timeup;
t.Period = 1;
handles.qtime = handles.qtime+1;
t.TasksToExecute = handles.qtime;
t.ExecutionMode = 'fixedRate';
handles.timerh = t;


% h = findobj('Tag','chasebackground');
%     if ~isempty(h)
%         handchase = guidata(h);
%         handles.score = handchase.score;
%     else
%         handles.score = 5000;
%     end
handles.score = 0;
handles.output = hObject;
handles.step2.String = num2str(handles.score+20000);
handles.step3.String = num2str(handles.score);
handles.step4.String = num2str(max(handles.score-2000,-1000));
set(handles.pushbutton1,'Enable','off')
set(handles.pushbutton2,'Enable','off')
set(handles.pushbutton3,'Enable','off')
handles.questions_file = fopen('questions2.txt','r');
handles.started = false;
% Update handles structure




guidata(hObject, handles);

% UIWAIT makes head2head wait for user response (see UIRESUME)
% uiwait(handles.h2h);



% --- Outputs from this function are returned to the command line.
function varargout = head2head_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure



varargout{1} = handles.output;



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



% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
set(handles.pushbutton1,'Enable','off')
set(handles.pushbutton2,'Enable','off')
set(handles.pushbutton3,'Enable','off')
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
if strcmp(handles.pushbutton1.String{1},handles.correctanswer{1})
%     msgbox('right')
    handles = usrmoveup(hObject);
    

else
   stop(handles.timerh);
   uiwait( msgbox('wrong'))
    
end
catch
    1
end
handles = chrmoveup(hObject);



guidata(hObject, handles);




 
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
set(handles.pushbutton1,'Enable','off')
set(handles.pushbutton2,'Enable','off')
set(handles.pushbutton3,'Enable','off')
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
if strcmp(handles.pushbutton2.String{1},handles.correctanswer{1})
%     msgbox('right')
    handles = usrmoveup(hObject);
    

else
    stop(handles.timerh);
    uiwait(msgbox('wrong'))
%     
end
catch
    1
end
handles = chrmoveup(hObject);
guidata(hObject, handles);



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
set(handles.pushbutton1,'Enable','off')
set(handles.pushbutton2,'Enable','off')
set(handles.pushbutton3,'Enable','off')
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
if strcmp(handles.pushbutton3.String{1},handles.correctanswer{1})
%     msgbox('right')
    handles = usrmoveup(hObject);
      
else
    stop(handles.timerh);
    uiwait(msgbox('wrong'))
end
catch
    1
end
handles = chrmoveup(hObject);

guidata(hObject, handles);
   

function handles = usrmoveup(hObject)
handles = guidata(hObject);
h = findobj('Tag',['step' num2str(handles.current)]);
h.BackgroundColor = [0 1 1];
h.String='';
handles.current = handles.current+1;

if handles.current > 7
        hhost = findobj('Tag','chasebackground');
        if ~isempty(hhost)
            hhosthand = guidata(hhost);
            hhosthand.score = hhosthand.score + handles.score;
            hhosthand.cashreward.String = ['£' num2str(hhosthand.score)];
            guidata(hhost,hhosthand);
        end
        msgbox('Contestant Won');
        hclient = findobj('Tag','h2h');
        if ~isempty(hclient)
            close(hclient);
        end
end


guidata(hObject,handles)
h = findobj('Tag',['step' num2str(handles.current)]);
h.BackgroundColor = [0 1 0];
h.String = handles.score;



guidata(hObject,handles);


function handles = chrmoveup(hObject)
handles = guidata(hObject);
stop(handles.timerh);

if randi([0,1]) == 1
    h = findobj('Tag',['step' num2str(handles.Ccurrent)]);
    if ~isempty(h)
    h.BackgroundColor = [0 1 1];
    h.String='';
    end
    handles.Ccurrent = handles.Ccurrent+1;

    h = findobj('Tag',['step' num2str(handles.Ccurrent)]);
    if ~isempty(h)
    h.BackgroundColor = [1 0 0];
    h.String='Chaser';
    if handles.Ccurrent==handles.current
        hhost = findobj('Tag','chasebackground');
        if ~isempty(hhost)
            hhosthand = guidata(hhost);
            switch hhosthand.contnum
                case 1
                    hhosthand.contestant1.Visible = 'off';
                    hhosthand.status(1) = 0;
                case 2
                    hhosthand.contestant2.Visible = 'off';
                    hhosthand.status(2) = 0;
                case 3
                    hhosthand.contestant3.Visible = 'off';
                    hhosthand.status(3) = 0;
                case 4
                    hhosthand.contestant4.Visible = 'off';
                    hhosthand.status(4) = 0;
            end 
            hhosthand.cashreward.String = ['£' num2str(hhosthand.score)];
            guidata(hhost,hhosthand);
        end
        msgbox('Chaser Won');
        h.String = handles.score;
        


        hclient = findobj('Tag','h2h');
        if ~isempty(hclient)
            close(hclient);
        end
        


    end

    end
    set(handles.nextq,'Enable','on')
end
guidata(hObject,handles);
    



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


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

   


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over step3.
function step3_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to step3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.started == false
    handles.step3.BackgroundColor=[0 1 0];
    handles.score = str2double(handles.step3.String);
    handles.started = true;
    handles.current = 3;
    handles.step2.String = '';
    handles.step4.String = '';
    guidata(hObject,handles)
    handles = displayquestion(hObject);
end
guidata(hObject,handles);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over step2.
function step2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to step2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.started == false
    handles.step2.BackgroundColor=[0 1 0];
    handles.score = str2double(handles.step2.String);
    handles.started = true;
    handles.current = 2;
    handles.step3.String = '';
    handles.step4.String = '';
    guidata(hObject,handles)
    handles = displayquestion(hObject);
end
guidata(hObject,handles);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over step4.
function step4_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to step4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.started == false
    handles.step4.BackgroundColor=[0 1 0];
    handles.score = str2double(handles.step4.String);
    handles.started = true;
    handles.current = 4;
    handles.step2.String = '';
    handles.step3.String = '';
    guidata(hObject,handles)
    handles = displayquestion(hObject);
end
guidata(hObject,handles);


function handles = displayquestion(hObject)
% hObject = findobj('Tag','h2h');
handles = guidata(hObject);
set(handles.nextq,'Enable','off')
handles.question = strtrim(fgets(handles.questions_file));
handles.answer = strtrim(fgets(handles.questions_file));
options = strsplit(strtrim(handles.answer),',');
handles.correctanswer = options(1);
order = randperm(3);
handles.edit1.String = handles.question;
handles.pushbutton1.String = options(order(1));
handles.pushbutton2.String = options(order(2));
handles.pushbutton3.String = options(order(3));
set(handles.pushbutton1,'Enable','on')
set(handles.pushbutton2,'Enable','on')
set(handles.pushbutton3,'Enable','on')
start(handles.timerh);


function startclock
hObject = findobj('Tag','h2h');
if ~isempty(hObject)
    handles=guidata(hObject);
    handles.text9.String = num2str(handles.qtime);
    guidata(hObject,handles);
end

function updateclock
hObject = findobj('Tag','h2h');
if ~isempty(hObject)
    handles = guidata(hObject);
    handles.text9.String
    handles.text9.String = num2str(str2double(handles.text9.String)-1);
    guidata(hObject,handles);
end

function timeup
hObject = findobj('Tag','h2h');
if ~isempty(hObject)
%     handles = displayquestion(hObject);

    handles = guidata(hObject);
    set(handles.pushbutton1,'Enable','off')
    set(handles.pushbutton2,'Enable','off')
    set(handles.pushbutton3,'Enable','off')
    set(handles.nextq,'Enable','on')
    
    handles = chrmoveup(hObject);
    


    guidata(hObject,handles);
end


% --- Executes on button press in nextq.
function nextq_Callback(hObject, eventdata, handles)
% hObject    handle to nextq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = displayquestion(hObject);
guidata(hObject,handles);
