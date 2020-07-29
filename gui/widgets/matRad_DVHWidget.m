classdef matRad_DVHWidget < matRad_Widget
    
    properties
        SelectedCube='physicalDose';
    end
    
    events
        
    end
    
    methods
        function this = matRad_DVHWidget(handleParent)
            if nargin < 1
                handleParent = figure(...
                    'Units','characters',...
                    'Position',[170.4 45 80 30],...
                    'Visible','on',...
                    'Color',[0.501960784313725 0.501960784313725 0.501960784313725],...  'CloseRequestFcn',@(hObject,eventdata) figure1_CloseRequestFcn(this,hObject,eventdata),...
                    'IntegerHandle','off',...
                    'Colormap',[0 0 0.5625;0 0 0.625;0 0 0.6875;0 0 0.75;0 0 0.8125;0 0 0.875;0 0 0.9375;0 0 1;0 0.0625 1;0 0.125 1;0 0.1875 1;0 0.25 1;0 0.3125 1;0 0.375 1;0 0.4375 1;0 0.5 1;0 0.5625 1;0 0.625 1;0 0.6875 1;0 0.75 1;0 0.8125 1;0 0.875 1;0 0.9375 1;0 1 1;0.0625 1 1;0.125 1 0.9375;0.1875 1 0.875;0.25 1 0.8125;0.3125 1 0.75;0.375 1 0.6875;0.4375 1 0.625;0.5 1 0.5625;0.5625 1 0.5;0.625 1 0.4375;0.6875 1 0.375;0.75 1 0.3125;0.8125 1 0.25;0.875 1 0.1875;0.9375 1 0.125;1 1 0.0625;1 1 0;1 0.9375 0;1 0.875 0;1 0.8125 0;1 0.75 0;1 0.6875 0;1 0.625 0;1 0.5625 0;1 0.5 0;1 0.4375 0;1 0.375 0;1 0.3125 0;1 0.25 0;1 0.1875 0;1 0.125 0;1 0.0625 0;1 0 0;0.9375 0 0;0.875 0 0;0.8125 0 0;0.75 0 0;0.6875 0 0;0.625 0 0;0.5625 0 0],...
                    'MenuBar','none',...
                    'Name','MatRad DVH',...
                    'NumberTitle','off',...
                    'HandleVisibility','callback',...
                    'Tag','figure1',...
                    'PaperSize',[20.99999864 29.69999902]);
                
            end
            
            this = this@matRad_Widget(handleParent);   

            if evalin('base','exist(''resultGUI'')')
                this.showDVH();
            end
        end
        
        function this=initialize(this)
        end
        
        function this=update(this)
            if evalin('base','exist(''resultGUI'')')
                this.showDVH();
            end
        end
        
    end
    
    methods(Access = protected)
        function this = createLayout(this)
            h88 = this.widgetHandle;
            
%             h89 = axes(...
%                 'Parent',h88,...
%                 'XTick',[0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1],...
%                 'XTickLabel',{  '0'; '0.1'; '0.2'; '0.3'; '0.4'; '0.5'; '0.6'; '0.7'; '0.8'; '0.9'; '1' },...
%                 'YTick',[0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1],...
%                 'YTickLabel',{  '0'; '0.1'; '0.2'; '0.3'; '0.4'; '0.5'; '0.6'; '0.7'; '0.8'; '0.9'; '1' },...
%                 'Position',[0.0718390804597701 0.0354391371340524 0.902298850574712 0.929121725731895],...
%                  'SortMethod','childorder',...
%                  'Tag','axesFig'); 
%                 %'ButtonDownFcn',@(hObject,eventdata)axesFig_ButtonDownFcn(this,hObject,eventdata),...
%                 % 'FontSize',9.63,...  'FontName','CMU Serif',...
%             %'Colormap',[0 0 0.5625;0 0 0.625;0 0 0.6875;0 0 0.75;0 0 0.8125;0 0 0.875;0 0 0.9375;0 0 1;0 0.0625 1;0 0.125 1;0 0.1875 1;0 0.25 1;0 0.3125 1;0 0.375 1;0 0.4375 1;0 0.5 1;0 0.5625 1;0 0.625 1;0 0.6875 1;0 0.75 1;0 0.8125 1;0 0.875 1;0 0.9375 1;0 1 1;0.0625 1 1;0.125 1 0.9375;0.1875 1 0.875;0.25 1 0.8125;0.3125 1 0.75;0.375 1 0.6875;0.4375 1 0.625;0.5 1 0.5625;0.5625 1 0.5;0.625 1 0.4375;0.6875 1 0.375;0.75 1 0.3125;0.8125 1 0.25;0.875 1 0.1875;0.9375 1 0.125;1 1 0.0625;1 1 0;1 0.9375 0;1 0.875 0;1 0.8125 0;1 0.75 0;1 0.6875 0;1 0.625 0;1 0.5625 0;1 0.5 0;1 0.4375 0;1 0.375 0;1 0.3125 0;1 0.25 0;1 0.1875 0;1 0.125 0;1 0.0625 0;1 0 0;0.9375 0 0;0.875 0 0;0.8125 0 0;0.75 0 0;0.6875 0 0;0.625 0 0;0.5625 0 0],...
                
%             h90 = get(h89,'title');
%             
%             set(h90,...
%                 'Parent',h89,...
%                 'Units','data',...
%                 'FontUnits','points',...
%                 'Color',[0 0 0],...
%                 'Position',[0.500000554441759 1.00453467465753 0.5],...
%                 'PositionMode','auto',...
%                 'Interpreter','tex',...
%                 'Rotation',0,...
%                 'RotationMode','auto',...
%                 'FontName','Helvetica',...
%                 'FontSize',10.593,...
%                 'FontAngle','normal',...
%                 'FontWeight','normal',...
%                 'HorizontalAlignment','center',...
%                 'HorizontalAlignmentMode','auto',...
%                 'VerticalAlignment','bottom',...
%                 'VerticalAlignmentMode','auto',...
%                 'EdgeColor','none',...
%                 'LineStyle','-',...
%                 'LineWidth',0.5,...
%                 'BackgroundColor','none',...
%                 'Margin',2,...
%                 'Clipping','off',...
%                 'XLimInclude','on',...
%                 'YLimInclude','on',...
%                 'ZLimInclude','on',...
%                 'Visible','on',...
%                 'HandleVisibility','off',...
%                 'BusyAction','queue',...
%                 'Interruptible','on',...
%                 'HitTest','on',...
%                 'PickableParts','visible');
%             
%             h91 = get(h89,'xlabel');
%             
       
            this.createHandles();
            
        end
    end
    
    methods
         function showDVH(this)
            
            resultGUI = evalin('base','resultGUI');
            %Content = get(handles.popupDisplayOption,'String');
            
            %SelectedCube = Content{get(handles.popupDisplayOption,'Value')};
            
            pln = evalin('base','pln');
            resultGUI_SelectedCube.physicalDose = resultGUI.(this.SelectedCube);
            
            if ~strcmp(pln.propOpt.bioOptimization,'none')
                
                %check if one of the default fields is selected
                if sum(strcmp(this.SelectedCube,{'physicalDose','effect','RBE,','RBExDose','alpha','beta'})) > 0
                    resultGUI_SelectedCube.physicalDose = resultGUI.physicalDose;
                    resultGUI_SelectedCube.RBExDose     = resultGUI.RBExDose;
                else
                    Idx    = find(this.SelectedCube == '_');
                    SelectedSuffix = this.SelectedCube(Idx(1):end);
                    resultGUI_SelectedCube.physicalDose = resultGUI.(['physicalDose' SelectedSuffix]);
                    resultGUI_SelectedCube.RBExDose     = resultGUI.(['RBExDose' SelectedSuffix]);
                end
            end
            
            cst = evalin('base','cst');
            
            %matRad_indicatorWrapper(this.widgetHandle,cst,pln,resultGUI_SelectedCube);
            
            
            if isfield(resultGUI_SelectedCube,'RBExDose')
                doseCube = resultGUI_SelectedCube.RBExDose;
            else
                doseCube = resultGUI_SelectedCube.physicalDose;
            end
            
            dvh = matRad_calcDVH(cst,doseCube,'cum');
            
            matRad_showDVH(axes(this.widgetHandle),dvh,cst,pln);

         end
        
    end
end