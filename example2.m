% Example 2: Quadrotor with dynamic structure generation using function_handle
clear
clf

%% Initialization
view(3);
set(gcf, 'Renderer', 'OpenGL');
axis equal
axis vis3d
axis([-1 1 -1 1 -1 1] * 3)
set(gca, 'CameraViewAngle', 2.64220455737653);
rotate3d on

light('Position', [-0.5 -3 2], 'Style', 'infinite');

%% TreeD Cell Structure Definition

% Define k-th rotor using function_handle
generate_rotor = @(k, x, y) {
    @shape.cylinder {
        ':id', ['motor' num2str(k)];
        ':scale', [0.15 0.3 0.3];
        ':transform', { 'translate', [x,y,0], 'yrotate', -pi/2, 'xrotate', 3*pi/4+pi/2*k };
        'FaceVertexCData', [0.3 0.3 0.3];
        @shape.cylinder {
            ':id', ['motoraxis' num2str(k)];
            ':scale', [0.15 0.1 0.1];
            'FaceVertexCData', [0.8 0.8 0.8];
            @shape.box {
                ':id', ['prop' num2str(k) '_1']
                ':scale', [0.02 0.6 0.1];
                ':transform', { 'translate', [-0.05 0.3 0], 'yrotate', pi/6 * (-1)^k };
            }
            @shape.box {
                ':id', ['prop' num2str(k) '_2']
                ':scale', [0.02 0.6 0.1];
                ':transform', { 'translate', [-0.05 -0.3 0], 'yrotate', -pi/6 * (-1)^k };
            }
        }
    }
};

% Print generated structure where k=1, x=1, y=1
printtreed(generate_rotor(1,1,1))

% Make a tree of rotors
tree_rotor = [
    generate_rotor(1, 1, 1);
    generate_rotor(2, -1, 1);
    generate_rotor(3, -1, -1);
    generate_rotor(4, 1, -1);
];

% Define k-th arm
generate_arm = @(k) {
    @shape.box {
        ':id', ['arm' num2str(k)];
        ':scale', [1.5 0.2 0.1];
        ':transform', { 'zrotate', pi/2*k-pi/4 };
        'FaceVertexCData', [0.5 0.5 0.5];
    }
};

% Make a tree of arms
tree_arm = [
    generate_arm(1);
    generate_arm(2);
    generate_arm(3);
    generate_arm(4);
];

% Make a main tree
tree = {
    % Dummy parent object to place 'bodybox', rotors, arms as siblings
    @shape.null {
        ':id', 'body';
        % Box at the center of the vehicle
        @shape.box {
            ':id', 'bodybox';
            ':scale', [0.2 0.5 0.5];
            ':transform', { 'translate', [0,0,-0.1], 'yrotate', -pi/2 };
        }
    }
};

%% Plot
tdhandles = plottreed(tree);
tdhandles_rotor = plottreed(tree_rotor, 'Parent', tdhandles.body); % Set 'body' as 'Parent'
tdhandles_arm = plottreed(tree_arm, 'Parent', tdhandles.body);