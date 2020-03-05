function varargout = display_data_gui(varargin)
% DISPLAY_DATA_GUI MATLAB code for display_data_gui.fig
%      DISPLAY_DATA_GUI, by itself, creates a new DISPLAY_DATA_GUI or raises the existing
%      singleton*.
%
%      H = DISPLAY_DATA_GUI returns the handle to a new DISPLAY_DATA_GUI or the handle to
%      the existing singleton*.
%
%      DISPLAY_DATA_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISPLAY_DATA_GUI.M with the given input arguments.
%
%      DISPLAY_DATA_GUI('Property','Value',...) creates a new DISPLAY_DATA_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before display_data_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to display_data_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help display_data_gui

% Last Modified by GUIDE v2.5 29-Feb-2020 17:29:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @display_data_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @display_data_gui_OutputFcn, ...
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


% --- Executes just before display_data_gui is made visible.
function display_data_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to display_data_gui (see VARARGIN)

if ~exist('ddg_build', 'dir')
    
       mkdir('ddg_build')
end



if isfile(strcat('.',filesep,'ddg_build',filesep,'last_dirpath.txt')) % TODO
     % File exists.
     disp('The ./ddb_build/last_dirpath.txt file is exists ');
     fid = fopen(strcat('.',filesep,'ddg_build',filesep,'last_dirpath.txt'));
     fullpath = fgetl(fid);
     handles.edit1.String = fullpath;
     
end



     dataObj = importdata(fullpath);
     
     if(isstruct(dataObj))
         
         fields = fieldnames(dataObj.data);
         handles.popupmenu1.String = fields;
         handles.popupmenu1.Visible = 'on';
         handles.table1.Data = getfield(dataObj.data,handles.popupmenu1.String{handles.popupmenu1.Value}); 
         
         cla;
         axes(handles.axes4); 
         colormap parula;
        % imagesc(handles.table1.Data(:,2:end));grid on;alpha(0.7);colorbar;
         imagesc(handles.table1.Data);grid on;alpha(0.7);colorbar;
         
     else
         
         cla;
         axes(handles.axes4); 
         colormap bone;
         clims = [0,1];
         imagesc(dataObj(:,2:end),clims);grid on;alpha(0.5);colorbar;
         
         handles.popupmenu1.String = 'None';
         handles.popupmenu1.Visible = 'off';
         handles.table1.Data = dataObj;
         
     end




% Choose default command line output for display_data_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes display_data_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = display_data_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)

fullpath = hObject.String ;

if (isfile(fullpath))

cd ddg_build;
fid = fopen( 'last_dirpath.txt', 'wt' );
fprintf(fid,fullpath);
fclose(fid);
cd ..

dataObj = importdata(fullpath);
     
     if(isstruct(dataObj))
         
         cla;
         axes(handles.axes4); 

         handles.table1.Data = getfield(dataObj.data,handles.popupmenu1.String{handles.popupmenu1.Value});
         %imagesc(handles.table1.Data(:,2:end));grid on;alpha(0.7);colorbar;
         imagesc(handles.table1.Data);grid on;alpha(0.7);colorbar;
         
     else
         
         cla;
         axes(handles.axes4); 
         colormap bone;
         clims = [0,1];
         imagesc(dataObj(:,2:end),clims);grid on;alpha(0.5);colorbar;
         handles.table1.Data = dataObj;
         
 
     end


else
    
    disp('The typed file does not exist.');
    
    fid = fopen(strcat('.',filesep,'ddg_build',filesep,'last_dirpath.txt'));
    fullpath = fgetl(fid);
    hObject.String = fullpath;
end


guidata(hObject,handles);


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


% --- Executes on button press in ChooseFIleOushbutton.
function ChooseFIleOushbutton_Callback(hObject, eventdata, handles)

    
     [file,path] = uigetfile({'*.xls';'*.xlsx';'*.xlsm';'*.xlsb';'*.xml'});
     fullpath = strcat(path,file);
     handles.edit1.String = fullpath;
     cd ddg_build;
     fid = fopen( 'last_dirpath.txt', 'wt' );
     fprintf(fid,fullpath);
     fclose(fid);
     cd ..
     
     dataObj = importdata(fullpath);
     
     if(isstruct(dataObj))
         
         cla;
         axes(handles.axes4); 
         colormap parula;

         %clims = [0,1];
         imagesc(dataObj.data.Munka1(:,2:end));grid on;alpha(0.7);colorbar;
         
         fields = fieldnames(dataObj.data);
         handles.popupmenu1.String = fields;
         handles.popupmenu1.Visible = 'on';
         handles.table1.Data = getfield(dataObj.data,handles.popupmenu1.String{handles.popupmenu1.Value}); 
         
     else
         
         cla;
         axes(handles.axes4); 
         colormap bone;
         clims = [0,1];
         imagesc(dataObj(:,2:end),clims);grid on;alpha(0.5);colorbar;
         
         handles.popupmenu1.String = 'None';
         handles.popupmenu1.Visible = 'off';
         handles.table1.Data = dataObj;
         
     end
     

guidata(hObject,handles);


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)


fullpath = handles.edit1.String;
dataObj = importdata(fullpath);

cla;
axes(handles.axes4); 
colormap parula;
%clims = [0,1];
handles.table1.Data = getfield(dataObj.data,hObject.String{hObject.Value});

imagesc(handles.table1.Data);grid on;alpha(0.7);colorbar;





guidata(hObject,handles);

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
