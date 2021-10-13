
/*
  Updated, Return for:
    Adding gui data from server side storage and sync over to client
    Clean up GUI functions.
    Correct any errors

  Version: 0.01 Beta
*/

//----------------------------------------------------------

/*
     Load the script events
*/

function onScriptLoad() {
    
  onMessagingScriptLoad()
    
  onDebugScriptLoad()

  return 1;
}
 

//----------------------------------------------------------

/*
    This is our messaging system script
*/

// Non the less, onScriptLoad Event
function onMessagingScriptLoad() {
     // Our bind key for messages 
     BindKey( KEY_RETURN, BINDTYPE_DOWN, "Messaging_System", 123 );
}

function Messaging_System( somenumber )
{
     CallServerFunc("Main/Server.nut", "Call", FindLocalPlayer());
}

//----------------------------------------------------------

/*
    Turn off all radar related data.
    This system is outdated but we will keep it anywho
    Used for flashing the origanal radar and much more

*/


class Player_Progress {

/*
    Used as a method to unlock stuff for a player
    But can be used for on/off methods
*/
    // Hud Related
    Radar = true;
    Clock = true;

    Money = true;
    Armour = true;
    Health = true;
    Weapon = true;
    Wanted = true;
    // Hud Related

    //Custom Hud
    Hud_Window = null;
    
    Hud_Health_Bar = null;
    Hud_Armour_Bar = null;
    Inventory_Button = null;
    Hud_Bar_Box = null;
    Health_Bar_Value = null;
    Armour_Bar_Value = null;
    Hud_Timer_Box = null;
    //Custom Hud

//----------------------------------------------------------
    function Set_Radar(bool) {
        
      Radar = bool;
      ::SetHUDItemEnabled( ::HUD_RADAR, Radar)
    }
    
    function Get_Radar() {
      return Radar;
    }
//----------------------------------------------------------

    function Set_Armour(bool) {
        
      Armour = bool;
      ::SetHUDItemEnabled( ::HUD_ARMOUR, Armour)
    }
	
    function Get_Armour() {
      return Armour;
    }
//----------------------------------------------------------
    function Set_Health(bool) {
      Health = bool;
      ::SetHUDItemEnabled( ::HUD_HEALTH, Health)
    }
	
    function Get_Health() {
      return Health;
    }
//----------------------------------------------------------
    function Set_Money(bool) {
      
      Money = bool;
      ::SetHUDItemEnabled( ::HUD_MONEY, Money)
    }
    function Get_Money() {
      return Money;
    }
//----------------------------------------------------------
    function Set_Wanted(bool) {
        
      Wanted = bool;
      ::SetHUDItemEnabled( ::HUD_WANTED, Wanted)
    }
	function Get_Wanted() {
      return Wanted;
	}     
//----------------------------------------------------------
    function Set_Weapon(bool) {
        
      Weapon = bool;
      ::SetHUDItemEnabled( ::HUD_WEAPON, Weapon)
    }
    function Get_Weapon() {
      return Weapon;
    }     
//----------------------------------------------------------
    function Set_Clock(bool) {
        
      Clock = bool;
      ::SetHUDItemEnabled( ::HUD_CLOCK, Clock)
    }
    function Get_Clock() {
      return Clock;
    }     
//----------------------------------------------------------
    function InstallCustomHud() {
	  
      //Hud_Window = ::GUIWindow( ::VectorScreen(::ScreenWidth/1 - 200, ::ScreenHeight/1-180), ScreenSize(ceil(ScreenWidth/2-445),ceil(ScreenHeight/2-465)), "Personal Scoreboard" );
      Hud_Window = ::GUIWindow( ::VectorScreen(::ScreenWidth/1 - 200, ::ScreenHeight/299), ::ScreenSize( 199, 45 ), "Personal Scoreboard" );
      Hud_Window.Titlebar = false;
      Hud_Window.Moveable = true;
      Hud_Window.Colour = ::Colour( 0, 0, 0 );
      Hud_Window.Alpha = 123;
      Hud_Window.Visible = true;
      Hud_Window.Transparent = true;

      Hud_Health_Bar = GUIProgressBar(::VectorScreen( 100, 47 ), ::ScreenSize( 100, 15 ));
      Hud_Health_Bar.MaxValue = 100;
      Hud_Health_Bar.EndColour = Colour( 0, 255, 0 );
      Hud_Health_Bar.StartColour = Colour( 250, 20, 20 );
      Hud_Health_Bar.Alpha = 255;
      Hud_Health_Bar.Value = 100;
      Hud_Health_Bar.Thickness = 2;
      Hud_Health_Bar.Visible = true;

        
      Hud_Armour_Bar = GUIProgressBar(::VectorScreen( 0, 47 ), ::ScreenSize( 100, 15 ));
      Hud_Armour_Bar.MaxValue = 100;
      Hud_Armour_Bar.EndColour = Colour(128, 128, 128);
      Hud_Armour_Bar.StartColour = Colour(0, 0, 0);
      Hud_Armour_Bar.Alpha = 255;
      Hud_Armour_Bar.Value = 100;
      Hud_Armour_Bar.Thickness = 2;
      Hud_Armour_Bar.Visible = true;

      Health_Bar_Value.TextColour = ::Colour( 255, 255, 255 );
      Health_Bar_Value.FontSize = 8;    

      Armour_Bar_Value = ::GUILabel( ::VectorScreen( 40, 49 ), ::ScreenSize( 5, 5 ), FindLocalPlayer().Armour.tostring() );
      Armour_Bar_Value .TextColour = ::Colour( 255, 255, 255 );
      Armour_Bar_Value.FontSize = 8;

      Inventory_Button = GUIButton( ::VectorScreen( 60, 30 ), ::ScreenSize( 60, 0 ), "Inventory" );
      Hud_Bar_Box = ::GUISprite("Hud Bar Box.png", ::VectorScreen( 0, 47 ));
      Health_Bar_Value = ::GUILabel( ::VectorScreen( 140, 49 ), ::ScreenSize( 5, 5 ), FindLocalPlayer().Health.tostring() );
      Hud_Timer_Box = ::GUISprite("Timer Box.png", ::VectorScreen( 109, 420 ));
      Hud_Timer_Box.Alpha = 220;

      ::AddGUILayer( Hud_Window );
		
      // Add the Health Bar to the Hud
      Hud_Window.AddChild( Hud_Health_Bar );
    
      // Add the Armour Bar to the Hud
      Hud_Window.AddChild( Hud_Armour_Bar );

      // Add the Health Bar value to the Hud
      Hud_Window.AddChild( Health_Bar_Value );
    
      // Add the Armour Bar value to the Hud
      Hud_Window.AddChild( Armour_Bar_Value );

      // Add the Inventory to the Hud
      Hud_Window.AddChild( Inventory_Button );
    
      // Add the GUI bar box to the Hud
      Hud_Window.AddChild(Hud_Bar_Box);
    
      // Add the timer box to the Hud
      Hud_Window.AddChild(Hud_Timer_Box);

      // Add the Timer text to the Hud gui
      Hud_Window.AddChild( Mission_Timer_Text );

	}
    function CustomRadar(bool) {
      Hud_Window.Visible = bool;
      Hud_Health_Bar.Visible = bool;
      Hud_Armour_Bar.Visible = bool;
      Inventory_Button.Visible = bool;
      Hud_Bar_Box.Visible = bool;
      Health_Bar_Value.Visible = bool;
      Armour_Bar_Value.Visible = bool;
      Hud_Timer_Box.Visible = bool;
      Mission_Timer_Text.Visible = bool;
    }
}

//----------------------------------------------------------

function onDebugScriptLoad() {
  // In these functions we can finally detect if part of the hud is displayed. In part of the script it is set to show no mater what when the join event is triggered
	
  //Update this for full detection
  
  //if (Player_Progress().Get_Radar()) 
  Player_Progress().Set_Radar(false);
  Player_Progress().Set_Armour(false);
  Player_Progress().Set_Health(false);
  Player_Progress().Set_Money(false);
  Player_Progress().Set_Wanted(false);
  Player_Progress().Set_Weapon(false);
  Player_Progress().Set_Clock(false);

  Load_Mission_GUI();
  Player_Progress().InstallCustomHud();
  Load_Gui_Weapon_Sprites();
   
  return 1;
}


/* Radar flash */
HUD_RADAR_BOOL <- true;

function Timed_Flash() {
  Player_Progress().Set_Radar(true)
  NewTimer("Flash_Radar",200, 8); 
}

function Flash_Radar() {
  local con = HUD_RADAR_BOOL  == true;
  Player_Progress().Set_Radar(con ? false : true)
  HUD_RADAR_BOOL = con ? false : true
  PlayFrontEndSound(con ? 150 : 149);
  return true;
}

/* Radar flash */

//------------------------------------------------------------------------------------------------------

/*
    *Weapon System 
*/

// Sprite Array
Sprite_Weapon <- array(12, null);
class SpriteWeapons {
    Weapon = null;
}

function onClientRender() {
    if (Player_Progress().Hud_Health_Bar)
    {
        Hud_Health_Bar.Value = FindLocalPlayer().Health;
        Health_Bar_Value.Text = FindLocalPlayer().Health.tostring();
        //Hud_Health_Text.Text =FindLocalPlayer().Health.tostring();
        /*if (FindLocalPlayer().Health == 0) Hud_Health_Bar.Visible = false;
        else Hud_Health_Bar.Visible = true;*/
    }
    if (Player_Progress().Hud_Armour_Bar)
    {
        Player_Progress().Hud_Armour_Bar.Value = FindLocalPlayer().Armour;
        Player_Progress().Armour_Bar_Value.Text = FindLocalPlayer().Armour.tostring();
        //Hud_Armour_Text.Text = FindLocalPlayer().Armour.tostring();
        /*if (FindLocalPlayer().Armour == 0) Hud_Armour_Bar.Visible = false;
        else Hud_Armour_Bar.Visible = true;*/
    }

}

function Load_Gui_Weapon_Sprites() {

        local i = 0;

        while( i != 12)
        {
                Sprite_Weapon[i] = SpriteWeapons();
                Sprite_Weapon[i].Weapon = ::GUISprite(::GetWeaponName( i ) +".png", ::VectorScreen( 100, 0 ));
                Hud_Window.AddChild(Sprite_Weapon[i].Weapon);
                Sprite_Weapon[i].Weapon.Alpha = 150;
                Sprite_Weapon[i].Weapon.Visible = false;

                i++;
        }
        print("Loaded Weapon Sprite System");
        
        // Show Fist
        Sprite_Weapon[0].Weapon.Visible = true;
}

// Sprite changer
function onClientWeaponChange(Old, New)
{
    Sprite_Weapon[Old].Weapon.Visible = false;
    Sprite_Weapon[New].Weapon.Visible = true;
    Your_Weapon = New;
}

//------------------------------------------------------------------------------------------------------

// Testimental GUI


/* 
Okay once upon a time I changed this to render from the server so it could not 
get stollen. All data was server side and the server would manipulate the entire client valuse to 
anything I wanted for gui etc. All data was set to be stored server side in a simple ini I was writting in squirrel

It's randomly displayed in plan view for now. Please see the older functions at the botton

############################################################################################
## Additional edit 10/09/2021                                                             ## 
## Reimpliment storing everything server side. Update this section once that is completed ##
## Ini I/O in squirrel                                                                    ##
############################################################################################
*/
Top_Label <- null; // Our first label 
Top_Label_VectorScreen_1 <- 10; // Our vector screen
Top_Label_VectorScreen_2 <- 5; // Our vector screen

Top_Label_ScreenSize_1 <- 5; // Our Screen Size
Top_Label_ScreenSize_2 <- 5; // Our Screen Size

Top_Label_Color <- [223, 223, 223];

Second_Label <- null; // Our Second label 
Second_Label_VectorScreen_1 <- 10; // Our vector screen
Second_Label_VectorScreen_2 <- 25; // Our vector screen

Second_Label_ScreenSize_1 <- 10; // Our Screen Size
Second_Label_ScreenSize_2 <- 25; // Our Screen Size

Second_Label_Color <- [223, 223, 223];

Third_Label <- null; // Our Third label 
Third_Label_VectorScreen_1 <- 10; // Our vector screen
Third_Label_VectorScreen_2 <- 45; // Our vector screen

Third_Label_ScreenSize_1 <- 5; // Our Screen Size
Third_Label_ScreenSize_2 <- 45; // Our Screen Size

Third_Label_Color <- [223, 223, 223];

Mission_Window <- null; // Our Mission Window
Mission_Window_VectorScreen_1 <- 135; // Our vector screen
Mission_Window_VectorScreen_2 <- 155; // Our vector screen

Mission_Window_ScreenSize_1 <- 130; // Our Screen Size
Mission_Window_ScreenSize_2 <- 80; // Our Screen Size
Mission_Window_Color <- [0, 0, 0];

Mission_Timer_Window <- null; // Where we store the timer text
Mission_Timer_Text <- null; // Our timer text
Mission_Timer_Text_VectorScreen_1 <- 109; // Our vector screen
Mission_Timer_Text_VectorScreen_2 <- 420; // Our vector screen

Mission_Timer_Text_ScreenSize_1 <- 5; // Our Screen Size
Mission_Timer_Text_ScreenSize_2 <- 5; // Our Screen Size
Mission_Timer_Text_Color <- [223, 223, 223];

Info_Window <- null; // Our hint/tip system

Info_Window_VectorScreen_1 <- 300; // Our vector screen
Info_Window_VectorScreen_2 <- 180; // Our vector screen

Info_Window_ScreenSize_1 <- 400; // Our Screen Size
Info_Window_ScreenSize_2 <- 70; // Our Screen Size
Info_Window_Color <- [0, 0, 0];

Info_Text_1 <- null; // Our hint/tip system first line
Info_Text_1_VectorScreen_1 <- 1; // Our vector screen
Info_Text_1_VectorScreen_2 <- 0; // Our vector screen

Info_Text_1_ScreenSize_1 <- 5; // Our Screen Size
Info_Text_1_ScreenSize_2 <- 5; // Our Screen Size
Info_Text_1_Color <- [192, 192, 223];

Info_Text_2 <- null; // Our hint/tip system second line
Info_Text_2_VectorScreen_1 <- 1; // Our vector screen
Info_Text_2_VectorScreen_2 <- 20; // Our vector screen

Info_Text_2_ScreenSize_1 <- 5; // Our Screen Size
Info_Text_2_ScreenSize_2 <- 5; // Our Screen Size
Info_Text_2_Color <- [192, 192, 223];

Info_Text_3 <- null; // Our hint/tip system third line
Info_Text_3_VectorScreen_1 <- 1; // Our vector screen
Info_Text_3_VectorScreen_2 <- 40; // Our vector screen

Info_Text_3_ScreenSize_1 <- 5; // Our Screen Size
Info_Text_3_ScreenSize_2 <- 5; // Our Screen Size
Info_Text_3_Color <- [192, 192, 223];


Info_Text_4 <- null; // Our hint/tip system fourth line
Info_Text_4_VectorScreen_1 <- 1; // Our vector screen
Info_Text_4_VectorScreen_2 <- 60; // Our vector screen

Info_Text_4_ScreenSize_1 <- 5; // Our Screen Size
Info_Text_4_ScreenSize_2 <- 5; // Our Screen Size
Info_Text_4_Color <- [192, 192, 223];

function Load_Mission_GUI()
{
    Top_Label = ::GUILabel( ::VectorScreen( Top_Label_VectorScreen_1, Top_Label_VectorScreen_2 ), ::ScreenSize( Top_Label_ScreenSize_1, Top_Label_ScreenSize_2 ), ">-Stories of Liberty-<" );

    Top_Label.Visible = true;
    Top_Label.TextColour = Colour( Top_Label_Color[0], Top_Label_Color[1], Top_Label_Color[2] );
    Top_Label.FontSize = 9;
    Top_Label.FontName = "Arial";
    ::AddGUILayer( Top_Label );
    ::SendGUILayerToFront( Top_Label );

    Second_Label = ::GUILabel( ::VectorScreen( Second_Label_VectorScreen_1, Second_Label_VectorScreen_2 ), ::ScreenSize( Second_Label_ScreenSize_1, Second_Label_ScreenSize_2 ), "Mission: No Mission" );
    Second_Label.Visible = true;
    Second_Label.TextColour = Colour( Second_Label_Color[0], Second_Label_Color[1], Second_Label_Color[2] );
    Second_Label.FontSize = 9;
    Second_Label.FontName = "Arial";
    ::AddGUILayer( Second_Label );
    ::SendGUILayerToFront( Second_Label );

    Third_Label = ::GUILabel( ::VectorScreen( Third_Label_VectorScreen_1, Third_Label_VectorScreen_2 ), ::ScreenSize( Third_Label_ScreenSize_1, Third_Label_ScreenSize_2 ), "Mission: ID: None" );

    Third_Label.Visible = true;
    Third_Label.TextColour = Colour( Third_Label_Color[0], Third_Label_Color[1], Third_Label_Color[2] );
    Third_Label.FontSize = 9;
    Third_Label.FontName = "Arial";
    ::AddGUILayer( Third_Label );
    ::SendGUILayerToFront( Third_Label );

    Mission_Window = ::GUIWindow( ::VectorScreen( ::ScreenWidth - Mission_Window_VectorScreen_1, ::ScreenHeight - Mission_Window_VectorScreen_2 ), ::ScreenSize( Mission_Window_ScreenSize_1, Mission_Window_ScreenSize_2 ), "Personal Scoreboard" );
    Mission_Window.Titlebar = false;
    Mission_Window.Moveable = true;
    Mission_Window.Colour = ::Colour( Mission_Window_Color[0], Mission_Window_Color[1], Mission_Window_Color[2] );
    Mission_Window.Visible = true;
    Mission_Window.Transparent = true;
    Mission_Window.Alpha = 123;
    ::AddGUILayer( Mission_Window );
    
    Mission_Window.AddChild( Top_Label );
    Mission_Window.AddChild( Second_Label );
    Mission_Window.AddChild( Third_Label );

    Info_Text_1 = ::GUILabel( ::VectorScreen( Info_Text_1_VectorScreen_1, Info_Text_1_VectorScreen_2 ), ::ScreenSize( Info_Text_1_ScreenSize_1, Info_Text_1_ScreenSize_2 ), "Welcome to Liberty Unleashed 0.1" );
    Info_Text_1.TextColour = ::Colour( Info_Text_1_Color[0], Info_Text_1_Color[1], Info_Text_1_Color[2] );
    Info_Text_1.FontSize = 15;

    Info_Text_2 = ::GUILabel( ::VectorScreen( Info_Text_2_VectorScreen_1, Info_Text_2_VectorScreen_2 ), ::ScreenSize( Info_Text_2_ScreenSize_1, Info_Text_2_ScreenSize_2 ), "Main Developer: Vrocker" );
    Info_Text_2.TextColour = ::Colour( Info_Text_2_Color[0], Info_Text_2_Color[1], Info_Text_2_Color[2] );
    Info_Text_2.FontSize = 15;

    Info_Text_3 = ::GUILabel( ::VectorScreen( Info_Text_3_VectorScreen_1, Info_Text_3_VectorScreen_2 ), ::ScreenSize( Info_Text_3_ScreenSize_1, Info_Text_3_ScreenSize_2 ), "Welcome to: Stories of Liberty" );
    Info_Text_3.TextColour = ::Colour( Info_Text_3_Color[0], Info_Text_3_Color[1], Info_Text_3_Color[2] );
    Info_Text_3.FontSize = 15;

    Info_Text_4 = ::GUILabel( ::VectorScreen( Info_Text_4_VectorScreen_1, Info_Text_4_VectorScreen_2 ), ::ScreenSize( Info_Text_4_ScreenSize_1, Info_Text_4_ScreenSize_2 ), "Owned by: Motley" );
    Info_Text_4.TextColour = ::Colour( Info_Text_4_Color[0], Info_Text_4_Color[1], Info_Text_4_Color[2] );
    Info_Text_4.FontSize = 15;

    Info_Window = ::GUIWindow( ::VectorScreen( ::ScreenWidth/Info_Window_VectorScreen_1, ::ScreenHeight/Info_Window_VectorScreen_2), ::ScreenSize( Info_Window_ScreenSize_1, Info_Window_ScreenSize_2 ), "Server Tips" );
    Info_Window.Titlebar = false;
    Info_Window.Moveable = true;
    Info_Window.Colour = ::Colour( Info_Window_Color[0], Info_Window_Color[1], Info_Window_Color[2] );
    Info_Window.Visible = true;
    Info_Window.AddChild( Info_Text_1 );
    Info_Window.AddChild( Info_Text_2 );
    Info_Window.AddChild( Info_Text_3 );
    Info_Window.AddChild( Info_Text_4 );
    Info_Window.Transparent = true;
    Info_Window.Alpha = 123;
    ::AddGUILayer( Info_Window );

    Mission_Timer_Text = ::GUILabel( ::VectorScreen( Mission_Timer_Text_VectorScreen_1, Mission_Timer_Text_VectorScreen_2 ), ::ScreenSize( Mission_Timer_Text_ScreenSize_1, Mission_Timer_Text_ScreenSize_2 ), "00:56" );
    Mission_Timer_Text.TextColour = ::Colour( Mission_Timer_Text_Color[0], Mission_Timer_Text_Color[1], Mission_Timer_Text_Color[2] );
    Mission_Timer_Text.FontSize = 25;
    Mission_Timer_Text.FontTags = ::TAG_BOLD; 
    Mission_Timer_Text.Flags = ::FLAG_SHADOW;




    //Inventory_Button = GUIButton( ::VectorScreen( 64, 190 ), ::ScreenSize( 100, 50 ), "Inventory" )
    if ( Inventory_Button ) Inventory_Button.Colour = ::Colour( 192, 192, 223 );
    //Inventory_Button.FontTags = TAG_BOLD;
    //Inventory_Button.SetCallbackFunc( Menu1_Handle0 );
    Inventory_Button.TextColour =::Colour( 0, 0, 0 );
    Inventory_Button.Alpha = 150;
    Inventory_Button.Flags = FLAG_SHADOW;
    Inventory_Button.Visible = false;
    Inventory_Button.FontSize = 10;

}

// Bad storage but do similar later. How many windows do I need later on screen? Try to reuse windows ;)
Client_Screen_Data <- array(80);

class Visual_Screen {

  Array_Index = null;
  Window_Name = null;
  Screen_Width = null;
  Screen_Height = null;
  ScreenSize_x = null;
  ScreenSize_y = null;
  Titlebar = null;
  Moveable = null;
  Colour = null;
  Visible = null;
  Transparent = null;
  Alpha = null;
}

function Create_GUI_Windows(WindowName, Screen_Width, Screen_Height, ScreenSize_1, ScreenSize_2, Title_bar, Move_able, Color, Showing, Solid, Alpha_Channel)
{
    

    Mission_Window = ::GUIWindow( ::VectorScreen( ::ScreenWidth - Mission_Window_VectorScreen_1, ::ScreenHeight - Mission_Window_VectorScreen_2 ), ::ScreenSize( Mission_Window_ScreenSize_1, Mission_Window_ScreenSize_2 ), "Personal Scoreboard" );
    Mission_Window.Titlebar = false;
    Mission_Window.Moveable = true;
    Mission_Window.Colour = ::Colour( Mission_Window_Color[0], Mission_Window_Color[1], Mission_Window_Color[2] );
    Mission_Window.Visible = true;
    Mission_Window.Transparent = true;
    Mission_Window.Alpha = 123;
    ::AddGUILayer( Mission_Window );
    
    Mission_Window.AddChild( Top_Label );
    Mission_Window.AddChild( Second_Label );
    Mission_Window.AddChild( Third_Label );

}
