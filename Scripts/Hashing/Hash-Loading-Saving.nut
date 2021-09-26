/* 
	Hashes are only used for simple stuff.
	In this case writing invalid commands to better our system in time.
*/
const HASH_TABLE_LOCATION = "Hashing/Hashes/";

function onHashTableLoad() 
{
	LoadHashes();

	print("The hash tables have been loaded!");
}

function CreateHashes()
{
	hsh_Cmds <- HashTable("CMD");
}

function SaveHashes()
{
	// This is where we will be saving the hash files
	hsh_Cmds.Save(DEFAULT_BASE_LOCATION + HASH_TABLE_LOCATION + "INVALID_COMMANDS.hsh" );
}

function LoadHashes()
{
	// This is where we are going to be loading the hash files
	// First we need to create them
	CreateHashes();
	
	// And then load them
	hsh_Cmds.Load(DEFAULT_BASE_LOCATION + HASH_TABLE_LOCATION + "Hashing/Hashes/INVALID_COMMANDS.hsh" );

}
