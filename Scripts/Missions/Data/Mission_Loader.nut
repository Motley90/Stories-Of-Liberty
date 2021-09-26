

function Load_Missions_Scripts() 
{
	//------------------------------------------------

	/* How we change messages and recieve them */
	dofile(MISSION_LOCATION + "Data/Messaging-System.nut");

	/* How we calculate missions */
	dofile(MISSION_LOCATION + "Data/Calculations.nut");

	/* Outdated asf. Just pretend this doesnt exist  */
	dofile(MISSION_LOCATION + "Data/Mission-Object-Loader.nut");

	//------------------------------------------------
}

local MyRootTable = null;
local filedata = "";
// Gets called each time
function Mission(player) {
  MissionSlot( player, 4)
}

// Our load mission script function
function LoadMission(Script, player) {
  
  MyRootTable = loadfile(Script, true)
  MyRootTable();

}
// Our close script mission function
function CloseMission(Script) {
	writeclosuretofile(Script, MyRootTable)
	MyRootTable = null
	collectgarbage()
}  

