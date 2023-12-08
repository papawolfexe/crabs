function crabs(level)
  numCrabs = level;
  % Initialize command and map dimensions and draw map
  cmd = "null";
  [mapHeight, mapWidth] = drawMap("BGImage.png");

  % Initialize captain location, heading, size, health, and crabs caught
  xCapt = 1000;
  yCapt = 500;
  thetaCapt = -pi/2;
  sizeCapt = 50;
  healthCapt = 100;
  crabsCaught = 0;

  % Initialize crab location, heading, and size
  xCrab = rand(1, numCrabs) * mapWidth;
  yCrab = 3 * mapHeight / 4 + rand(1, numCrabs) * mapHeight / 4;
  thetaCrab = ones(1, numCrabs) * (-pi/2);
  sizeCrab = 50;

  % Initialize jellyfish
  xJelly = rand * mapWidth;
  yJelly = 0;
  thetaJelly = -pi/2;
  sizeJelly = 25;
  jellySting = 2;

  % Draw initial captain, crab, and jellyfish
  [captGraphics, xNet, yNet] = drawCapt(xCapt, yCapt, thetaCapt, sizeCapt);
  crabGraphics = drawCrab(xCrab, yCrab, thetaCrab, sizeCrab);
  jellyGraphics = drawJelly(xJelly, yJelly, thetaJelly, sizeJelly);

  % Print health status and crabs caught
  healthLoc = [100, 100];
  crabsCaughtLoc = [100, 175];
  healthStatus = text(healthLoc(1), healthLoc(2), strcat('Health = ', num2str(healthCapt)), 'FontSize', 12, 'Color', 'red');
  crabsCaughtStatus = text(crabsCaughtLoc(1), crabsCaughtLoc(2), strcat('Crabs Caught = ', num2str(crabsCaught)), 'FontSize', 12, 'Color', 'red');

  % Main loop
  while (1)
    % Put your jellyfish stuff here...

    cmd = kbhit(1);

    % Move and redraw jellyfish
    for i = 1:length(jellyGraphics)
      delete(jellyGraphics(i));
    endfor
    [xJelly, yJelly, thetaJelly] = moveJelly(level, xJelly, yJelly, thetaJelly, sizeJelly, mapHeight, mapWidth);
    jellyGraphics = drawJelly(xJelly, yJelly, thetaJelly, sizeJelly);

    % Read the keyboard
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
    if (getDist(xJelly, yJelly, xCapt, yCapt) < 3 * sizeCapt)
      healthCapt = healthCapt - jellySting;
    endif

    % Crab catching logic
    if (getDist(xNet, yNet, xCrab, yCrab) < 2 * sizeCapt) % Crab is caught
      crabsCaught = crabsCaught + 1;

      % Erase old crab
      for i = 1:length(crabGraphics)
        delete(crabGraphics(i));
      endfor

      % Create a new crab at a random location
      xCrab = rand * mapWidth;
      yCrab = rand * mapHeight;
      thetaCrab = -pi/2;

      % Redraw crab
      crabGraphics = drawCrab(xCrab, yCrab, thetaCrab, sizeCrab);
    endif

    % Update health and crabs caught status
    delete(healthStatus);
    delete(crabsCaughtStatus);
    healthStatus = text(healthLoc(1), healthLoc(2), strcat('Health = ', num2str(healthCapt)), 'FontSize', 12, 'Color', 'red');
    crabsCaughtStatus = text(crabsCaughtLoc(1), crabsCaughtLoc(2), strcat('Crabs Caught = ', num2str(crabsCaught)), 'FontSize', 12, 'Color', 'red');

    fflush(stdout);
    pause(0.01);
  endwhile

  close all
endfunction

