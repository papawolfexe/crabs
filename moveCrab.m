function [xCrab,yCrab,thetaCrab] = moveCrab(cmd,xCrab,yCrab,thetaCrab,sizeCrab, mapHeight, mapWidth);
  dTheta = pi/6;
  dStep = 50;
  if( cmd == "u" ) %move left
  xCrab = x + dStep * sin(theta);
  yCapt = y + dStep * -cos(theta);
  thetaCrab = theta;
  elseif ( cmd == "o" ) %move right
  xCrab = x + dStep * -sin(theta);
  yCapt = y + dStep * cos(theta);
  thetaCrab = theta + dTheta;
  elseif ( cmd == "j" ) %turn left
  xCrab = x;
  yv = y;
  thetaCrab = theta - dTheta;
  elseif ( cmd == "l" ) %turn right
  xCrab = x;
  yCrab = y;
  thetaCrab = theta + dTheta;
  elseif ( cmd == "i" ) %move back
  xCrab = x + dStep * -sin(theta);
  yCapt = y + dStep * -cos(theta);
  thetaCrab = theta  dTheta;
  else % if none of the cases are true, set the new variables equal to the old inputs.
  xCrab = x;
  yCrab = y;
  thetaCrab = theta;
  endif

endfunction
