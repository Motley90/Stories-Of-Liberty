/*

Notes:

Was going to use a switch statement, 
but you have to use break + return true in Squirrel for the code to stop ....
*/

Mission_Object <- array(GetMaxPlayers()); 

class AddObject{

  /* Name's will change as more objects are created in the server */

  // 8 ball These will never change, Maybe a few objects might get added
  Balls_Land_Object_ID = null; // 8-Ball's house [524]
  Balls_Door_Object_ID = null; // 8-Ball's door [531]
  Balls_House_Object_ID = null // 8-Ball's house land [598]

  // Homeless tunnel 
  Barrel_with_coals = null; // [1341]

  // Safe-houses
  Ramp_Wall = null; // rear wall in portland near Sals place [1230]
  Safe_House_Interrior = null //Near Sals [290]

  function AddObject(model, x, y, z, angle_x, angle_y, angle_z, World) {
  	// 8-Ball's house [524] 
  	if ( model == 524) {
  		if ( Balls_Land_Object_ID != null ) {
  			// I hope this never prints
  			::print("[Error] Balls land already existed");
  			print("Located in " + ::GetDistrictName( x, y ));

  			return true;
  		}
  		
  		print("Located in " + ::GetDistrictName( x, y ));
  		local object = ::CreateObject(model, Vector(x, y, z ));
  		object.Angle = Vector(angle_x, angle_y, angle_z);
  		Balls_Land_Object_ID = object.ID;
  		object.VirtualWorld = World; 

  		return true;
  	}
  	
  	// 8-Ball's door [531] 	
  	if ( model == 531) {
  		if ( Balls_Door_Object_ID != null ) {
  			// I hope this never prints
  			::print("[Error] Balls door already existed");
  			print("Located in " + ::GetDistrictName( x, y ));

  			return true;
  		}
  		
  		print("Located in " + ::GetDistrictName( x, y ));
  		local object = ::CreateObject(model, Vector(x, y, z ));
  		object.Angle = Vector(angle_x, angle_y, angle_z);
  		Balls_Door_Object_ID = object.ID;
  		object.VirtualWorld = World; 

  		return true;
  	}

  	// 8-Ball's house land [598]		
  	if ( model == 598) {
  		if ( Balls_House_Object_ID != null ) {
  			// I hope this never prints
  			::print("[Error] Balls house already existed");
  			print("Located in " + ::GetDistrictName( x, y ));

  			return true;
  		}
  		
  		print("Located in " + ::GetDistrictName( x, y ));
  		local object = ::CreateObject(model, Vector(x, y, z ));
  		object.Angle = Vector(angle_x, angle_y, angle_z);
  		Balls_House_Object_ID = object.ID;
  		object.VirtualWorld = World; 

  		return true;
  	}
  	
  	if ( model == 1341) {
  		if ( Barrel_with_coals != null ) {
  			// I hope this never prints
  			::print("[Error] Barrel with coal already existed");
  			print("Located in " + ::GetDistrictName( x, y ));

  			return true;
  		}
  		
  		print("Located in " + ::GetDistrictName( x, y ));
  		local object = ::CreateObject(model, Vector(x, y, z ));
  		object.Angle = Vector(angle_x, angle_y, angle_z);
  		Barrel_with_coals = object.ID;
  		object.VirtualWorld = World; 

  		return true;
  	}
  	
  	// Ramp wall - Safe house related 
  	if ( model == 1230) {
  		if ( Ramp_Wall != null ) {
  			// I hope this never prints
  			::print("[Error] Ramp wall already existed");
  			print("Located in " + ::GetDistrictName( x, y ));

  			return true;
  		}
  		
  		print("Located in " + ::GetDistrictName( x, y ));
  		local object = ::CreateObject(model, Vector(x, y, z ));
  		object.Angle = Vector(angle_x, angle_y, angle_z);
  		Ramp_Wall = object.ID;
  		object.VirtualWorld = World; 

  		return true;
  	}

  	// Safe house interior - Same house related 
  	if ( model == 290) {
  		if ( Safe_House_Interrior != null ) {
  			// I hope this never prints
  			::print("[Error] Safe house already existed");
  			print("Located in " + ::GetDistrictName( x, y ));

  			return true;
  		}
  		
  		print("Located in " + ::GetDistrictName( x, y ));
  		local object = ::CreateObject(model, Vector(x, y, z ));
  		object.Angle = Vector(angle_x, angle_y, angle_z);
  		Safe_House_Interrior = object.ID;
  		object.VirtualWorld = World; 

  		return true;
  	}
  }  
  
  function Load_Barrel_with_coals(player, World) 
  {
    // Barrel_with_coals
	CreateFire(Vector(1319.9, -194.21, 15.69), 0.5);
    AddObject(1341, 1319.9, -194.24, 14.78, 0.00, 0.00, 0.00, World);

    return true;
  }

  function Remove_Barrel_with_coals(player) 
  {
    // Barrel_with_coals
    RemoveObject(Barrel_with_coals)

    Barrel_with_coals = null;

    return true;
  }

  function Open_8_Balls_Door() {
  	
  	local pObject = ::FindObject(Balls_Door_Object_ID)
  	
  	if (pObject ) {
  		pObject.RotateTo( Vector( 0.00, 0.00, 220 ), 50.0 )
    }
   }

  function Close_8_Balls_Door() {
  	
  	local pObject = ::FindObject(Balls_Door_Object_ID)
  	
  	if (pObject ) {
  		pObject.RotateTo( Vector( 0.00, 0.00, 359 ), 50.0 );
    }
   }

  function Load_8_Balls_Place(player, World) 
  {
    AddObject(598, 1275.74, -95.7046, 49.7042, 0.00, 0.00, 270, World);
    AddObject(524, 1266.69, -96.5937, 56.848, 0.00, 0.00, 0.00, World);
    AddObject(531, 1271.46, -90.6476, 54.4926, 0.00, 0.00, 359, World);

    return true;
  }

  function Remove_8_Balls_Place(player) 
  {
    RemoveObject(Balls_Land_Object_ID)
    RemoveObject(Balls_Door_Object_ID)
    RemoveObject(Balls_House_Object_ID)
  

  	Balls_Land_Object_ID = null; // 8-Ball's house [524]
 	Balls_Door_Object_ID = null; // 8-Ball's door [531]
  	Balls_House_Object_ID = null // 8-Ball's house land [598]

    return true;
  }

  function Load_Sait_Marks_Safe_House(player, World) 
  {
    // Room Interior
    AddObject(290, 1347.6, -319.325, 53.82, 0.00, 0.00, 0.00, World);

    // Back Wall Vector( 179.5, 99.5, 0 )
    AddObject(1230, 1343.9, -317.87, 54.82, 179.5, 99.5, 0.00, World );

    return true;
  }

  function Remove_Sait_Marks_Safe_House(player) 
  {
    // Room Interior
    RemoveObject(Safe_House_Interrior)

    // Back Wall
    RemoveObject(Ramp_Wall)

    Safe_House_Interrior = null;

    Ramp_Wall = null

    return true;
  }

  function RemoveObject(object) {
  	
  	local pObject = ::FindObject(object)
  	
  	if (pObject != null ) {
  		pObject.Remove();
    }
   }
  function RemoveAllObjects() {
  	  	
  	if (Balls_Land_Object_ID != null ) {
  		local pObject = ::FindObject(Balls_Land_Object_ID)
  		pObject.Remove();
    }
  	
  	if (Balls_Door_Object_ID != null ) {
  		local pObject = ::FindObject(Balls_Door_Object_ID)
  		pObject.Remove();
    }
  	
  	if (Balls_House_Object_ID != null ) {
  		local pObject = ::FindObject(Balls_House_Object_ID)
  		pObject.Remove();
    }
  	  	
  	if (Barrel_with_coals != null ) {
  		local pObject = ::FindObject(Barrel_with_coals)
  		pObject.Remove();
    }
  	
  	if (Ramp_Wall != null ) {
  	  	local pObject = ::FindObject(Ramp_Wall)
  		pObject.Remove();
    }
  	
  	if (Safe_House_Interrior != null ) {
  		local pObject = ::FindObject(Safe_House_Interrior)
  		pObject.Remove();
    }

  	
    // Clear the class
  	// 8 ball These will never change, Maybe a few objects might get added
  	Balls_Land_Object_ID = null; // 8-Ball's house [524]
  	Balls_Door_Object_ID = null; // 8-Ball's door [531]
  	Balls_House_Object_ID = null // 8-Ball's house land [598]

 	// Homeless tunnel 
  	Barrel_with_coals = null; // [1341]

  	// Safe-houses
  	Ramp_Wall = null; // rear wall in portland near Sals place [1230]
  	Safe_House_Interrior = null //Near Sals [290]
   }
}

