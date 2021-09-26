/*
	Pay'n'Spray
	--------------------------------------------------
	This is a script which enables Pay'n'Sprays in LU.
	
	Author: Juppi
*/

// Settings
SPHERE_COLOUR <- ::Colour( 25, 25, 255 );
const SPHERE_RADIUS = 3.0;
const GARAGE_RADIUS = 15.0; // Garage activation radius

enum VEHICLE_TYPE
{
	NORMAL, // Normal vehicles which can be re-sprayed
	EMERGENCY, // Emergency vehicles
	NOTFORGARAGE, // Too big/not supported vehicles
};

// Storage
const MAX_GARAGES = 3;
g_Garages <- array( MAX_GARAGES, null );


function LoadPayNSprays()
{
	print( "Liberty Unleashed Pay'n'Spray script loaded" );
	
	// Install the Pay'n'Sprays
	InitGarages();
	
	// Set up a constant timer to process the garages
	NewTimer( ProcessGarages, 750, 0 );
	
	return 1;
}

/*
 * A storage class for garage information.
 * This includes static data like position etc. but also the status of the garage
 */
class CPayNSpray
{
	// Construct a new garage
	function constructor( id, pos, campos, camlookat )
	{
		ID = id;
		Pos = pos;
		CamPos = campos;
		CamLookAt = camlookat;
				
		local sphere = ::CreateSphere( pos, SPHERE_RADIUS, ::SPHERE_COLOUR );
		if ( sphere )
		{
			sphere.Type = ::MARKER_TYPE_VEHICLE;
			Sphere = sphere.ID;
		}
	}
	
	// The GTA ID of this garage
	ID = 0;
	
	// Garage position used for processing.
	// This is also the sphere position inside the garage
	Pos = null;
	
	// Camera settings - we don't want the camera to be inside the garage
	CamPos = null;
	CamLookAt = null;
	
	// The ID of the sphere inside the garage
	Sphere = 0;
	
	// Is the garage door open or closed?
	IsOpen = false;
	
	// Is this garage processing any vehicle at the moment?
	IsProcessingVehicle = false;
	
	// How long has the vehicle been processed? (Required by some timed stuff)
	Time = 0;
	
	// The player/vehicle who/which are being processed
	Player = null;
	Vehicle = null;
}

/*
 * This function initialises the garages and sets their info.
 */
function InitGarages()
{
	g_Garages[ 0 ] = CPayNSpray( PORTLAND_PAYNSPRAY_GARAGE, Vector( 925.3, -361.9, 10.8 ), Vector( 925.9, -335.9, 14.3 ), Vector( 925.5, -346.4, 14.3 ) ); // Portland PnS
	g_Garages[ 1 ] = CPayNSpray( STAUNTON_PAYNSPRAY_GARAGE, Vector( 382.4, -493.6, 25.7 ), Vector( 362.2, -492.2, 27.8 ), Vector( 369.6, -493.0, 27.8 ) ); // Staunton PnS
	g_Garages[ 2 ] = CPayNSpray( SSV_PAYNSPRAY_GARAGE, Vector( -1144.4, 35.1, 58.8 ), Vector( -1126.2, 33.6, 61.9 ), Vector( -1132.2, 33.9, 61.3 ) ); // Shoreside PnS
}

/*
 * This func finds and returns a garage based on the sphere ID
 */
function FindGarage( sphereID )
{
	for ( local i = 0; i < MAX_GARAGES; i++ )
	{
		if ( g_Garages[ i ].Sphere == sphereID ) return g_Garages[ i ];
	}
	
	return null;
}

/*
 * Processing of the garages. Almost everything is done here, including
 * automatic doors etc.
 */
function ProcessGarages()
{
	local players = GetPlayers();
	
	if ( !players ) return; // No point in processing if there are no players in-game
	
	// Vars used by the processing loop
	local garage = null;
	local player = null, id = 0, plrs = 0;
	local needsopening = false;
	
	for ( local i = 0; i < MAX_GARAGES; i++ )
	{
		garage = g_Garages[ i ];
		
		// If the garage is not processing a vehicle right now, process automatic doors
		if ( !garage.IsProcessingVehicle )
		{
			player = null;
			id = 0;
			plrs = 0;
			needsopening = false;
			
			while ( id < MAX_PLAYERS && plrs < players )
			{
				player = FindPlayer( id );
				if ( player && player.Spawned )
				{
					// Check if the player is within the activation radius of this garage
					if ( GetDistance( player.Pos, garage.Pos ) < GARAGE_RADIUS )
					{
						// If so, and they're in a vehicle, flag the garage to be opened after the loop
						if ( player.Vehicle ) needsopening = true;
					}
					plrs++;
				}
				id++;
			}
			
			// Process the door if needed
			if ( garage.IsOpen && !needsopening )
			{
				CloseGarage( garage.ID );
				garage.IsOpen = false;
			}
			else if ( !garage.IsOpen && needsopening )
			{
				OpenGarage( garage.ID );
				garage.IsOpen = true;
			}
		}
		
		// If the garage is processing a car, do some timed stuff
		else
		{
			garage.Time++;
			
			if ( garage.Time == 6 )
			{
				if ( garage.Vehicle.Health < 1000.0 )
					SmallMessage( garage.Player, "~b~New engine and paint job. The cops won't recognize you!", 3000, 0 );
				
				else SmallMessage( garage.Player, "~b~Hope you like the new color.", 3000, 0 );
				
				PlayFrontEndSound( garage.Player, 61 );
				
				// Fix the vehicle and respray it
				garage.Vehicle.Fix();
				
				// This should create some really funky colours
				garage.Vehicle.RGBColour1 = Colour( rand() % 256, rand() % 256, rand() % 256 );
				garage.Vehicle.RGBColour2 = Colour( rand() % 256, rand() % 256, rand() % 256 );
				
				// Ready! Release the player and open the door
				garage.Player.Frozen = false;
				
				RestoreCamera( garage.Player );
			
				garage.IsProcessingVehicle = false;
				garage.Player = null;
				garage.Vehicle = null;
				garage.Time = 0;
				garage.IsOpen = true;
				
				OpenGarage( garage.ID );
			}
		}
	}
}

/*
 * If the player enters a sphere we need to check whether
 * it's a garage sphere
 */
function onPlayerEnterSphere( player, sphere )
{
	// Check if this is a global sphere and assigned to a garage
	if ( !sphere.Owner )
	{
		local garage = FindGarage( sphere.ID );
		if ( garage )
		{
			local vehicle = player.Vehicle;
			
			// Check that the event was triggered by the vehicle driver
			if ( player.ID == vehicle.Driver.ID )
			{
				local type = GetVehicleType( vehicle.Model );
				if ( type == VEHICLE_TYPE.NORMAL )
				{
					// This is a normal vehicle - we can respray it
					
					// Freeze the player
					player.Frozen = true;
					
					// Set some garage stuff for the process func
					garage.IsProcessingVehicle = true;
					garage.Player = player;
					garage.Vehicle = player.Vehicle;
					garage.IsOpen = false;
					
					SetCameraMatrix( player, garage.CamPos, garage.CamLookAt );
					
					CloseGarage( garage.ID );
				}
				else if ( type == VEHICLE_TYPE.EMERGENCY )
				{
					SmallMessage( player, "~b~Whoa! I don't touch nothing THAT hot!", 3000, 0 );
					
					PlayFrontEndSound( player, 60 );
				}
			}
		}
	}
	
	return 1;
}

/*
 * Security check that the player didn't leave while they were in a garage
 */
function onPlayerPNSPart( player, iReason )
{
	local garage = null;
	for ( local i = 0; i < MAX_GARAGES; i++ )
	{
		garage = g_Garages[ i ];
		
		if ( garage.Player && garage.Player.ID == player.ID )
		{
			garage.IsProcessingVehicle = false;
			
			garage.Player = null;
			garage.Vehicle = null;
			
			garage.Time = 0;
		}
	}
	
	return 1;
}

/*
 * This function returns the type of the given vehicle model
 */
function GetVehicleType( model )
{
	switch ( model )
	{
	// These vehicles are too big/otherwise not suitable for Pay'n'Spray. Don't process them
	case VEH_LINERUNNER:
	case VEH_TRASHMASTER:
	case VEH_STRETCH:
	case VEH_PREDATOR:
	case VEH_BUS:
	case VEH_TRAIN:
	case VEH_DODO:
	case VEH_COACH:
	case VEH_RCBANDIT:
	case VEH_AIRTRAIN:
	case VEH_DEADDODO:
	case VEH_SPEEDER:
	case VEH_REEFER:
	case VEH_ESCAPE:
	case VEH_GHOST:
		return VEHICLE_TYPE.NOTFORGARAGE;
		break;
	
	// Emergency/army vehicles - Pay'n'Spray don't want to touch nothing that hot
	case VEH_FIRETRUCK:
	case VEH_AMBULANCE:
	case VEH_FBICAR:
	case VEH_POLICE:
	case VEH_ENFORCER:
	case VEH_RHINO:
	case VEH_BARRACKS:
		return VEHICLE_TYPE.EMERGENCY;
		break;
	
	// Everything else is OK
	default:
		return VEHICLE_TYPE.NORMAL;
		break;
	}
}
