/*
	Beta Script - Admin script used for the LU server
*/

Admin <- array( GetMaxPlayers());

class Admin_Class 
{
	/* Command Usage */
	Registration = false; // Ability to login and Register
	Ban = false; // Ability to Ban
	Kick = false; // Ability to Kick
	MessageAll = false; // Ability to Message everyone

	Ghost = false; // Ability to be transparent
	Restart = false; // Ability to restart server
	Surface = false; // Ability to change traction
	Gamespeed = false; // Ability to change the speed of gameplay
	Gravity = false; // Ability to change the density of air
	Comeflywithme = false; // Ability to make cars fly
	Setadmin = false; // Ability to give players admin
	/* Command Usage */

	Access = false; // Ability to be an admin and have authority!
}

/* -------------------------------------------------------- */

function Admin_Join_Process(Player) 
{
	Admin[Player.ID] = Admin_Class();
	
	local Admin_Access = ReadIniBool(ADMIN_LOCATION + "Accounts/Admin.ini", Player.Name.tolower(), "Access");

	if (Admin_Access == true)
	{
		MessagePlayer("Welcome Admin, Please login to your admin account", Player, 255, 0, 0);
		Admin[ Player.ID ].Registration = true;
	}

	return true;
}

function Register_Admin(Player, Password)
{
	// Password
	WriteIniString(ADMIN_LOCATION + "Accounts/Admin.ini", Player.Name.tolower(), "Password", MD5(Password));

	// Command authority

	/* Everything is set for full access, but changes will be made */
	WriteIniBool(ADMIN_LOCATION + "Accounts/Admin.ini", Player.Name.tolower(), "Ban", true);
	WriteIniBool(ADMIN_LOCATION + "Accounts/Admin.ini", Player.Name.tolower(), "Kick", true);
	WriteIniBool(ADMIN_LOCATION + "Accounts/Admin.ini", Player.Name.tolower(), "MessageAll", true);
	WriteIniBool(ADMIN_LOCATION + "Accounts/Admin.ini", Player.Name.tolower(), "Ghost", true);
	
	// For hire up admins like the server owner!
	WriteIniBool(ADMIN_LOCATION + "Accounts/Admin.ini", Player.Name.tolower(), "Restart", true);
	WriteIniBool(ADMIN_LOCATION + "Accounts/Admin.ini", Player.Name.tolower(), "Surface", true);
	WriteIniBool(ADMIN_LOCATION + "Accounts/Admin.ini", Player.Name.tolower(), "Gamespeed", true);
	WriteIniBool(ADMIN_LOCATION + "Accounts/Admin.ini", Player.Name.tolower(), "Gravity", true);
	WriteIniBool(ADMIN_LOCATION + "Accounts/Admin.ini", Player.Name.tolower(), "Comeflywithme", true);

	// In case something fucked up when givin Authority!
	WriteIniBool(ADMIN_LOCATION + "Accounts/Admin.ini", Player.Name.tolower(), "Access", true);

	MessagePlayer("You are now registered as an admin", Player, 255, 0, 0);

	MessagePlayer("Your password is " + Password, Player, 255, 0, 0);
}

function Login_Admin(Player, Password)
{
	local string = ReadIniString(ADMIN_LOCATION + "Accounts/Admin.ini", Player.Name.tolower(), "Password");
	if (MD5(Password) == string )
	{
		// Command authority
		Admin[Player.ID].MessageAll = ReadIniBool(ADMIN_LOCATION + "Accounts/Admin.ini", Player.Name.tolower(), "MessageAll");

		/* Activation is no loger needed */
		Admin[Player.ID].Registration = false;

		Admin[Player.ID].Ban = ReadIniBool(ADMIN_LOCATION + "Accounts/Admin.ini", Player.Name.tolower(), "Ban");
		Admin[Player.ID].Kick = ReadIniBool(ADMIN_LOCATION + "Accounts/Admin.ini", Player.Name.tolower(), "Kick");
		Admin[Player.ID].MessageAll = ReadIniBool(ADMIN_LOCATION + "Accounts/Admin.ini", Player.Name.tolower(), "MessageAll");
		Admin[Player.ID].Ghost = ReadIniBool(ADMIN_LOCATION + "Accounts/Admin.ini", Player.Name.tolower(), "Ghost");
		Admin[Player.ID].Restart = ReadIniBool(ADMIN_LOCATION + "Accounts/Admin.ini", Player.Name.tolower(), "Restart");
		Admin[Player.ID].Surface = ReadIniBool(ADMIN_LOCATION + "Accounts/Admin.ini", Player.Name.tolower(), "Surface");
		Admin[Player.ID].Gamespeed = ReadIniBool(ADMIN_LOCATION + "Accounts/Admin.ini", Player.Name.tolower(), "Gamespeed");
		Admin[Player.ID].Gravity = ReadIniBool(ADMIN_LOCATION + "Accounts/Admin.ini", Player.Name.tolower(), "Gravity");
		Admin[Player.ID].Comeflywithme =  ReadIniBool(ADMIN_LOCATION + "Accounts/Admin.ini", Player.Name.tolower(), "Comeflywithme");
		Admin[Player.ID].Setadmin = true;
		/* Command Usage */

		// Now set there access
		Admin[Player.ID].Access = ReadIniBool(ADMIN_LOCATION + "Accounts/Admin.ini", Player.Name.tolower(), "Access");

		MessagePlayer("You are now logged in to your Admin account", Player, 255, 0, 0);
	}
}

function Give_Admin_Authoriety(Admin, Player, bool)
{
	if (bool == "true")
	{
		WriteIniBool(ADMIN_LOCATION + "Accounts/Admin.ini", Player.Name.tolower(), "Access", true);

		/* A method to see who gave a player admin access */
		WriteIniString(ADMIN_LOCATION + "Accounts/Admin.ini", Player.Name.tolower(), "Given-By", Admin);

		Message( Admin + " has given:[ " + Player + " ] admin authority!", Colour( 0, 200, 90 ) );
		MessagePlayer("Please register /register [Password]", Player, 255, 0, 255);
		return true;
	}

	if (bool == "false")
	{
		DeleteIniSection(ADMIN_LOCATION + "Accounts/Admin.ini", Player.Name.tolower() );
		Message( Admin + " has removed:[ " + Player + " ] admin rights", Colour( 255, 0, 0 ) );
	}
}