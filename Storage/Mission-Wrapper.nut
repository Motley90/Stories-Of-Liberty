/* 
  Mission Wrapper
  Version: LU 
  Motley
  1/9/21
*/

// A table for key and value data
PlayerData <- {};
PlayerStorage <- [ [null], [null] ];

PlayerFunctions <- [
["WalkTo", "x1", "y1", "z1", "x2", "y2", "z2"],

["GetPickup", "x", "y", "z", "Time", "Distance", "ID", false, null, 0],

["GetNearVehicle", "x", "y", "z", "Time", "Distance", "ID"],
["GetInVehicle", "Time", "ID"]
["MissionFailed", "RestartTime", "Slot"]

];

// Slot pairing to the generated script, "Key: Player, Value: SlotID"
MissionDataCheckpoint <- {}

// Done
function MissionInterpreter(player, stringFunction, ...) {
	
  if ( stringFunction == "GetPickup" )  {
    local Pickup = CreatePickup(vargv[0], vargv[1], vargv[2], vargv[3]), local Time = vargv[4];
	PlayerData.rawset(PlayerStorage[player]["GetPickup"], PlayerFunctions["GetPickup", Pickup.Pos.x, Pickup.Pos.y, Pickup.Pos.z, Time, "No-Distance", Pickup.ID, false, NewTimer("GetPickup", 1000, 0, player, Time)] )
	
  }
  
}
// Done


// Done
function GetPickup(Player) {
  PlayerData.rawset(PlayerStorage[Player]["GetPickup"], PlayerFunctions["GetPickup", Pickup.Pos.x, Pickup.Pos.y, Pickup.Pos.z, Time, "No-Distance", Pickup.ID, true, NewTimer("GetPickup", 1000, 0, player, Time), Player])
  local Time = PlayerFunctions[4];
  local Timers = PlayerFunctions[8];
  local PickupOwnerShip = PlayerFunctions[7];
  
  Time--;
  
  if (Time == 0 || PickupOwnerShip == true) {
  
	if (PickupOwnerShip == false) {
	  MissionFailed(Player);
	}
	else { 
	  local SlotID = MissionDataCheckpoint.rawget(player) + 1;
	  MissionDataCheckpoint.rawset(player, SlotID);
	}
    Timers.Delete();
  }

}
// Done

// Done
function MissionFailed(Player) { 
  FadeCamera(Player, 5.0, true, 255, 0, 0 );
  ClearMessages(Player);
  SmallMessage(Player, "~r~Failed", 5000, 1 );
  NewTimer("MissionSlot", 1000, 0, Player, MissionDataCheckpoint.rawget(Player), 5)
  NewTimer("FadeCamera", 5000, 0, Player, 5.0, false, 255, 0, 0 )
}
// Done

// Done
function MissionPickup(Player, PickupID) {
	 local PickupOwnerShip = PlayerData.rawget(PlayerStorage[Player]["GetPickup"]), MissionPickup = PlayerData.rawget(PlayerStorage[Player]["GetPickup"]);
	 
	 if ( PickupID == MissionPickup[6]) {
	   PickupOwnerShip[7] = true;
	 }	 
}
// Done

