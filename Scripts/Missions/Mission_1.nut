ClientCode <- array(GetMaxPlayers(), 0);

class CMissionFunctions {
  function Start(Player) {
    print("Main function executed");
    return true;
  }
  
  function MissionSlot(Player, Slot) { 
    if (Slot == 0) { 
      print("Slot: " + Slot);
	return true;
  }
  
  Slot = -1;
} 

/*

  USAGE?
ClientCode[Player.ID] = CMissionFunctions();
ClientCode[Player.ID].Start(Player);
ClientCode[Player.ID].MissionSlot(Player, iD);

*/