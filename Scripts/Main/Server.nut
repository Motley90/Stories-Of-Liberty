// Updated 12/25/20

/* Colors */
GOLD_YELLOW <- Colour( 255, 200, 9 );
BRIGHT_WHITE <- Colour( 255, 255, 255 );
BRIGHT_RED <- Colour( 255, 0, 0 );
/* Colors */

/* Script Locations */
const ADMIN_LOCATION = "Scripts/Admin/";
const DEFAULT_BASE_LOCATION = "Scripts/";
const PNS_LOCATION = "Scripts/PNS/";
const BLIP_LOCATION = "Scripts/Blip-System/";
const MISSION_LOCATION = "Scripts/Missions/";
const PICKUP_LOCATION = "Scripts/Pickup System/";

/* Script Locations */

/* Script Loading */
function onScriptLoad()
{
	print("Server [Loading]");

	/* Load modules */
	LoadModule( "lu_hashing" );
	LoadModule( "lu_ini" );

	/* Load the command main file */
	dofile("Scripts/Main/Server-Commands.nut");

	/* Hash System */
	dofile(DEFAULT_BASE_LOCATION + "Hashing/Hash-Loading-Saving.nut");

	onHashTableLoad();
	/* Hash System */

	/* Admin System */
	dofile(ADMIN_LOCATION + "Admin.nut");	
	dofile(ADMIN_LOCATION + "Commands.nut");	
	/* Admin System */

	/* Pay and sprays */
	dofile(PNS_LOCATION + "PNS.nut");
	LoadPayNSprays();
	/* Pay and sprays */

	/* Blips */
	dofile(BLIP_LOCATION + "blips.nut");
	/* Blips */

	print("Server [Loaded]");

	/* Missions */
	dofile(MISSION_LOCATION + "Data/Mission_Loader.nut");
	Load_Missions_Scripts();

	RegisterRemoteFunc( "Call" )
	/* Missions */

	/* Pickups */
	dofile(PICKUP_LOCATION + "PickupHandler.nut");
	/* Pickups */

  	/* Reset the players online */
  	for (local i=0;i<GetMaxPlayers();i++) 
  	{
    	local player = FindPlayer(i);
    
    	if (player) 
    	{     
      		/* Force the player back to start */
      		player.ForceToSpawnScreen();
      		
      		/* Manually call the join event */
      		onPlayerJoin( player );
    	}
  	}
  	/* Reset the players online */

  	NewTimer(Second, 1000, 0);
}
/* Script Loading */

/* Script Unloading */
function onScriptUnload()
{
  /* Notify the console that the server has unloaded */
  print("Server [Unloaded]");

  /* Save all of the hash tables */
  SaveHashes();

  /* Reset the players online */
  for (local i=0;i<GetMaxPlayers();i++) 
  {
    local player = FindPlayer(i);
    
    if (player) 
    {     
     	/* Remove that player so they wont die */
     	if (player.Vehicle) player.RemoveFromVehicle();
     	
     	/* Notify any players online */ 
    }
    MessagePlayer("Server-Restarting!", player, 255, 0, 0);
  }
  	/* Reset the players online */
}
/* Script Unloading */

/* -------------------------------------------------------- */

/* Join Process */
function onPlayerJoin( pPlayer )
{
	Admin_Join_Process(pPlayer);

	Enter_Player_In_Missions( pPlayer );
}

/* Spawn Process */
function onPlayerSpawn(player, iclass)
{	
player.SetWeapon(2)
player.SetWeapon(3)
player.SetWeapon(4)
player.SetWeapon(5)
player.SetWeapon(6)
player.SetWeapon(7)
player.SetWeapon(8)
player.SetWeapon(9)
player.SetWeapon(10)
player.SetWeapon(11)
LoadMission("Scripts/Missions/Mission_" + 1 +".nut", player)
//Mission(player) // calls each slot
 Start(player)
 // end of mission
 CloseMission("Scripts/Missions/Mission_" + 1 +".nut")
  Start(player)

 }

/* Leaving Process */
function onPlayerPart( pPlayer, iReason )
{
	Admin[ pPlayer.ID ] = null;
	//Stat[ pPlayer.ID ] = null;
	Mission_Message[pPlayer.ID] = null;
	print("Objects before removed: " + GetObjectCount( ))
	Mission_Object[pPlayer.ID].RemoveAllObjects();
	print("Objects after removed: " + GetObjectCount( ))

	onPlayerPNSPart( pPlayer, iReason )

}


/* This is for when calling server functions all over the server, Update the name sometime. It's still okay to register 
more functions than just JobMessage. If you see code I set settings to prevent other code from hapening. Also verify that method as it's weird
but clear why I went that way
*/
function Call(player) 
{
 JobMessage(player);
}