/* These commands are for admins only */

/*
NOTES: Please keep all code nicely spaced and easy to read as well easy to edit
*/

function ADMIN_AUTHORITY_COMMANDER( pPlayer, szCommand, szParams )
{
 
 if ( Admin[ pPlayer.ID ].Registration == true )
 {	
   /* For when a player has the oppertunity to become an Admin */
  if (szCommand == "register") 
  {
    
    /* User never entered a Password */
    if (!szParams) {
       MessagePlayer( "Register account: /register [password]", pPlayer, BRIGHT_RED);
       return true;
    }
    
	/* Store the password locally one time, Access the rights from the ini file */
	local string = ReadIniString(ADMIN_LOCATION + "Accounts/Admin.ini", pPlayer.Name.tolower(), "Password");
    local Admin_Access = ReadIniBool(ADMIN_LOCATION + "Accounts/Admin.ini", pPlayer.Name.tolower(), "Access");
    
    /* If the file does not have a bool it will return false as we were set to get a bool "Shouldnt of been able to get hear..." */
    if (Admin_Access == false) {
       MessagePlayer( "You do not have access to be an admin", pPlayer, BRIGHT_RED);
       return true;    
    }

    /* There is already a password registered inform them */
    if (string != "") {
       MessagePlayer( "You already registered", pPlayer, BRIGHT_RED);
       
       /* But they have an admin account let them know they can change there password */
       if (Admin_Access == true) MessagePlayer("But you are able to change your password! /password [new-password]", pPlayer, 255, 0, 0);
       return true;    
    }
    
    /* The player made it this far without any errors, Register that player! */
    Register_Admin(pPlayer, szParams);
          
    return true;
  }
  /* For when A player has the oppertunity to become an Admin */

  /* For when an admin re-joins a server */
  if (szCommand == "login") {
    
    /* User never entered a Password */
    if (!szParams) {
       MessagePlayer( "login account: /login [password]", pPlayer, BRIGHT_RED);
       return true;
    }
    
	/* Store the password locally one time, Access the rights from the ini file */
	local string = ReadIniString(ADMIN_LOCATION + "Accounts/Admin.ini", pPlayer.Name.tolower(), "Password");
    local Admin_Access = ReadIniBool(ADMIN_LOCATION + "Accounts/Admin.ini", pPlayer.Name.tolower(), "Access");

    /* If the file does not have a bool it will return false as we were set to get a bool "Shouldnt of been able to get hear..." */
    if (Admin_Access == false) {
       MessagePlayer( "You do not have access to be an admin", pPlayer, BRIGHT_RED);
       return true;    
    }
    
    if (MD5(szParams) != string) 
    {
       MessagePlayer( "Wrong password", pPlayer, BRIGHT_RED);
       return true;    
    }

    /* Let them know they have the rights to be an admin but they must register! */
    if (string == "") {
       MessagePlayer( "You do not have a admin account", pPlayer, BRIGHT_RED);
       if (Admin_Access == true) MessagePlayer("But you are able to register for admin! /register [password]", pPlayer, 255, 0, 0);
       return true;    
    }
    
    /* The player made it this far without any errors, Log that player! */
    Login_Admin(pPlayer, szParams);
          
    return true;
  }
  /* For when an admin re joins a server */

 }
 /* Stop any non admins from entering these commands */
 if ( Admin[ pPlayer.ID ].Access == true )
 {	

	/* This is where our real admin commands exist */

  /* For giving players authority */
  if ( szCommand == "setadmin" )
  {
		if ( Admin[ pPlayer.ID ].Setadmin == true )
		{
			szParams = split( szParams, " " );
			if ( szParams )
			{
					local pTarget = GetPlayer( szParams[ 0 ] ), bool = szParams[ 1 ];
					if ( pTarget )
					{
						Give_Admin_Authoriety(pPlayer, pTarget, bool);
					}
					else MessagePlayer( "Error - Unknown Nick/ID", pPlayer, GOLD_YELLOW );
			}
			else MessagePlayer( "Error - Required syntax: /" + szCommand + " <player>", pPlayer, GOLD_YELLOW );
		}
		return true;
	}

  if ( szCommand == "ghost" ) 
  {
	  
	if ( Admin[ pPlayer.ID ].Ghost == true )
	{	
		local alpha = pPlayer.Alpha;
	  
		if ( alpha ) {
	  		pPlayer.Alpha = 0;
	  		pPlayer.Nametag = false;
	  		pPlayer.Marker = false;

	  		return true;
		}
		else 
		{
	  		pPlayer.Alpha = 255;
	  		pPlayer.Nametag = true;
	  		pPlayer.Marker = true;
	  		return true;
		}
	}
   
    return true;
  }


  if (szCommand == "restart" || szCommand == "rs") 
  {
    if (Admin[ pPlayer.ID ].Restart == true) 
    {
      	ReloadScripts();
      	return true;
    }
    return true;
  }
  
  if ( szCommand == "surface" )
  {
    if ( Admin[ pPlayer.ID ].Surface == true )
	{
		local iValue = 4.5;
		if ( szParams ) iValue = szParams.tofloat();
		SetSurfaceTraction( 10, iValue );
		return true;
	}
    
    MessagePlayer("The command /"+szCommand+" does not exist", pPlayer, 255, 0, 0);
    return true;
  }

  if ( szCommand == "gamespeed" )
  {
     if ( Admin[ pPlayer.ID ].Gamespeed == true )
	 {
	    local iValue = 1;
		if ( szParams ) iValue = szParams.tofloat();
		SetGamespeed( iValue );

		return true;
	}
  }
  
  if ( szCommand == "gravity" )
  {
     if ( Admin[ pPlayer.ID ].Gravity == true )
	 {
		 local iValue = 0.008;
		 if ( szParams ) iValue = szParams.tofloat();
		 SetGravity( iValue );

			return true;
		}

		return true;
	}
	if ( szCommand == "comeflywithme" )
	{
		if ( Admin[ pPlayer.ID ].Comeflywithme == true )
		{
			if ( !GetFlyingCars() ) SetFlyingCars( true );
			else SetFlyingCars( false );

			return true;
		}

		return true;
	}
	
	if ( szCommand == "kick" )
	{
		if ( Admin[ pPlayer.ID ].Kick == true )
		{
			if ( szParams )
			{
				szParams = split( szParams, " " );
				if ( szParams.len() > 1 )
				{
					if ( szParams[ 1 ] )
					{
						local pTarget = GetPlayer( szParams[ 0 ] );
						if ( pTarget )
						{
							Message( pPlayer + " has kicked:[ " + pTarget + " ] Reason:[ " + szParams[ 1 ] + " ]", Colour( 255, 200, 90 ) );
							KickPlayer( pTarget );
						}
						else MessagePlayer( "Error - Unknown Nick/ID", pPlayer, GOLD_YELLOW );
					}
					else MessagePlayer( "Error - Required syntax: /" + szCommand + " <player> <reason>", pPlayer, GOLD_YELLOW );
				}
				else MessagePlayer( "Error - Required syntax: /" + szCommand + " <player> <reason>", pPlayer, GOLD_YELLOW );
			}
			else MessagePlayer( "Error - Required syntax: /" + szCommand + " <player> <reason>", pPlayer, GOLD_YELLOW );
		}
	}
	
	if ( szCommand == "ban" )
	{
		if ( Admin[ pPlayer.ID ].Ban == true )
		{
			if ( szParams )
			{
				local pTemp = split( szParams, " " );
				if ( pTemp.len() > 1 )
				{
					if ( pTemp[ 1 ] )
					{
						local pTarget = GetPlayer( pTemp[ 0 ] );
						if ( pTarget )
						{
							Message( pPlayer + " has banned:[ " + pTarget + " ] Reason:[ " + pTemp[ 1 ] + " ]", Colour( 255, 200, 90 ) );
							BanLUID( pTarget.LUID );
							KickPlayer(pTarget);
						}
						else MessagePlayer( "Error - Unknown Nick/ID", pPlayer, GOLD_YELLOW );
					}
					else MessagePlayer( "Error - Required syntax: /" + szCommand + " <player> <reason>", pPlayer, GOLD_YELLOW );
				}
				else MessagePlayer( "Error - Required syntax: /" + szCommand + " <player> <reason>", pPlayer, GOLD_YELLOW );
			}
			else MessagePlayer( "Error - Required syntax: /" + szCommand + " <player> <reason>", pPlayer, GOLD_YELLOW );
		}
	}
 }
}