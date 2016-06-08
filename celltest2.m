clear
clf

%% Initialization
view(3);
set(gcf, 'Renderer', 'OpenGL');
axis equal
axis vis3d
axis([-1 1 -1 1 -1 1] * 2)
set(gca, 'CameraViewAngle', 2.64220455737653);
rotate3d on

light('Position', [-0.5 -3 2], 'Style', 'infinite');

%% TreeD Cell Structure Definition
tree = {  % root
    @shape.box { % link1
        ':id', 'link1';
        ':scale', [0.8 0.1 0.1];
        'FaceVertexCData', [0 0.8 0.8];
        @shape.box { % link2
            ':id', 'link2';
            ':scale', [0.5 0.1 0.1];
            ':transform', { 'zrotate', -pi/4; 'yrotate', -pi/8; };
            'FaceVertexCData', [0.8 0.8 0];
            'FaceAlpha', 0.1;
        }
    }
    @shape.cylinder { % base cylinder
        ':id', 'base';
        ':scale', [0.3 0.5 0.5];
        ':transform', { 'yrotate', pi/2; };
        'FaceVertexCData', [0.8 0 0.8];
    }
};

%% Plot
tdhandles = plottreed(tree);
drawnow;

pause % hit any key to continue

%% Animation
t = 0:0.0333:10;
X = [sin(t); cos(t)]';

tstart = tic;
for k=1:size(X,1)
    pause(t(k)-toc(tstart))
    
    % Rotate link1 about its Z axis
    modifytreed(tdhandles.link1, ':transform', {'zrotate', X(k,1)});
    % Scale link1
    modifytreed(tdhandles.link1, ':scale', [0.8 + X(k,1) * 0.4, 0.1, 0.1]);
    
    % Rotate link2 about its Z and Y axis
    modifytreed(tdhandles.link2, ':transform', {'zrotate', X(k,2), 'yrotate', -pi/8});
    % Change the transparency of link2
    modifytreed(tdhandles.link2, 'FaceAlpha', 0.6 - X(k,1) * 0.4);
    
    drawnow;
end
toc(tstart)