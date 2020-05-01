classdef matRad_ViewerOptionsWidget < matRad_Widget
    
    properties
        viewerWidgetHandle;
        colormapLocked;
        windowPresets;
    end
    
    methods
        function this = matRad_ViewerOptionsWidget(handleParent,viewerWidgetHandle)
            if nargin < 1
                handleParent = figure(...
                    'Units','characters',...
                    'Position',[170 45 20 20],...
                    'Visible','on',...
                    'Color',[0.501960784313725 0.501960784313725 0.501960784313725],...
                    'IntegerHandle','off',...
                    'Colormap',[0 0 0.5625;0 0 0.625;0 0 0.6875;0 0 0.75;0 0 0.8125;0 0 0.875;0 0 0.9375;0 0 1;0 0.0625 1;0 0.125 1;0 0.1875 1;0 0.25 1;0 0.3125 1;0 0.375 1;0 0.4375 1;0 0.5 1;0 0.5625 1;0 0.625 1;0 0.6875 1;0 0.75 1;0 0.8125 1;0 0.875 1;0 0.9375 1;0 1 1;0.0625 1 1;0.125 1 0.9375;0.1875 1 0.875;0.25 1 0.8125;0.3125 1 0.75;0.375 1 0.6875;0.4375 1 0.625;0.5 1 0.5625;0.5625 1 0.5;0.625 1 0.4375;0.6875 1 0.375;0.75 1 0.3125;0.8125 1 0.25;0.875 1 0.1875;0.9375 1 0.125;1 1 0.0625;1 1 0;1 0.9375 0;1 0.875 0;1 0.8125 0;1 0.75 0;1 0.6875 0;1 0.625 0;1 0.5625 0;1 0.5 0;1 0.4375 0;1 0.375 0;1 0.3125 0;1 0.25 0;1 0.1875 0;1 0.125 0;1 0.0625 0;1 0 0;0.9375 0 0;0.875 0 0;0.8125 0 0;0.75 0 0;0.6875 0 0;0.625 0 0;0.5625 0 0],...
                    'MenuBar','none',...
                    'Name','MatRad Viewer Options',...
                    'NumberTitle','off',...
                    'HandleVisibility','callback',...
                    'Tag','figure1',...
                    'PaperSize',[20.99999864 29.69999902]);
                
            end
            this = this@matRad_Widget(handleParent);
            
            handles=this.handles;
            
            if evalin('base','exist(''ct'')') && isfield(evalin('base','ct'), 'cubeHU')
                cMapOptionsSelectList = {'None','CT (HU)','Result (i.e. dose)'};
            else
                cMapOptionsSelectList = {'None','CT (ED)','Result (i.e. dose)'};
            end
            
            if evalin('base','exist(''resultGUI'')')
                set(handles.popupmenu_chooseColorData,'String',cMapOptionsSelectList(1:3))
                set(handles.popupmenu_chooseColorData,'Value',3);
            elseif evalin('base','exist(''ct'')')
                set(handles.popupmenu_chooseColorData,'String',cMapOptionsSelectList(1:2))
                set(handles.popupmenu_chooseColorData,'Value',2);
            else %no data is loaded
                set(handles.popupmenu_chooseColorData,'String',cMapOptionsSelectList{1})
                set(handles.popupmenu_chooseColorData,'Value',1);
            end
            
            % setup ct window list
            % data and values from CERR https://github.com/adityaapte/CERR
            windowNames = {'Custom','Full','Abd/Med', 'Head', 'Liver', 'Lung', 'Spine', 'Vrt/Bone'};
            windowCenter = {NaN, NaN, -10, 45, 80, -500, 30, 400};
            windowWidth = {NaN, NaN, 330, 125, 305, 1500, 300, 1500};
            windowPresets = cell2struct([windowNames', windowCenter', windowWidth'], {'name', 'center', 'width'},2);
            
            
            this.windowPresets = windowPresets;
            
            selectionList = {windowPresets(:).name};
            set(handles.popupmenu_windowPreset,'String',selectionList(:));
            set(handles.popupmenu_windowPreset,'Value',1);
                        
            if nargin==2
                this.handles=handles;
                this.viewerWidgetHandle=viewerWidgetHandle;
            else
                 
                set(handles.popupmenu_chooseColorData,'Enable','off');
                set(handles.popupmenu_windowPreset,'Enable','off');
                set(handles.slider_windowWidth,'Enable','off');
                set(handles.slider_windowCenter,'Enable','off');
                set(handles.edit_windowWidth,'Enable','off');
                set(handles.edit_windowCenter,'Enable','off');
                set(handles.edit_windowRange,'Enable','off');
                set(handles.popupmenu_chooseColormap,'Enable','off');
                set(handles.checkbox_lockColormap,'Enable','off');
                set(handles.sliderOpacity,'Enable','off');
                set(handles.btnSetIsoDoseLevels,'Enable','off');
                
%                 % lock settings
%                 set(this.handles.checkbox_lockColormap,'Value', true);
%                 checkbox_lockColormap_Callback(this,this.handles.checkbox_lockColormap)
%                 % additionally disable these buttons
%                 set(this.handles.checkbox_lockColormap,'Enable','off');
%                 set(this.handles.sliderOpacity,'Enable','off');
%                 set(this.handles.btnSetIsoDoseLevels,'Enable','off');
            end
            this.handles=handles;
        end
        
        function this = initialize(this)
            
        end
        
        function this = update(this)
            this.UpdateColormapOptions();
        end
        
        function viewerWidgetHandle=get.viewerWidgetHandle(this)
            viewerWidgetHandle=this.viewerWidgetHandle;
        end
        
        function set.viewerWidgetHandle(this,value)
            handles=this.handles;
            if isvalid(value)
                this.viewerWidgetHandle=value;
                % enable all buttons 
                set(handles.popupmenu_chooseColorData,'Enable','on');
                set(handles.popupmenu_windowPreset,'Enable','on');
                set(handles.slider_windowWidth,'Enable','on');
                set(handles.slider_windowCenter,'Enable','on');
                set(handles.edit_windowWidth,'Enable','on');
                set(handles.edit_windowCenter,'Enable','on');
                set(handles.edit_windowRange,'Enable','on');
                set(handles.popupmenu_chooseColormap,'Enable','on');
                set(handles.checkbox_lockColormap,'Enable','on');
                set(handles.sliderOpacity,'Enable','on');
                set(handles.btnSetIsoDoseLevels,'Enable','on');
                
                %Set up the colormap selection box
                availableColormaps = matRad_getColormap();
                set(this.handles.popupmenu_chooseColormap,'String',availableColormaps);
                
                % get the default values from the viewer widget
                currentCtMapIndex   = find(strcmp(availableColormaps,this.viewerWidgetHandle.ctColorMap));
                currentDoseMapIndex = find(strcmp(availableColormaps,this.viewerWidgetHandle.doseColorMap));
                
                if evalin('base','exist(''resultGUI'')') % state 3
                    set(handles.popupmenu_chooseColormap,'Value',currentDoseMapIndex);
                else
                    set(handles.popupmenu_chooseColormap,'Value',currentCtMapIndex);
                end
%             if handles.State >= 1
%                 set(handles.popupmenu_chooseColormap,'Value',currentCtMapIndex);
%             end
%
%             if handles.State >= 3
%                 set(handles.popupmenu_chooseColormap,'Value',currentDoseMapIndex);
%             end
                
                UpdateColormapOptions(this);
                
            else
                % disable all buttons
                set(handles.popupmenu_chooseColorData,'Enable','off');
                set(handles.popupmenu_windowPreset,'Enable','off');
                set(handles.slider_windowWidth,'Enable','off');
                set(handles.slider_windowCenter,'Enable','off');
                set(handles.edit_windowWidth,'Enable','off');
                set(handles.edit_windowCenter,'Enable','off');
                set(handles.edit_windowRange,'Enable','off');
                set(handles.popupmenu_chooseColormap,'Enable','off');
                set(handles.checkbox_lockColormap,'Enable','off');
                set(handles.sliderOpacity,'Enable','off');
                set(handles.btnSetIsoDoseLevels,'Enable','off');
            end
            this.handles=handles;
        end
    end
    
    methods (Access = protected)
        function this = createLayout(this)
            h98 = this.widgetHandle;
            
            h84 = uicontrol(...
                'Parent',h98,...
                'Units','normalized',...
                'String','min value:',...
                'Style','text',...
                'HorizontalAlignment','left',...
                'Position',[0.05 0.9 1 0.05],...
                'BackgroundColor',[0.501960784313725 0.501960784313725 0.501960784313725],...
                'Children',[],...
                'Tag','txtMinVal',...
                'FontSize',9,...
                'FontWeight','bold' );
            
%             h85 = uicontrol(...
%                 'Parent',h98,...
%                 'Units','normalized',...
%                 'String','',...
%                 'Style','text',...
%                 'Position',[0.5 0.9 0.3 0.05],...
%                 'BackgroundColor',[0.501960784313725 0.501960784313725 0.501960784313725],...
%                 'Children',[],...
%                 'Tag','txtMinVal',...
%                 'FontSize',10,...
%                 'FontWeight','bold' );
            
            h116 = uicontrol(...
                'Parent',h98,...
                'Units','normalized',...
                'String','max value:',...
                'Style','text',...
                'HorizontalAlignment','left',...
                'Position',[0.05 0.82 1 0.05],...
                'BackgroundColor',[0.501960784313725 0.501960784313725 0.501960784313725],...
                'Children',[],...
                'Tag','txtMaxVal',...
                'FontSize',9,...
                'FontWeight','bold' );
            
%             h117 = uicontrol(...
%                 'Parent',h98,...
%                 'Units','normalized',...
%                 'String','',...
%                 'Style','text',...
%                 'Position',[0.5 0.82 0.3 0.05],...
%                 'BackgroundColor',[0.501960784313725 0.501960784313725 0.501960784313725],...
%                 'Children',[],...
%                 'Tag','txtMaxVal',...
%                 'FontSize',10,...
%                 'FontWeight','bold' );
            
            h85 = uicontrol(...
                'Parent',h98,...
                'Units','normalized',...
                'String','Set IsoDose Levels',...
                'Position',[0.05 0.73 0.85 0.06],...
                'BackgroundColor',[0.8 0.8 0.8],...
                'Callback',@(hObject,eventdata)btnSetIsoDoseLevels_Callback(this,hObject,eventdata),...ss
                'Children',[],...
                'Tag','btnSetIsoDoseLevels');
            
            h99 = uicontrol(...
                'Parent',h98,...
                'Units','normalized',...
                'HorizontalAlignment','left',...
                'String','Window Center:',...
                'BackgroundColor',[0.501960784313725 0.501960784313725 0.501960784313725],...
                'Style','text',...
                'Position',[0.0466666666666666 0.442461750109027 0.673333333333333 0.0559999999999998],...
                'Children',[],...
                'Tag','text_windowCenter' );
            
            h100 = uicontrol(...
                'Parent',h98,...
                'Units','normalized',...
                'HorizontalAlignment','left',...
                'String','Dose opacity:',...
                'BackgroundColor',[0.501960784313725 0.501960784313725 0.501960784313725],...
                'Style','text',...
                'Position',[0.0466666666666667 0.0506370831711431 0.847328244274809 0.0514285714285714],...
                'Children',[],...
                'Tag','textDoseOpacity' );
            
            h101 = uicontrol(...
                'Parent',h98,...
                'Units','normalized',...
                'String',{  'None'; 'CT (ED)'; 'Dose' },...
                'Style','popupmenu',...
                'Value',1,...
                'Position',[0.0486486486486487 0.593328859060403 0.940540540540541 0.10744966442953],...
                'BackgroundColor',[1 1 1],...
                'Callback',@(hObject,eventdata)popupmenu_chooseColorData_Callback(this,hObject,eventdata),...
                'Children',[],...
                'Tag','popupmenu_chooseColorData');
            
            h102 = uicontrol(...
                'Parent',h98,...
                'Units','normalized',...
                'SliderStep',[0.01 0.05],...
                'String','slider',...
                'Style','slider',...
                'Value',0.5,...
                'Position',[0.0432432432432432 0.39758389261745 0.697297297297297 0.0436912751677853],...
                'BackgroundColor',[0.9 0.9 0.9],...
                'Callback',@(hObject,eventdata)slider_windowCenter_Callback(this,hObject,eventdata),...
                'Children',[],...
                'Tag','slider_windowCenter');
            
            h103 = uicontrol(...
                'Parent',h98,...
                'Units','normalized',...
                'HorizontalAlignment','left',...
                'BackgroundColor',[0.501960784313725 0.501960784313725 0.501960784313725],...
                'String','Window Width:',...
                'Style','text',...
                'Position',[0.0466666666666667 0.345761302394105 0.673333333333333 0.050000000000001],...
                'Children',[],...
                'Tag','text_windowWidth');
            
            h104 = uicontrol(...
                'Parent',h98,...
                'Units','normalized',...
                'String','Choose Colormap...',...
                'Style','popupmenu',...
                'Value',1,...
                'Position',[0.0362903225806452 0.158843516266481 0.939516129032258 0.0644686648501362],...
                'BackgroundColor',[1 1 1],...
                'Callback',@(hObject,eventdata)popupmenu_chooseColormap_Callback(this,hObject,eventdata),...
                'Children',[],...
                'Tag','popupmenu_chooseColormap');
            
            h105 = uicontrol(...
                'Parent',h98,...
                'Units','normalized',...
                'HorizontalAlignment','left',...
                'String','Range:',...
                'BackgroundColor',[0.501960784313725 0.501960784313725 0.501960784313725],...
                'Style','text',...
                'Position',[0.0403225806451613 0.237807911050966 0.274193548387097 0.0508446866485015],...
                'Children',[],...
                'Tag','text_windowRange' );
            
            h106 = uicontrol(...
                'Parent',h98,...
                'Units','normalized',...
                'String','0 1',...
                'Style','edit',...
                'Position',[0.323863636363636 0.237807911050966 0.653409090909091 0.0557395498392283],...
                'BackgroundColor',[1 1 1],...
                'Callback',@(hObject,eventdata)edit_windowRange_Callback(this,hObject,eventdata),...
                'Children',[],...
                'Tag','edit_windowRange');
            
            h107 = uicontrol(...
                'Parent',h98,...
                'Units','normalized',...
                'String','0.5',...
                'Style','edit',...
                'Value',1,...
                'Position',[0.767567567567568 0.39758389261745 0.205405405405405 0.0604697986577181],...
                'BackgroundColor',[1 1 1],...
                'Callback',@(hObject,eventdata)edit_windowCenter_Callback(this,hObject,eventdata),...
                'Children',[],...
                'Tag','edit_windowCenter');
            
            h108 = uicontrol(...
                'Parent',h98,...
                'Units','normalized',...
                'String','1.0',...
                'Style','edit',...
                'Position',[0.772727272727273 0.298256759964609 0.204545454545455 0.0507395498392284],...
                'BackgroundColor',[1 1 1],...
                'Callback',@(hObject,eventdata)edit_windowWidth_Callback(this,hObject,eventdata),...
                'Children',[],...
                'Tag','edit_windowWidth');
            
            h109 = uicontrol(...
                'Parent',h98,...
                'Units','normalized',...
                'SliderStep',[0.01 0.05],...
                'String','slider',...
                'Style','slider',...
                'Value',0.6,...
                'Position',[0.147727272727273 0.0057234726688103 0.75 0.0446623794212219],...
                'BackgroundColor',[0.9 0.9 0.9],...
                'Callback',@(hObject,eventdata)sliderOpacity_Callback(this,hObject,eventdata),...
                'Children',[],...
                'Tag','sliderOpacity');
            
            h110 = uicontrol(...
                'Parent',h98,...
                'Units','normalized',...
                'HorizontalAlignment','left',...
                'String','0',...
                'BackgroundColor',[0.501960784313725 0.501960784313725 0.501960784313725],...
                'Style','text',...
                'Position',[0.0466666666666666 0.00599285798906697 0.0810810810810811 0.042463768115942],...
                'Children',[],...
                'Tag','txtDoseOpacity0Indicator',...
                'UserData',[],...
                'FontName','Helvetica');
            
            h111 = uicontrol(...
                'Parent',h98,...
                'Units','normalized',...
                'HorizontalAlignment','right',...
                'String','1',...
                'BackgroundColor',[0.501960784313725 0.501960784313725 0.501960784313725],...
                'Style','text',...
                'Position',[0.8963482566536 0.0064864051690258 0.0810810810810811 0.042463768115942],...
                'Children',[],...
                'Tag','txtDoseOpacity1Indicator' );
            
            h112 = uicontrol(...
                'Parent',h98,...
                'Units','normalized',...
                'HorizontalAlignment','left',...
                'String','Window Presets N/A',...
                'Style','text',...
                'BackgroundColor',[0.501960784313725 0.501960784313725 0.501960784313725],...
                'Position',[0.0540540540540541 0.570281879194631 0.797297297297297 0.0594697986577181],...
                'Children',[],...
                'Tag','text_windowPreset' );
            
            h113 = uicontrol(...
                'Parent',h98,...
                'Units','normalized',...
                'String',{  'Custom'; 'Full'; 'Abd/Med'; 'Head'; 'Liver'; 'Lung'; 'Spine'; 'Vrt/Bone' },...
                'Style','popupmenu',...
                'Value',1,...
                'Position',[0.0486486486486487 0.38889932885906 0.940540540541 0.17744966442953],...
                'BackgroundColor',[1 1 1],...
                'Callback',@(hObject,eventdata)popupmenu_windowPreset_Callback(this,hObject,eventdata),...
                'Children',[],...
                'Visible','on',... % Default should be off!
                'Tag','popupmenu_windowPreset');
            
            h114 = uicontrol(...
                'Parent',h98,...
                'Units','normalized',...
                'SliderStep',[0.01 0.05],...
                'String','slider',...
                'Style','slider',...
                'Value',1,...
                'Position',[0.0454545454545455 0.29740507995425 0.698863636363636 0.0446623794212219],...
                'BackgroundColor',[0.9 0.9 0.9],...
                'Callback',@(hObject,eventdata)slider_windowWidth_Callback(this, hObject, eventdata),...
                'Children',[],...
                'Tag','slider_windowWidth');
            
            h115 = uicontrol(...
                'Parent',h98,...
                'Units','normalized',...
                'String','Lock Settings',...
                'Style','checkbox',...
                'Position',[0.0486486486486487 0.111006711409396 0.940540540540541 0.0338926174496644],...
                'BackgroundColor',[0.502 0.502 0.502],...
                'Callback',@(hObject,eventdata)checkbox_lockColormap_Callback(this,hObject,eventdata),...
                'Children',[],...
                'Tag','checkbox_lockColormap' );
            
            this.createHandles();
        end
        
    end
    
    methods
        
        % H101
        function popupmenu_chooseColorData_Callback(this,~, ~)
            % hObject    handle to popupmenu_chooseColorData (see GCBO)
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            
            % Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_chooseColorData contents as cell array
            %        contents{get(hObject,'Value')} returns selected item from popupmenu_chooseColorData
            
            %             %index = get(hObject,'Value') - 1;
            %             handles = this.handles;
            %
            %             %handles.cBarChanged = true;
            %
            %             %guidata(hObject,handles);
            %             this.handles = handles;
            %             UpdatePlot(handles);
            
            this.viewerWidgetHandle.colorData=get(this.handles.popupmenu_chooseColorData,'Value');
        end
        
        % H102
        function slider_windowCenter_Callback(this, hObject, event)
            % hObject    handle to slider_windowCenter (see GCBO)
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            
            % Hints: get(hObject,'Value') returns position of slider
            %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
            handles = this.handles;
            
            newCenter      = get(hObject,'Value');
            range          = get(handles.slider_windowWidth,'Value');
            selectionIndex = get(handles.popupmenu_chooseColorData,'Value');
            
            this.viewerWidgetHandle.dispWindow{selectionIndex,1}  = [newCenter-range/2 newCenter+range/2];
            %handles.cBarChanged = true;
            
            this.handles = handles;
            this.viewerWidgetHandle.UpdatePlot();
            %UpdatePlot(handles);
            UpdateColormapOptions(this);
        end
        
        % H 104
        function popupmenu_chooseColormap_Callback(this,hObject, eventdata)
            % hObject    handle to popupmenu_chooseColormap (see GCBO)
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            
            % Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_chooseColormap contents as cell array
            %        contents{get(hObject,'Value')} returns selected item from popupmenu_chooseColormap
            
            handles = this.handles;
            
            index = get(hObject,'Value');
            strings = get(hObject,'String');
            
            selectionIndex = get(handles.popupmenu_chooseColorData,'Value');
            
            switch selectionIndex
                case 2
                    this.viewerWidgetHandle.ctColorMap = strings{index};
                case 3
                    this.viewerWidgetHandle.doseColorMap = strings{index};
                otherwise
            end
            
            %handles.cBarChanged = true;
            
            this.handles = handles;
            %UpdatePlot(handles);
        end
        
        % H106
        function edit_windowRange_Callback(this, hObject, eventdata)
            % hObject    handle to edit_windowRange (see GCBO)
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            
            % Hints: get(hObject,'String') returns contents of edit_windowRange as text
            %        str2double(get(hObject,'String')) returns contents of edit_windowRange as a double
            
            handles = this.handles;
            
            selectionIndex = get(handles.popupmenu_chooseColorData,'Value');
            vRange         = str2num(get(hObject,'String'));
            % matlab adds a zero in the beginning when text field is changed
            if numel(vRange) == 3
                vRange = vRange(vRange~=0);
            end
            
            this.viewerWidgetHandle.dispWindow{selectionIndex,1} = sort(vRange);
            %handles.cBarChanged = true;
            
            % compute new iso dose lines
            if selectionIndex > 2
%                 guidata(hObject,handles);
%                 handles = updateIsoDoseLineCache(handles);
                this.viewerWidgetHandle.updateIsoDoseLineCache();
            end
            
            this.handles = handles;
            %UpdatePlot(handles);
        end
        
        % H107
        function edit_windowCenter_Callback(this, hObject, eventdata)
            % hObject    handle to edit_windowCenter (see GCBO)
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            
            % Hints: get(hObject,'String') returns contents of edit_windowCenter as text
            %        str2double(get(hObject,'String')) returns contents of edit_windowCenter as a double
            
            handles = this.handles;
            
            newCenter           = str2double(get(hObject,'String'));
            width               = get(handles.slider_windowWidth,'Value');
            selectionIndex      = get(handles.popupmenu_chooseColorData,'Value');
            this.viewerWidgetHandle.dispWindow{selectionIndex,1}  = [newCenter-width/2 newCenter+width/2];
            %handles.cBarChanged = true;
            
            this.handles = handles;
            this.viewerWidgetHandle.UpdatePlot();
            % UpdatePlot(handles);
            UpdateColormapOptions(this);
        end
        
        % H108
        function edit_windowWidth_Callback(this, hObject, eventdata)
            % hObject    handle to edit_windowWidth (see GCBO)
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            
            % Hints: get(hObject,'String') returns contents of edit_windowWidth as text
            %        str2double(get(hObject,'String')) returns contents of edit_windowWidth as a double
            handles = this.handles;
            
            newWidth            = str2double(get(hObject,'String'));
            center              = get(handles.slider_windowCenter,'Value');
            selectionIndex      = get(handles.popupmenu_chooseColorData,'Value');
            this.viewerWidgetHandle.dispWindow{selectionIndex,1}  = [center-newWidth/2 center+newWidth/2];
            %handles.cBarChanged = true;
            
            this.handles = handles;
            this.viewerWidgetHandle.UpdatePlot();
            %UpdatePlot(handles);
            UpdateColormapOptions(this);
        end
        
        % H109
        function sliderOpacity_Callback(this,hObject, eventdata)
            % hObject    handle to sliderOpacity (see GCBO)
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            %handles = this.handles;
            
            this.viewerWidgetHandle.doseOpacity = get(hObject,'Value');
            
            %this.handles = handles;
            %UpdatePlot(handles);
            
            
        end
        
        % H113
        function popupmenu_windowPreset_Callback(this, hObject, event)
            % hObject    handle to popupmenu_windowPreset (see GCBO)
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            
            % Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_windowPreset contents as cell array
            %        contents{get(hObject,'Value')} returns selected item from popupmenu_windowPreset
            handles = this.handles;
            
            selectionIndexCube      = 2; % working on ct only
            selectionIndexWindow    = get(handles.popupmenu_windowPreset,'Value');
            newCenter               = this.windowPresets(selectionIndexWindow).center;
            newWidth                = this.windowPresets(selectionIndexWindow).width;
            
            this.viewerWidgetHandle.dispWindow{selectionIndexCube,1}  = [newCenter - newWidth/2 newCenter + newWidth/2];
            %handles.cBarChanged = true;
            this.handles = handles;
            %UpdatePlot(handles);
            this.viewerWidgetHandle.UpdatePlot();
            UpdateColormapOptions(this);
        end
        
        % H114
        function slider_windowWidth_Callback(this,hObject, eventdata)
            % hObject    handle to slider_windowWidth (see GCBO)
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            
            % Hints: get(hObject,'Value') returns position of slider
            %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
            
            handles = this.handles;
            newWidth = get(hObject,'Value');
            center   = get(handles.slider_windowCenter,'Value');
            selectionIndex = get(handles.popupmenu_chooseColorData,'Value');
            this.viewerWidgetHandle.dispWindow{selectionIndex,1}  = [center-newWidth/2 center+newWidth/2];
            %handles.cBarChanged = true;
            
            this.handles = handles;
            this.viewerWidgetHandle.UpdatePlot();
            %UpdatePlot(handles);
            UpdateColormapOptions(this);
        end
        
        % H115 Callback
        function checkbox_lockColormap_Callback(this, hObject, ~)
            % hObject    handle to checkbox_lockColormap (see GCBO)
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            
            % Hint: get(hObject,'Value') returns toggle state of checkbox_lockColormap
            
            handles = this.handles;
            this.colormapLocked = get(hObject,'Value');
            
            if this.colormapLocked
                state = 'Off'; %'Inactive';
            else
                state = 'On';
            end
            
            set(handles.popupmenu_chooseColorData,'Enable',state);
            set(handles.popupmenu_windowPreset,'Enable',state);
            set(handles.slider_windowWidth,'Enable',state);
            set(handles.slider_windowCenter,'Enable',state);
            set(handles.edit_windowWidth,'Enable',state);
            set(handles.edit_windowCenter,'Enable',state);
            set(handles.edit_windowRange,'Enable',state);
            set(handles.popupmenu_chooseColormap,'Enable',state);
            
            this.handles = handles;
        end
        
        % button: set iso dose levels
        function btnSetIsoDoseLevels_Callback(this,hObject, eventdata)
            handles = this.handles;
            prompt = {['Enter iso dose levels in [Gy]. Enter space-separated numbers, e.g. 1.5 2 3 4.98. Enter 0 to use default values']};
            if isequal(this.viewerWidgetHandle.IsoDose_Levels,0) || ~isvector(this.viewerWidgetHandle.IsoDose_Levels) || any(~isnumeric(this.viewerWidgetHandle.IsoDose_Levels)) || any(isnan(this.viewerWidgetHandle.IsoDose_Levels))
                defaultLine = {'1 2 3 '};
            else
                if isrow(this.viewerWidgetHandle.IsoDose_Levels)
                    defaultLine = cellstr(num2str(this.viewerWidgetHandle.IsoDose_Levels,'%.2g '));
                else
                    defaultLine = cellstr(num2str(this.viewerWidgetHandle.IsoDose_Levels','%.2g '));
                end
            end
            
            try
                Input = inputdlg(prompt,'Set iso dose levels ', [1 70],defaultLine);
                if ~isempty(Input)
                    this.viewerWidgetHandle.IsoDose_Levels = (sort(str2num(Input{1})));
                    if length(this.viewerWidgetHandle.IsoDose_Levels) == 1 && (this.viewerWidgetHandle.IsoDose_Levels(1) ~= 0)
                        this.viewerWidgetHandle.IsoDose_Levels = [this.viewerWidgetHandle.IsoDose_Levels this.viewerWidgetHandle.IsoDose_Levels];
                    end
                    %handles.IsoDose.NewIsoDoseFlag = true;
                end
            catch
                warning('Couldnt parse iso dose levels - using default values');
                this.viewerWidgetHandle.IsoDose_Levels = 0;
            end
            this.handles = handles;
            %handles = updateIsoDoseLineCache(handles);
            %this.viewerWidgetHandle.NewIsoDoseFlag = false;
            %UpdatePlot(handles);
        end
        %% Callbacks & Functions for color setting
        function UpdateColormapOptions(this)
            handles=this.handles;
            if isfield(handles,'colormapLocked') && handles.colormapLocked
                return;
            end
            
            
            selectionIndex = get(handles.popupmenu_chooseColorData,'Value');
            
            if ~isempty(this.viewerWidgetHandle.dispWindow{selectionIndex,2})
                set(handles.txtMinVal,'String',['min value: ' num2str(this.viewerWidgetHandle.dispWindow{selectionIndex,2}(1,1))]);
                set(handles.txtMaxVal,'String',['max value: ' num2str(this.viewerWidgetHandle.dispWindow{selectionIndex,2}(1,2))]);
            end
            cMapSelectionIndex = get(handles.popupmenu_chooseColormap,'Value');
            cMapStrings = get(handles.popupmenu_chooseColormap,'String');
            
            
            
%             if selectionIndex > 1
%                 set(handles.uitoggletool8,'State','on');
%             else
%                 set(handles.uitoggletool8,'State','off');
%             end
            
            try
                if selectionIndex == 2
                    ct = evalin('base','ct');
                    currentMap = this.viewerWidgetHandle.ctColorMap;
                    window = this.viewerWidgetHandle.dispWindow{selectionIndex,1};
                    if isfield(ct, 'cube')
                        minMax = [min(ct.cube{1}(:)) max(ct.cube{1}(:))];
                    else
                        minMax = [min(ct.cubeHU{1}(:)) max(ct.cubeHU{1}(:))];
                    end
                    % adjust value for custom window to current
                    this.windowPresets(1).width = max(window) - min(window);
                    this.windowPresets(1).center = mean(window);
                    % update full window information
                    this.windowPresets(2).width = minMax(2) - minMax(1);
                    this.windowPresets(2).center = mean(minMax);
                elseif selectionIndex == 3
                    result = evalin('base','resultGUI');
                    dose = result.(this.viewerWidgetHandle.SelectedDisplayOption);
                    currentMap = this.viewerWidgetHandle.doseColorMap;
                    minMax = [min(dose(:)) max(dose(:))];
                    window = this.viewerWidgetHandle.dispWindow{selectionIndex,1};
                else
                    window = [0 1];
                    minMax = window;
                    currentMap = 'bone';
                end
            catch
                window = [0 1];
                minMax = window;
                currentMap = 'bone';
            end
            
            valueRange = minMax(2) - minMax(1);
            
            windowWidth = window(2) - window(1);
            windowCenter = mean(window);
            
            %This are some arbritrary settings to configure the sliders
            sliderCenterMinMax = [minMax(1)-valueRange/2 minMax(2)+valueRange/2];
            sliderWidthMinMax = [0 valueRange*2];
            
            %if we have selected a value outside this range, we adapt the slider
            %windows
            if windowCenter < sliderCenterMinMax(1)
                sliderCenterMinMax(1) = windowCenter;
            end
            if windowCenter > sliderCenterMinMax(2)
                sliderCenterMinMax(2) = windowCenter;
            end
            if windowWidth < sliderWidthMinMax(1)
                sliderWidthMinMax(1) = windowWidth;
            end
            if windowCenter > sliderCenterMinMax(2)
                sliderWidthMinMax(2) = windowWidth;
            end
            
            
            set(handles.edit_windowCenter,'String',num2str(windowCenter,3));
            set(handles.edit_windowWidth,'String',num2str(windowWidth,3));
            set(handles.edit_windowRange,'String',num2str(window,4));
            set(handles.slider_windowCenter,'Min',sliderCenterMinMax(1),'Max',sliderCenterMinMax(2),'Value',windowCenter);
            set(handles.slider_windowWidth,'Min',sliderWidthMinMax(1),'Max',sliderWidthMinMax(2),'Value',windowWidth);
            
            cMapPopupIndex = find(strcmp(currentMap,cMapStrings));
            set(handles.popupmenu_chooseColormap,'Value',cMapPopupIndex);
            this.handles=handles;
        end
    end
    
end

