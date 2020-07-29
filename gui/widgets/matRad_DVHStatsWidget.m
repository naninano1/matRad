classdef matRad_DVHStatsWidget < matRad_Widget
    
    properties
        SelectedCube='physicalDose';
    end
    
    events
        
    end
    
    methods
        function this = matRad_DVHStatsWidget(handleParent)
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
            
            p1 = uipanel(...
                'Parent',h88,...
                'ShadowColor',[0.501960784313725 0.501960784313725 0.501960784313725],...
                'BorderType','none',...
                'BackgroundColor',[0.501960784313725 0.501960784313725 0.501960784313725],...
                'Tag','uipanel1',...
                'Clipping','off',...
                'Position',[0.00451321727917473 0.51 0.99 0.5],...
                'FontName','Helvetica',...
                'FontSize',8,...
                'FontWeight','bold' );
            
            p2 = uipanel(...
                'Parent',h88,...
                'BorderType','none',...
                'BackgroundColor',[0.501960784313725 0.501960784313725 0.501960784313725],...
                'Tag','uipanel2',...
                'Clipping','off',...
                'Position',[0.00451321727917473 0.0 0.99 0.5],...
                'FontName','Helvetica',...
                'FontSize',8,...
                'FontWeight','bold');
            
            
            this.createHandles();
            
        end
    end
    
    methods
         function showDVH(this)
            handles=this.handles;
            matRad_DVHWidget(handles.uipanel1);
            matRad_StatisticsWidget(handles.uipanel2);
            
            this.handles=handles;
         end
        
    end
end