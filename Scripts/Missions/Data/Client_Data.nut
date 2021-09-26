/* 
    Where we will keep load gui data to grab
    So far this is not player related
*/
Screen_Index <- 1;
Client_Screen_Data <- array(Screen_Index);

// A place to store GUI Data
class Visual_Screen {

  Array_Index = null;
  Window_Name = null;
  ScreenWidth = null;
  ScreenHeight = null;
  ScreenSize_1 = null;
  ScreenSize_2 = null;
  Titlebar = null;
  Moveable = null;
  Colour = null;
  Visible = null;
  Transparent = null;
  Alpha = null;
}

function onClientConnect(Player) 
{
  // Call to set gui data from server to client
  // This func needs to be registed
  // Is called to notify it's time to update the client


}

function SetGUIWindows(player)
{
    // We start from ID 0 and up
    local i = 0; 
 
    while( i != Screen_Index ) {
      
      CallClientFunc( player, MISSION_LOCATION + "Data/clinet.nut", "Create_GUI_Windows", Client_Screen_Data[i].Window_Name, Client_Screen_Data[i].ScreenWidth, Client_Screen_Data[i].ScreenHeight, Client_Screen_Data[i].ScreenSize_1, Client_Screen_Data[i].ScreenSize_2, Client_Screen_Data[i].Titlebar, Client_Screen_Data[i].Moveable, Client_Screen_Data[i].Colour, Client_Screen_Data[i].Visible, Client_Screen_Data[i].Transparent, Client_Screen_Data[i].Alpha );

      i++;
    }
}

/* 
    This function installs the window individually to the client
    The class Visual_Screen is where we install our vlaues for the client
*/
function Install_Window_To_Class(Index, Width, Height, Size_1, Size_2, Title_bar, Moves, Color, Showing, Is_Solid, Alpha_Channel) {

  Client_Screen_Data[Index] = Visual_Screen();

  Client_Screen_Data[Index].Array_Index = Array_Index;
  Client_Screen_Data[Index].Window_Name = GUI_Return(Index);
  Client_Screen_Data[Index].ScreenWidth = Width;
  Client_Screen_Data[Index].ScreenHeight = Height;
  Client_Screen_Data[Index].ScreenSize_1 = Size_1;
  Client_Screen_Data[Index].ScreenSize_2 = Size_2;
  Client_Screen_Data[Index].Titlebar = Title_bar;
  Client_Screen_Data[Index].Moveable = Moves;
  Client_Screen_Data[Index].Colour = Color;
  Client_Screen_Data[Index].Visible = Showing;
  Client_Screen_Data[Index].Transparent = Is_Solid;
  Client_Screen_Data[Index].Alpha = Alpha_Channel;
  
  //CallClientFunc( player, "scriptPath + client file name", "client funcName", Index, Width, Height, Size_1, Size_2, Title_bar, Moves, Color, Showing, Is_Solid, Alpha_Channel)

}

// Related to array index, As well Ini ID's "See ini brackets in file"
function GUI_Return(Index) {
  switch (Index) {
    case 0:  return "Mission_Window";
    case 1:  return "Killers_Window";
    case 2:  return "";
    case 3:  return "";
}