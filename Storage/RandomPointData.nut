
function PointToDirection(entity) {

  // We are storing each vector by its compass direction away from our entity
  local North = Vector(entity.Pos.x, entity.Pos.y+4, entity.Pos.z);
  local South = Vector(entity.Pos.x, entity.Pos.y-4, entity.Pos.z);
  local East = Vector(entity.Pos.x+4, entity.Pos.y, entity.Pos.z);
  local West = Vector(entity.Pos.x-4, entity.Pos.y, entity.Pos.z);

  local NorthEast = Vector(entity.Pos.x+3, entity.Pos.y+3, entity.Pos.z);
  local SouthEast = Vector(entity.Pos.x+3, entity.Pos.y-3, entity.Pos.z);

  local NorthWest = Vector(entity.Pos.x-3, entity.Pos.y+3, entity.Pos.z);
  local SouthWest = Vector(entity.Pos.x-3, entity.Pos.y-3, entity.Pos.z);
  
  // Some aray that gets each cord and sets the closest direction first, then second etc
  local MyCompass = [ North, South, East, West, NorthEast, SouthEast, NorthWest, SouthWest ]; 
  
  MyCompass.sort();
}

function Direction(x1, y1, x2, y2)
{
	//all values must be floats.
	x1 = x1.tofloat();
	x2 = x2.tofloat();
	y1 = y1.tofloat();
	y2 = y2.tofloat();
	// Added those ^ just in case you forget :P
	local m = (y2-y1)/(x2-x1);
	if ((m >= 6) || (m <= -6))
	{
		if (y2 > y1) return "North";
		else return "South";
	}
	if ((m < 6) && (m >= 0.5))
	{
		if (y2 > y1) return "North East";
		else return "South West";
	}
	else if ((m < 0.5) && (m > -0.5))
	{
		if (x2 > x1) return "East";
		else return "West";
	}
	else if ((m <= -0.5) && (m > -6))
	{
		if (y2 > y1) return "North West";
		else return "South East";
	}
}
  /* return a summed value of to MyCompass[0]  - MyCompass[1] get the n,e,s,w etc as a angle. Needs a angle conversion the code understands. Simple ;).
     Just get the right angle value to each cordinate e, w, s N etc. It will be slightly sloppy as I do not know enough math
	 probably needs pie lib
	 
     There will possibly be random twisting going on for some time in seconds but it's okay. That's from pointing to a sum of index 0 and 1.
	 Setting the angle and data could be excluded if the object stays inside a decent area of the path ;). 
	 I will create a distance function to ensure the player will try to recenter if something odd happens. 
	 Never will if you handle your shit right!! Just a oh no peice of code that should never get called :). You can add more shit to it if anything
	 
	 The summed value needs to favor index 0. We are using a summed value as we only have 7 angles as of now. There is no inbettween yet
*/

  /* 
  
  This is what needs to be done in the next part. One I just randomly stole the locals.. That might be okay. But I need to Find out which one was favored like North an NorthEast.
  In this case check that distance value. letting the major direction to point just a precent to the next will be choice! 
  
  index0 = 4, index1 = 9;
  offset = index0 - index1;
  
  offset = offset - rand() % offset 
  
  lol in this case offset could return 2. Setting the angle data first then a little offset after might be choice. Then there is a little jump towards that other direction. Some cool twisty stuff should happen
  We will get to see how the code auto handles the player from each vector they need to travel to. and it can not be so perfect as that is just gay okay. he needs to twist some 
  
  By god if you are reading this shit code please help. The process was figured out. If you understand and you could help me make this more right. Hopefully better
*/
}

function Players_First_Waypoint(player, Passed, Mission_ID, Jobing, No_Message) 
{
    //Passed = Message ID

    if (Passed == 0) 
    {
        //You "This is your Radar"
    }
    if (Passed == 1) 
    {
      //You "Your radar will notify you of where you need to go"

    }
    if (Passed == 2) 
    {
      //You "You can also find other handy places on your Radar"

    }
    if (Passed == 3) 
    {
      Mission_Message[player.ID].No_Message = true;

      //You "Go to the nearest waypoint"
      SetCinematicBorder( player, false ); // Clear the Border
      CreateMarker(player, 1271, -91.06, 15.15, 5)
      player.Frozen = false;    
      Mission_Animation[player.ID].Actor_Tick = 1;
    }
}