/*
  Edited: 11/22/2017
  *Motley

  Final Concept

  Added more classes, Sepperated..
*/

//------------------------------------------------

/* 
  Message Related System
*/
/*

Wrote by Motley


What is wrong with this shit. I really do not understand why the rotation is backwards. 
Is it just LU or what I mean damn why https://upload.wikimedia.org/wikipedia/commons/e/e9/Compass_rose.png

It shouldn't be backwards. Anyway there is a fix to it in the scripts. 

At the bottom of the page you will see some command. Put one vector on one side. And the next on the other. When you enter the command it will 
point to this vector. It's doggy and there was no real time way to add with atan. So fuck it. 

Since it's figured out I will try to do some more in depths

Please don't disappear if you are fucking with this as well. This is wasted time.. It's easier to work with me. We can save each others time.

if not regardless hope you find it useful
I could add up to 18 angles if I want really..
*/


/*
  Ripping out the heart of calculations.nut and rewritting :(
*/
Mission_Animation <- array(GetMaxPlayers());

class Animation{
  
  // This animation ID stops the players anim
  StopMe = 2;

  Current = 0;

  //The position we want them to go too
  To_Vector = null;

  // Tells the player some data to do. Reforces it's way back to zero
  Actor_Tick = 0;


  Moving = false

  function Walk_Slow(player) {
	  Stop(player);
	  
      Current = 0
      player.SetAnim(Current);
  }

  function Stop(player){
      player.SetAnim(StopMe);
  }
}

// This method can be removed as the right method was found
function PointToDirection(entity, Goto) {
  
  // Some array that gets each cord and sets the closest direction first, then second etc
  local MyCompass = [ 0, 1, 2, 3, 4, 5, 6, 7 ];
  local MyPoint = {};
 
  MyPoint.rawset(MyCompass[0] = GetDistance(Goto, Vector(entity.Pos.x, entity.Pos.y+4, entity.Pos.z)), "North" );
  MyPoint.rawset(MyCompass[1] = GetDistance(Goto, Vector(entity.Pos.x, entity.Pos.y-4, entity.Pos.z)), "South");
  MyPoint.rawset(MyCompass[2] = GetDistance(Goto, Vector(entity.Pos.x+4, entity.Pos.y, entity.Pos.z)), "East" );
  MyPoint.rawset(MyCompass[3] = GetDistance(Goto, Vector(entity.Pos.x-4, entity.Pos.y, entity.Pos.z)), "West");
  
  MyPoint.rawset(MyCompass[4] = GetDistance(Goto, Vector(entity.Pos.x+3, entity.Pos.y+3, entity.Pos.z)), "NorthEast");
  MyPoint.rawset(MyCompass[5] = GetDistance(Goto, Vector(entity.Pos.x+3, entity.Pos.y-3, entity.Pos.z)), "SouthEast");
  
  MyPoint.rawset(MyCompass[6] = GetDistance(Goto, Vector(entity.Pos.x-3, entity.Pos.y+3, entity.Pos.z)), "NorthWest");
  MyPoint.rawset(MyCompass[7] = GetDistance(Goto, Vector(entity.Pos.x-3, entity.Pos.y-3, entity.Pos.z)), "SouthWest");
  
  MyCompass.sort()
  entity.Angle = GetAngle(MyPoint.rawget(MyCompass[0]))
}

function GetAngle(Point) {
  if (Point == "North") return 0;
  if (Point == "West" ) return 90;
  if (Point == "South") return 180;
  if (Point == "East" )return 270;

  if (Point == "NorthWest" ) return 50;
  if (Point == "SouthEast" ) return 220;

  if (Point == "SouthWest" ) return 140;
  if (Point == "NorthEast" )return 310;
}

//------------------------------------------------

Mission_Message <- array(GetMaxPlayers());

class Next_Message 
{
	// The ID of the message read
  Passed = 0;
	
  // Where we store messages
  Messages = "";

  No_Message = false;
}

//------------------------------------------------

/*
  Player has entered a Mission
*/

Mission_Chapter <- array(GetMaxPlayers());

class Mission 
{
  // The ID of the Mission
  Mission_ID = 0;

  // Are they currently doing work
  Jobing = false;

  // Where was the last restore point
  Checkpoint = 0;

  CameraTime = 0;
}

//------------------------------------------------

// Get's called to set the player to our mission system
function Enter_Player_In_Missions( Player )
{
  Mission_Message[Player.ID] = Next_Message();
  Mission_Chapter[Player.ID] = Mission();
  Mission_Animation[Player.ID] = Animation();
  Mission_Object[Player.ID] = AddObject();
}

//------------------------------------------------

function Second() {     
  // Hear we specify our missions name
  //Introduction_Mission()
}
