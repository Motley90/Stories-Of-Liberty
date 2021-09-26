// Updated 12/25/20

/* System Commands */
function onPlayerCommand( pPlayer, szCommand, szParams ) {	
  if (Mission_Testing_COMMANDER( pPlayer, szCommand, szParams )) return true;

  if (ADMIN_AUTHORITY_COMMANDER( pPlayer, szCommand, szParams )) return true;

  MessagePlayer("The command /"+szCommand+" does not exist", pPlayer, 255, 0, 0);

  Write_Invalid_Command( szCommand );
	
  return 1;
}

function Write_Invalid_Command( szCommand ) {
  local Invalid_Cmd = hsh_Cmds.Get( "[COMMAND] " + szCommand );
	
  if ( !Invalid_Cmd ) hsh_Cmds.Add( "[COMMAND] " + szCommand, 1 );
  else {
    hsh_Cmds.Inc( "[COMMAND] " + szCommand, 1 )
  }
	
  SaveHashes();
}	

function GetPlayer( target ) {
  target = target.tostring();
	
  if ( IsNum( target ) ) {
    target = target.tointeger();
		
    if ( FindPlayer( target ) ) return FindPlayer( target );
    else return null;
  }
  else if ( FindPlayer( target ) ) return FindPlayer( target );
  else return null;
}