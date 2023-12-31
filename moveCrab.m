function [xCrab,yCrab,thetaCrab] = moveCrab(cmd,x,y,theta,size, height, width);
  dTheta = pi/6;
  dStep = 50;
  if( cmd == "j" ) %move left
  xCrab = x + dStep * sin(theta);
  yCrab = y + dStep * -cos(theta);
  thetaCrab = theta;
  elseif ( cmd == "l" ) %move right
  xCrab = x + dStep * -sin(theta);
  yCrab = y + dStep * cos(theta);
  thetaCrab = theta;
  elseif ( cmd == "," ) %turn left
  xCrab = x;
  yCrab = y;
  thetaCrab = theta - dTheta;
  elseif ( cmd == "i" ) %turn right
  xCrab = x;
  yCrab = y;
  thetaCrab = theta + dTheta;
  elseif ( cmd == "k" ) %move back
  xCrab = x + dStep * -sin(theta);
  yCrab = y + dStep * cos(theta);
  thetaCrab = theta;
  else % if none of the cases are true, set the new variables equal to the old inputs.
  xCrab = x;
  yCrab = y;
  thetaCrab = theta;
  endif

endfunction
