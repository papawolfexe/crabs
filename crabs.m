function crabs()
    % Load background music
    [y, Fs] = audioread('backgroundMusic.wav');
    player = audioplayer(y, Fs);
    play(player);  % Start playing the music

    % Load sting sound effect
    [stingY, stingFs] = audioread('stingSoundEffect.wav');
    stingPlayer = audioplayer(stingY, stingFs);

    % Load crab caught sound effect
    [crabCaughtY, crabCaughtFs] = audioread('crabCaughtSoundEffect.wav');
    crabCaughtPlayer = audioplayer(crabCaughtY, crabCaughtFs);

    playGame = 1;
    while (playGame)
        % Draw start screen and get level
        level = drawStartScreen("MainTitleScreen.png");
        numCrabs = level;
        numJelly = level; % Number of jellyfish is set to the level number

        numGraphicsPerCrab = 10;
        numGraphicsPerJelly = 12;

        % Initialize command, map dimensions, and draw map
        cmd = "null";
        [mapHeight, mapWidth] = drawMap("BGImage.png");

        % Initialize captain location, heading, size, health, and crabs caught
        xCapt = 1000;
        yCapt = 500;
        thetaCapt = -pi/2;
        sizeCapt = 50;
        healthCapt = 100; % Captain's health
        crabsCaught = 0;

        % Initialize crab location, heading, and size
        xCrab = rand(1, numCrabs) * mapWidth;
        yCrab = 3 * mapHeight / 4 + rand(1, numCrabs) * mapHeight / 4;
        thetaCrab = ones(1, numCrabs) * (-pi/2);
        sizeCrab = 50;
        isCrabCaught = zeros(1, numCrabs); % Track whether each crab is caught

        % Initialize jellyfish with random locations in the ocean
        xJelly = rand(1, numJelly) * mapWidth;
        yJelly = rand(1, numJelly) * mapHeight;
        thetaJelly = ones(1, numJelly) * (-pi / 2);
        sizeJelly = 25; % Size of jellyfish
        jellySting = 2; % Damage from jellyfish sting

        % Draw initial captain, crabs, and jellyfish
        [captGraphics, xNet, yNet] = drawCapt(xCapt, yCapt, thetaCapt, sizeCapt);
        crabGraphics = zeros(numGraphicsPerCrab, numCrabs); % Adjust numGraphicsPerCrab as needed
        for k = 1:numCrabs
            crabGraphics(:, k) = drawCrab(xCrab(k), yCrab(k), thetaCrab(k), sizeCrab);
        endfor
        jellyGraphics = zeros(numGraphicsPerJelly, numJelly); % Adjust numGraphicsPerJelly as needed
        for k = 1:numJelly
            jellyGraphics(:, k) = drawJelly(xJelly(k), yJelly(k), thetaJelly(k), sizeJelly);
        endfor

        % Print health status and crabs caught
        healthLoc = [100, 100];
        crabsCaughtLoc = [100, 175];
        healthStatus = text(healthLoc(1), healthLoc(2), strcat('Health = ', num2str(healthCapt)), 'FontSize', 12, 'Color', 'red');
        crabsCaughtStatus = text(crabsCaughtLoc(1), crabsCaughtLoc(2), strcat('Crabs Caught = ', num2str(crabsCaught)), 'FontSize', 12, 'Color', 'red');

        % Main game loop
        while (1)
            cmd = kbhit(1); % Read the keyboard

            % Move and redraw jellyfish
            for k = 1:numJelly
                for i = 1:length(jellyGraphics(:, k))
                    delete(jellyGraphics(i, k));
                endfor
                [xJelly(k), yJelly(k), thetaJelly(k)] = moveJelly(level, xJelly(k), yJelly(k), thetaJelly(k), sizeJelly, mapHeight, mapWidth);
                jellyGraphics(:, k) = drawJelly(xJelly(k), yJelly(k), thetaJelly(k), sizeJelly);
            endfor

            % Exit game if 'Q' is pressed
            if (cmd == 'Q')
                break;
            endif

            % Captain movement logic
            if (cmd == "w" || cmd == "a" || cmd == "d")
                % Erase old captain
                for i = 1:length(captGraphics)
                    set(captGraphics(i), 'Visible', 'off');
                endfor

                % Move captain
                [xCapt, yCapt, thetaCapt] = moveCapt(cmd, xCapt, yCapt, thetaCapt, sizeCapt, mapHeight, mapWidth);

                % Redraw captain
                [captGraphics, xNet, yNet] = drawCapt(xCapt, yCapt, thetaCapt, sizeCapt);
            endif

            % Jellyfish sting logic
            for k = 1:numJelly
                if (getDist(xJelly(k), yJelly(k), xCapt, yCapt) < 3 * sizeCapt)
                    healthCapt = healthCapt - jellySting;
                    play(stingPlayer);  % Play sting sound effect
                endif
            endfor

            % Crab catching and respawning logic
            for k = 1:numCrabs
                if (!isCrabCaught(k) && getDist(xNet, yNet, xCrab(k), yCrab(k)) < 2 * sizeCapt)
                    crabsCaught = crabsCaught + 1;
                    isCrabCaught(k) = 1;
                    play(crabCaughtPlayer);  % Play crab caught sound effect

                    % Erase old crab
                    for i = 1:length(crabGraphics(:, k))
                        delete(crabGraphics(i, k));
                    endfor

                    % Respawn crab at a new random location
                    xCrab(k) = rand * mapWidth;
                    yCrab(k) = 3 * mapHeight / 4 + rand * mapHeight / 4;
                    thetaCrab(k) = -pi/2;
                    crabGraphics(:, k) = drawCrab(xCrab(k), yCrab(k), thetaCrab(k), sizeCrab);

                    % Reset the isCrabCaught flag for the respawned crab
                    isCrabCaught(k) = 0;
                endif
            endfor

            % Update health and crabs caught status
            set(healthStatus, 'String', strcat('Health = ', num2str(healthCapt)));
            set(crabsCaughtStatus, 'String', strcat('Crabs Caught = ', num2str(crabsCaught)));

            fflush(stdout);
            pause(0.01);
        endwhile

        % Draw end screen and check if the user wants to play again
        playGame = drawEndScreen("MainTitleScreen.png", crabsCaught, numCrabs);
    endwhile

    % Stop the music and sound effects when the game ends
    stop(player);
    stop(stingPlayer);
    stop(crabCaughtPlayer);

    close all;
    clear;
endfunction

