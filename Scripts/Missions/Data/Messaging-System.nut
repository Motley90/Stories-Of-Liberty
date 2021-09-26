// This system is just too old for the system. It needs a update
function JobMessage(player) 
{
  /* Starts at 0 and updates */
  //Mission_Message[player.ID].Passed ++;
  local message = Mission_Message[player.ID].Passed;

  // Prevent the player from creating er

  /* Clear any messages before the next */
  ClearMessages(player);

  /* Now notify them */

  if (Mission_Message[player.ID].No_Message == true) return 0; /* Cancel these messages */

  if (Mission_Chapter[player.ID].Mission_ID == 0)
  {

    // Message is called first
    SmallMessage( player, Mission_Message[player.ID].Messages[message], 5000, 1 )
    
    // Call to the mission
    //The_Bum(Player, Passed, Mission_ID, Jobing, No_Message) 
    The_Bum_Talks_To_Darkel(player, Mission_Message[player.ID].Passed, 0, true, Mission_Message[player.ID].No_Message) 

    // Increase what they passed
    Mission_Message[player.ID].Passed++;

    return true;
  }

  if (Mission_Chapter[player.ID].Mission_ID == 1)
  {
    // Message is called first
    SmallMessage( player, Mission_Message[player.ID].Messages[message], 5000, 1 )
    
    // Call to the mission
    Players_First_Waypoint(player, Mission_Message[player.ID].Passed, 1, true, Mission_Message[player.ID].No_Message) 
   
    Mission_Message[player.ID].Passed++;
    
    return true;
  }

  if (Mission_Chapter[player.ID].Mission_ID == 2)
  {
    // Message is called first
    SmallMessage( player, Mission_Message[player.ID].Messages[message], 5000, 1 )
    
    // Call to the mission
    The_Bum_And_Darkel_Talk_To_8Ball(player, Mission_Message[player.ID].Passed, 2, true, Mission_Message[player.ID].No_Message) 
   
    Mission_Message[player.ID].Passed++;
    
    return true;
  }
  
  //SmallMessage( player, Mission_Message[player.ID].Messages[message], 5000, 1 )
}
