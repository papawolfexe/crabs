function [xJelly,yJelly,thetaJelly] = moveJelly(level, x, y, theta, size, height, width)

  moveScale = 50;
  step = moveScale + level;

  yJelly = y + step;
  xJelly = x;
  thetaJelly = theta;

  if (yJelly > height-10*size)
    yJelly=size;
    xJelly=width*rand;
  endif

endfunction
