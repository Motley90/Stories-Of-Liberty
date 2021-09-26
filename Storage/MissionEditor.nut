local MissionSlotStorage = []
local MemStorage = [];
EntityStorage <- [
["Player", "x", "y", "z", "Skin", "Angle", "Weapon", "World"],
["Vehicle", "Colour 1", "Colour 2", "Angle", "Not Running", "World"],
["Object", "x", "y", "z", "Angle", "World"],
["Pickup", "x", "y", "z", "One Time", "World"]
];
local EntityKey = {};

// Gui, Array keep map storage and readable data 
EntityStorage <- [
["Player", "x", "y", "z", "Skin", "Angle", "Weapon", "World"],
["Vehicle", "Colour 1", "Colour 2", "Angle", "Not Running", "World"],
["Object", "x", "y", "z", "Angle", "World"],
["Pickup", "x", "y", "z", "One Time", "World"]
];
local EntityKey = {};

// "Adding functionality for function types like the PlayerFunctions, VehicleFunctions, ObjectFunctions, PickupFunctions"
PlayerFunctions <- [
["WalkTo", "x", "y", "z"],
["GetPickup", "x", "y", "z", "Time", "Distance"],
["GetNearVehicle", "x", "y", "z", "Time", "Distance", "ID"],
["GetInVehicle", "Time", "ID"]
];

VehicleFunctions <- [
["MoveTo", "x", "y", "z", "Time", "ID"],
["Respray", "Colour 1", "Colour 2", "Fix Me?", "Delay Time"]
];

ObjectFunctions <- [
["Delete", "ID"],
["MoveTo", "x", "y", "z", "Time", "ID"],
["RotateTo", "x", "y", "z", "Time", "ID"]
];

CameraFunctions <- [
["Terminate"],
["PointTo", "x", "y", "z"],
["MoveTo", "x", "y", "z", "Time", "ID"],
["RotateTo", "x", "y", "z", "Time", "ID"]
];

PickupFunctions <- [
["Delete", "ID"],
["Create", "x", "y", "z", "Time", "ID"] 
];

function UpdateEntityData(...) {
   
  local iD = vargv[0], Key = vargv[1], Data = vargv[2];
  EntityKey.rawset(EntityStorage[iD][Key], MemStorage[iD].push(Data)) // Multipal shit can get pushed
  
}

// Testing randomly how the data from gui and array can be mapped around
UpdateEntityData(Slot, "Player", instance);
UpdateEntityData(Slot, "Skin", 5);
UpdateEntityData(Slot, "Angle", 0);
UpdateEntityData(Slot, "Weapon", 0);
UpdateEntityData(Slot, "World", 0);

function SendEntityData(Slot, Entity, func) {
	if ( Entity == "Player" ) {
      local Player = EntityKey.rawget(EntityStorage[Slot]["Player"])
	  local Angle = b .rawget(EntityStorage[Slot]["Angle"])
	  local X = EntityKey.rawget(EntityStorage[Slot]["x"])
	  local Y = EntityKey.rawget(EntityStorage[Slot]["y"])
	  local Z = EntityKey.rawget(EntityStorage[Slot]["z"])
      local Skin = EntityKey.rawget(EntityStorage[Slot]["Skin"])
      local Weapon = EntityKey.rawget(EntityStorage[Slot]["Weapon"])
      local World = EntityKey.rawget(EntityStorage[Slot]["World"])
	  
	  // Testing multipals
      local StorageCount = Player.len()
	  
	  local idx = 0;
	  while(idx != StorageCount) { 
	  
	    if ( func == "WalkTo" ) {
          CallServerFunc( "ScriptEditor/Main.nut", " MissionInterpreter", entity, func)
		  idx++;
        }
	}
	if ( Entity == "Object" ) {
      local Object = EntityKey.rawget(EntityStorage[Slot]["Object"])
	  local Angle = EntityKey.rawget(EntityStorage[Slot]["Angle"])
	  local X = EntityKey.rawget(EntityStorage[Slot]["x"])
	  local Y = EntityKey.rawget(EntityStorage[Slot]["y"])
	  local Z = EntityKey.rawget(EntityStorage[Slot]["z"])
      local World = EntityKey.rawget(EntityStorage[Slot]["World"])
	  
	  // Testing multipals
      local StorageCount = Object.len()
	  
	  local idx = 0;
	  while(idx != StorageCount) { 
        CallServerFunc( "ScriptEditor/Main.nut", "AddDataToMissionInterpreter", Entity, Slot, Object[idx] );
        CallServerFunc( "ScriptEditor/Main.nut", "AddDataToMissionInterpreter", Entity, Slot, X[idx] );
        CallServerFunc( "ScriptEditor/Main.nut", "AddDataToMissionInterpreter", Entity, Slot, Y[idx] );
        CallServerFunc( "ScriptEditor/Main.nut", "AddDataToMissionInterpreter", Entity, Slot, Z[idx] );
        CallServerFunc( "ScriptEditor/Main.nut", "AddDataToMissionInterpreter", Entity, Slot, Angle[idx] );
        CallServerFunc( "ScriptEditor/Main.nut", "AddDataToMissionInterpreter", Entity, Slot, World[idx] );
		idx++;
      }
	}
function UpdateMissionSlot(Slot) {
  MissionSlotStorage[Slot] = MemStorage;
  MemStorage.clear();
  // eh idk maybe extend MissionSlotStorage?
}
