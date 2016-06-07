clear
clf
view(3);
set(gcf, 'Renderer', 'OpenGL');
axis equal
axis vis3d
axis([-1 1 -1 1 -1 1] * 2)
set(gca, 'CameraViewAngle', 2.64220455737653);
rotate3d on

light('Position', [-0.5 -3 2], 'Style', 'infinite');

tree = {  % root
        @shape.box { % parent link
            ':id', 'link1';
            ':scale', [0.8 0.1 0.1];
            'FaceVertexCData', [0 0.8 0.8];
            @shape.box { % child link
                ':id', 'link2';
                ':scale', [0.5 0.1 0.1];
                ':transform', { 'zrotate', -pi/4; 'yrotate', -pi/8; };
                'FaceVertexCData', [0.8 0.8 0];
            }
            @shape.prism {
                ':scale', [0.2 0.1 0.1];
                'ngon', 4;
            }
        }
        @shape.cylinder { % base cylinder
            ':id', 'base';
            ':scale', [0.3 0.5 0.5];
            ':transform', { 'yrotate', pi/2; };
            'FaceVertexCData', [0.8 0 0.8];
        }
    };

handles = plottreed(tree);
drawnow;
pause

set(gcf, 'PaperPositionMode', 'auto');

t = 0:0.0333:10;
X = pi/3 * [sin(t); cos(t)]';

tstart = tic;
for k=1:size(X,1)
    pause(t(k)-toc(tstart))
    modifytreed(handles.link1, ':transform', {'zrotate', X(k,1)});
    modifytreed(handles.link1, ':scale', [1 + X(k,2) / 2, 0.1, 0.1]);
    modifytreed(handles.link2, ':transform', {'zrotate', X(k,2), 'yrotate', -pi/8});
    drawnow;
    %print(sprintf('plot/img%03d.png',k),'-dpng','-r0')
end
toc(tstart)