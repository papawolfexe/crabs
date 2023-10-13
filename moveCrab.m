function [xCrab,yCrab,thetaCrab] = moveCrab(cmd,x,y,theta,height,width,size)
  dTheta = pi/6;
  dStep = 50;
  if( cmd == "j" ) %move forward
  xCrab = x + dStep * sin(theta);
  yCapt = y + dStep * -cos(theta);
  thetaCapt = theta;
  elseif ( cmd == "i" ) %turn right
  xCapt = x;
  yCapt = y;
  thetaCapt = theta + dTheta;
  elseif ( cmd == "a" ) %turn left
  xCapt = x;
  yCapt = y;
  thetaCapt = theta - dTheta;
  else % if none of the cases are true, set the new variables equal to the old inputs.
  xCapt = x;
  yCapt = y;
  thetaCapt = theta;
  endif

endfunction
