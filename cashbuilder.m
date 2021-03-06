function varargout = cashbuilder(varargin)
% CASHBUILDER MATLAB code for cashbuilder.fig
%      CASHBUILDER, by itself, creates a new CASHBUILDER or raises the existing
%      singleton*.
%
%      H = CASHBUILDER returns the handle to a new CASHBUILDER or the handle to
%      the existing singleton*.
%
%      CASHBUILDER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CASHBUILDER.M with the given input arguments.
%
%      CASHBUILDER('Property','Value',...) creates a new CASHBUILDER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cashbuilder_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cashbuilder_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cashbuilder

% Last Modified by GUIDE v2.5 11-Jan-2018 16:18:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cashbuilder_OpeningFcn, ...
                   'gui_OutputFcn',  @cashbuilder_OutputFcn, ...
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


% --- Executes just before cashbuilder is made visible.
function cashbuilder_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cashbuilder (see VARARGIN)

% Choose default command line output for cashbuilder


handles.tot_time = 10;
handles.counter = handles.tot_time;
handles.output = hObject;
handles.questions_file = fopen('questions.txt','r');
handles.score = 0;
handles.started = false;


hhost = findobj('Tag','chasebackground');
if ~isempty(hhost)
hhosthandles = guidata(hhost);
handles.contnum = hhosthandles.contnum;
guidata(hhost,hhosthandles)
end


t = timer;
% t.StartFcn = {@updateclock,hObject};
t.TimerFcn = @(~,~)updateclock;
t.StopFcn = @(~,~)closegui;
t.Period = 1;
t.TasksToExecute = handles.tot_time;
t.ExecutionMode = 'fixedRate';
handles.timerh = t;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes cashbuilder wait for user response (see UIRESUME)
% uiwait(handles.Gui1);

% --- Outputs from this function are returned to the command line.
function varargout = cashbuilder_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
varargout{2} = handles.score;

if handles.started == true
    handles.text5.String = toc;
end
    
    
        
function updateclock
hObject = findobj('Tag','Gui1');
if ~isempty(hObject)
    handles = guidata(hObject);
    handles.text5.String = num2str(str2double(handles.text5.String)-1);
end

function closegui
hObject = findobj('Tag','Gui1');
if ~isempty(hObject)
    handles = guidata(hObject);
    head2head;
    h2hObj = findobj('Tag','h2h');
    if ~isempty(h2hObj)
        h2hHand = guidata(h2hObj);
        h2hHand.score=handles.score;
        h2hHand.step2.String = num2str(h2hHand.score+20000);
        h2hHand.step3.String = num2str(h2hHand.score);
        h2hHand.step4.String = num2str(max(h2hHand.score-2000,-1000));
        guidata(h2hObj,h2hHand);
    end


    close(hObject) 
end



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
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

time = toc;
if time>handles.tot_time && handles.started == true
    cashbuilder_OutputFcn(hObject, eventdata, handles)
end
    
handles.question
handles.answer
if strcmp(strip(handles.answer),handles.edit1.String)
    handles.score = handles.score + 1000;
    handles.text3.String = num2str(handles.score);
    guidata(hObject,handles);
    display_question(hObject);
    
    h = findobj('Tag','chasebackground');
    if ~isempty(h)
        chasedata = guidata(h);
%         chasedata.cashreward.String = ['�' num2str(handles.score)];
        switch handles.contnum
            case 1
                chasedata.cont1cb = handles.score;
            case 2
                chasedata.cont2cb = handles.score;
            case 3
                chasedata.cont3cb = handles.score;
            case 4
                chasedata.cont4cb = handles.score ;
        end
        guidata(h,chasedata);
%         hhost = findobj('Tag','chasebackground');
% if ~isempty(hhost)
%     hhosthandles= guidata(hhost);
%     set(hhosthandles,['cont' num2str(handles.contnum) 'cb'],handles.score)
% end
    end
    
else
    display_question(hObject);
end
handles = guidata(hObject);
guidata(hObject, handles);

function display_question(hObject)
handles = guidata(hObject);
handles.question = fgets(handles.questions_file);
handles.answer = fgets(handles.questions_file);
handles.text2.String = handles.question;
guidata(hObject, handles);




% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic;
if handles.started == false
    display_question(hObject);
    handles = guidata(hObject);
    handles.started = true;  
    handles.text5.String = num2str(handles.counter);
    start(handles.timerh);    
end




guidata(hObject,handles)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edit1.
function edit1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.edit1.String='';
guidata(hObject,handles)
