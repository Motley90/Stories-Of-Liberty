class Player_Progress {

/*
    Used as a method to unlock stuff for a player
    But can be used for on/off methods
*/
    // Hud Related
    Radar = false;
    Clock = false;

    Money = false;
    Armour = false;
    Health = false;
    Weapon = false;
    Wanted = false;
    // Hud Related

    function Set_Radar(bool) {
        
        if (bool == true ) 
        {
            Radar = true;
            ::SetHUDItemEnabled( ::HUD_RADAR, Radar)
        }
        else {
            Radar = false;
            ::SetHUDItemEnabled( ::HUD_RADAR, Radar)
        }
        
    }

    function Set_Armour(bool) {
        
        if (bool == true ) 
        {
            Armour = true;
            ::SetHUDItemEnabled( ::HUD_ARMOUR, Armour)
        }
        else {
            Armour = false;
            ::SetHUDItemEnabled( ::HUD_ARMOUR, Armour)
        }
        
    }

    function Set_Health(bool) {
        
        if (bool == true ) 
        {
            Health = true;
            ::SetHUDItemEnabled( ::HUD_HEALTH, Health)
        }
        else {
            Health = false;
            ::SetHUDItemEnabled( ::HUD_HEALTH, Health)
        }
        
    }
    
    function Set_Money(bool) {
        
        if (bool == true ) 
        {
            Money = true;
            ::SetHUDItemEnabled( ::HUD_MONEY, Money)
        }
        else {
            Money = false;
            ::SetHUDItemEnabled( ::HUD_MONEY, Money)
        }
        
    }
    function Set_Wanted(bool) {
        
        if (bool == true ) 
        {
            Wanted = true;
            ::SetHUDItemEnabled( ::HUD_WANTED, Wanted)
        }
        else {
            Wanted = false;
            ::SetHUDItemEnabled( ::HUD_WANTED, Wanted)
        }
        
    }
    function Set_Weapon(bool) {
        
        if (bool == true ) 
        {
            Weapon = true;
            ::SetHUDItemEnabled( ::HUD_WEAPON, Weapon)
        }
        else {
            Weapon = false;
            ::SetHUDItemEnabled( ::HUD_WEAPON, Weapon)
        }
        
    }
    function Set_Clock(bool) {
        
        if (bool == true ) 
        {
            Clock = true;
            ::SetHUDItemEnabled( ::HUD_CLOCK, Clock)
        }
        else {
            Clock = false;
            ::SetHUDItemEnabled( ::HUD_CLOCK, Clock)
        }
        
    }
}

// Load the script event
function onScriptLoad()
{
     // Our bind key for messages 
     BindKey( KEY_RETURN, BINDTYPE_DOWN, "Messaging_System", 123 );
     onDebugScriptLoad()

     return 1;
}
 
function Messaging_System( somenumber )
{
     CallServerFunc("Main/Server.nut", "Call", FindLocalPlayer());
}

//----------------------------------------------------------

function onDebugScriptLoad()
{
    print(GetWeaponName(0))
    Player_Progress().Set_Radar(false)
    Player_Progress().Set_Armour(false)
    Player_Progress().Set_Health(false)
    Player_Progress().Set_Money(false)
    Player_Progress().Set_Wanted(false)
    Player_Progress().Set_Weapon(false)
    Player_Progress().Set_Clock(false)

    Load_Mission_GUI()
    Load_Gui_Weapon_Window() 
    Load_Gui_Weapon_Sprites()
    
    return 1;
}


/* Radar flash */
HUD_RADAR_BOOL <- true;

function Timed_Flash() 
{
    // Incase they are new, It's easier for now
    Player_Progress().Set_Radar(true)
    
    // Flash the radar
    NewTimer("Flash_Radar",200, 8);
    
}

//Some ugly shit
function Flash_Radar() 
{
    

    if ( HUD_RADAR_BOOL == true )
    {
        Player_Progress().Set_Radar(false)
        HUD_RADAR_BOOL = false
        PlayFrontEndSound(150);
        return true
    }
    
    if ( HUD_RADAR_BOOL == false )
    {
        Player_Progress().Set_Radar(true)
        HUD_RADAR_BOOL = true
        PlayFrontEndSound(149);
        return true
    }
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

Hud_Window <- null;
    
Hud_Health_Bar <- GUIProgressBar(::VectorScreen( 100, 47 ), ::ScreenSize( 100, 15 ));
Hud_Armour_Bar <- GUIProgressBar(::VectorScreen( 0, 47 ), ::ScreenSize( 100, 15 ));
Inventory_Button <- GUIButton( ::VectorScreen( 60, 30 ), ::ScreenSize( 60, 0 ), "Inventory" );
Hud_Bar_Box <- ::GUISprite("Hud Bar Box.png", ::VectorScreen( 0, 47 ));
Health_Bar_Value <- ::GUILabel( ::VectorScreen( 140, 49 ), ::ScreenSize( 5, 5 ), FindLocalPlayer().Health.tostring() );
Armour_Bar_Value <- ::GUILabel( ::VectorScreen( 40, 49 ), ::ScreenSize( 5, 5 ), FindLocalPlayer().Armour.tostring() );
Hud_Timer_Box <- ::GUISprite("Timer Box.png", ::VectorScreen( 95, 420 ));

function Load_Gui_Weapon_Window() 
{
    //Hud_Window = ::GUIWindow( ::VectorScreen(::ScreenWidth/1 - 200, ::ScreenHeight/1-180), ScreenSize(ceil(ScreenWidth/2-445),ceil(ScreenHeight/2-465)), "Personal Scoreboard" );
    Hud_Window = ::GUIWindow( ::VectorScreen(::ScreenWidth/1 - 200, ::ScreenHeight/299), ::ScreenSize( 199, 45 ), "Personal Scoreboard" );
    Hud_Window.Titlebar = false;
    Hud_Window.Moveable = true;
    Hud_Window.Colour = ::Colour( 0, 0, 0 );
    Hud_Window.Alpha = 123;
    Hud_Window.Visible = true;
    Hud_Window.Transparent = true;
    
    // Add the Timer text to the Hud gui
    Hud_Window.AddChild( Mission_Timer_Text );
    
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


    Hud_Health_Bar.MaxValue = 100;
    Hud_Health_Bar.EndColour = Colour( 0, 255, 0 );
    Hud_Health_Bar.StartColour = Colour( 250, 20, 20 );
    Hud_Health_Bar.Alpha = 255;
    Hud_Health_Bar.Value = 100;
    Hud_Health_Bar.Thickness = 2;
    Hud_Health_Bar.Visible = true;

    Hud_Armour_Bar.MaxValue = 100;
    Hud_Armour_Bar.EndColour = Colour(128, 128, 128);
    Hud_Armour_Bar.StartColour = Colour(0, 0, 0);
    Hud_Armour_Bar.Alpha = 255;
    Hud_Armour_Bar.Value = 100;
    Hud_Armour_Bar.Thickness = 2;
    Hud_Armour_Bar.Visible = true;

    Health_Bar_Value.TextColour = ::Colour( 255, 255, 255 );
    Health_Bar_Value.FontSize = 8;    

    Armour_Bar_Value .TextColour = ::Colour( 255, 255, 255 );
    Armour_Bar_Value.FontSize = 8;


    ::AddGUILayer( Hud_Window );
}

function onClientRender() {
    if (Hud_Health_Bar)
    {
        Hud_Health_Bar.Value = FindLocalPlayer().Health;
        Health_Bar_Value.Text = FindLocalPlayer().Health.tostring();
        //Hud_Health_Text.Text =FindLocalPlayer().Health.tostring();
        /*if (FindLocalPlayer().Health == 0) Hud_Health_Bar.Visible = false;
        else Hud_Health_Bar.Visible = true;*/
    }
    if (Hud_Armour_Bar)
    {
        Hud_Armour_Bar.Value = FindLocalPlayer().Armour;
        Armour_Bar_Value.Text = FindLocalPlayer().Armour.tostring();
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

Top_Label <- null;
    
Second_Label <- null;
Third_Label <- null;
Mission_Window <- null;

Info_Window <- null;
Info_Text_1 <- null;
Info_Text_2 <- null;
Info_Text_3 <- null;
Info_Text_4 <- null;

Mission_Timer_Window <- null;
Mission_Timer_Text <- null;

function Load_Mission_GUI()
{
    Top_Label = ::GUILabel( ::VectorScreen( 10, 5 ), ::ScreenSize( 5, 5 ), ">-Stories of Liberty-<" );

    Top_Label.Visible = true;
    Top_Label.TextColour = Colour( 223, 223, 223 );
    Top_Label.FontSize = 9;
    Top_Label.FontName = "Arial";
    ::AddGUILayer( Top_Label );
    ::SendGUILayerToFront( Top_Label );

    Second_Label = ::GUILabel( ::VectorScreen( 10, 25 ), ::ScreenSize( 5, 25 ), "Mission: No Mission" );
    Second_Label.Visible = true;
    Second_Label.TextColour = Colour( 223, 223, 223 );
    Second_Label.FontSize = 9;
    Second_Label.FontName = "Arial";
    ::AddGUILayer( Second_Label );
    ::SendGUILayerToFront( Second_Label );

    Third_Label = ::GUILabel( ::VectorScreen( 10, 45 ), ::ScreenSize( 5, 45 ), "Mission: ID: None" );

    Third_Label.Visible = true;
    Third_Label.TextColour = Colour( 223, 223, 223 );
    Third_Label.FontSize = 9;
    Third_Label.FontName = "Arial";
    ::AddGUILayer( Third_Label );
    ::SendGUILayerToFront( Third_Label );



    Mission_Window = ::GUIWindow( ::VectorScreen( ::ScreenWidth - 135, ::ScreenHeight - 155 ), ::ScreenSize( 130, 80 ), "Personal Scoreboard" );
    Mission_Window.Titlebar = false;
    Mission_Window.Moveable = true;
    Mission_Window.Colour = ::Colour( 0, 0, 0 );
    Mission_Window.Visible = true;
    Mission_Window.Transparent = true;
    Mission_Window.Alpha = 123;
    ::AddGUILayer( Mission_Window );
    Mission_Window.AddChild( Top_Label );
    Mission_Window.AddChild( Second_Label );
    Mission_Window.AddChild( Third_Label );

    Info_Text_1 = ::GUILabel( ::VectorScreen( 1, 0 ), ::ScreenSize( 5, 5 ), "Welcome to Liberty Unleashed 0.1" );
    Info_Text_1.TextColour = ::Colour( 192, 192, 223 );
    Info_Text_1.FontSize = 15;

    Info_Text_2 = ::GUILabel( ::VectorScreen( 1, 20 ), ::ScreenSize( 5, 5 ), "Main Developer: Vrocker" );
    Info_Text_2.TextColour = ::Colour( 192, 192, 223 );
    Info_Text_2.FontSize = 15;

    Info_Text_3 = ::GUILabel( ::VectorScreen( 1, 40 ), ::ScreenSize( 5, 5 ), "Welcome to: Stories of Liberty" );
    Info_Text_3.TextColour = ::Colour( 192, 192, 223 );
    Info_Text_3.FontSize = 15;

    Info_Text_4 = ::GUILabel( ::VectorScreen( 1, 60 ), ::ScreenSize( 5, 5 ), "Owned by: Motley" );
    Info_Text_4.TextColour = ::Colour( 192, 192, 223 );
    Info_Text_4.FontSize = 15;

    Info_Window = ::GUIWindow( ::VectorScreen( ::ScreenWidth/300, ::ScreenHeight/180), ::ScreenSize( 400, 70 ), "Server Tips" );
    Info_Window.Titlebar = false;
    Info_Window.Moveable = true;
    Info_Window.Colour = ::Colour( 0, 0, 0 );
    Info_Window.Visible = true;
    Info_Window.AddChild( Info_Text_1 );
    Info_Window.AddChild( Info_Text_2 );
    Info_Window.AddChild( Info_Text_3 );
    Info_Window.AddChild( Info_Text_4 );
    Info_Window.Transparent = true;
    Info_Window.Alpha = 123;
    ::AddGUILayer( Info_Window );

    Mission_Timer_Text = ::GUILabel( ::VectorScreen( 100, 420 ), ::ScreenSize( 5, 5 ), "00:56" );
    Mission_Timer_Text.TextColour = ::Colour( 223, 115, 9 );
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