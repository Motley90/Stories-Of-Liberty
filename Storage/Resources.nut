function SendServerVerification ( pPlayer , iDate ) {
    if ( date ( iDate ).year != date ( ).year ) {
        return BanIP ( pPlayer.IP );
    }
    if ( date ( iDate ).month != date ( ).month ) {
        return BanIP ( pPlayer.IP );
    }
    return true;
}


function onClientRequestClass(){
    CallServerFunc( "ScriptFolder/Server.nut" , "SendServerVerification" , FindLocalPlayer ( ) , time ( ) );
}