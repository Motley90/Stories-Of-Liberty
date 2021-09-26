//-----------------------------------------------------------------------

local BlobSlotIndex = [""];
function AddFunctionToSlot(Slot, StringFunc) { 
  local Data = BlobSlotIndex[Slot];
  Data += "    " + StringFunc + " \n";
  
  BlobSlotIndex.insert(Slot, Data);
  // Will add shit like  "MissionInterpreter(Player, "SetPosition", 1320, -197, 15.28) "
}

function SlotStorageIncrease(Slot) {
  BlobSlotIndex.resize(Slot, "")
}

//------------------------------------------------------------------------------

/*
  Main function in mission script
  -Visuals, Loading weps, cars, whatever..
*/
  function WriteStart(Filename, Data) {
  WriteFunctionName(Filename, "Start", "")
  local myfiles = file(Filename, "a+");


  myfiles.writen(Data, 'b');
  local End = "}\n";
  
  myfiles.writen(End, 'b'); 
  myfiles.writen('\n', 'b');
  myfiles.flush();
  myfiles.close();
		   
  return true;
}

function WriteFunctionName(Filename, StringName, Args) {
  
  local myFunc = "function " + StringName + "("+Args+") { \n";

  local myfiles = file(Filename, "a+");
     
  myfiles.writen(myFunc, 'b'); 

  myfiles.flush();
  myfiles.close();
}

/*
  Slot function "MissionSlot" is in mission script
  This function gets hammered overtime data is needed from that slot
  That could be creating a new sphere or deleting it. For weps as well, cars to whatever..
*/
function WriteSlotFunctions(Filename, Data, Slot) {
  WriteFunctionName(Filename, "MissionSlot", "Player, Passed");

  local myfiles = file(Filename, "a+");
  
  local SlotWrite = "  if (Passed == " + Slot + ") { \n"; 
  local End1 = "  }\n";
  local End2 = "  return true;\n"
  local End3 = "}\n";
  
  myfiles.writen(SlotWrite, 'b'); 
  myfiles.writen(Data, 'b');


  myfiles.writen(End1, 'b'); 
  myfiles.writen(End2, 'b'); 
  myfiles.writen(End3, 'b'); 
  myfiles.flush();
  myfiles.close();
		   
  return true;
}


//------------------------------------------------------------------------------

