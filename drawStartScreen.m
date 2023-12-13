function level = drawStartScreen (imgName)

  % Draw a start screen containing the message "Enter a level 1-9” and read the users response.
  drawMap(imgName);
    hold on
  % write myMessage at messageLoc
  myMessage = ['Enter a level 1-9 '];
  messageLoc = [750,350];
  myText = text(messageLoc(1), messageLoc(2), myMessage, 'FontSize', 30, 'Color', 'red');
  level = getLevel();

   % delete the previous message and write a new one.
  delete(myText);
  myMessage = ['Ok, Level = ', ' ',num2str(level)];
  myText = text(messageLoc(1), messageLoc(2), myMessage, 'FontSize', 30, 'Color', 'red');
  pause(2)
hold off
endfunction
  function level = getLevel ( )
  while (1)
  commandwindow(); %shift keyboard focus to the command window
  cmd=kbhit(1);
    if( cmd == '1' || cmd == '2' || cmd == '3' || cmd == '4' || cmd == '5' || ...
    cmd == '6' || cmd == '7' || cmd == '8' || cmd == '9' )
    level = str2num(cmd);
    break;
    endif
  fflush(stdout);
  pause(.01)
  endwhile
endfunction
