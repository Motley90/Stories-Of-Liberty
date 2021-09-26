//blips
function RemoveBlips(player) {
  for (local i=0;i<30;i++) {
    local blip = FindBlip(i, player);
    if (blip) {
      if (blip.Icon != BLIP_NONE) blip.Remove();
    }
  }
}

function BlipsForAll() {
  for (local i=0;i<GetMaxPlayers();i++) {
    local player = FindPlayer(i);
    
    if (player) {
      Blips(player, GetPlayerIsland(player));
    }
  }
}

function Blips(player, island) {
  RemoveBlips(player);

  AddBlip(player, BLIP_PNS, 925.3, -361.9, island);
  AddBlip(player, BLIP_PNS, 382.4, -493.6, island);
  AddBlip(player, BLIP_PNS, -1144.4, 35.1, island);

  AddBlip(player, BLIP_AMMU, 1068.5, -400.75, island);
  AddBlip(player, BLIP_AMMU, 342.5, -713.0, island);
  AddBlip(player, BLIP_AMMU, -1206.562, -6.5625, island);
  AddBlip(player, BLIP_AMMU, 145.5, 170.0, island);


}

function AddBlip(player, type, x, y, island) {
  if (island == 1 && x > 616) {
    CreateClientBlip(player, type, Vector(x, y, -100));  
  }
  else if (island == 3 && x < -283) {
    CreateClientBlip(player, type, Vector(x, y, -100));
  }
  else if (island == 2 && x > -283 && x < 616) {
    CreateClientBlip(player, type, Vector(x, y, -100));  
  }
}
//blips

function GetPlayerIsland(player) {
  local pos = player.Pos;
  
  if (pos.x > 616) return 1;
  if (pos.x < -283) return 3;
  
  return 2;
}

function onPlayerIslandChange(player, old_island, new_island) {

  Blips(player, new_island);

  return true;
}








//sphere
sphere <- array(GetMaxPlayers(), -1);
sphere_blip <- array(GetMaxPlayers(), -1);

function CreateMarker(player, x, y, z, size, color = 1) {
  RemoveMarker(player);

  local id = CreateClientSphere(Vector(x, y, z), size, player);
  sphere[player.ID] = id.ID;
  
  local blip = CreateClientBlip(player, BLIP_NONE, Vector(x, y, z));
  blip.Colour = color;
  blip.Size = 3;
  sphere_blip[player.ID] = blip.ID;
}

function RemoveMarker(player) {
  if (sphere[player.ID] < 0) return true;
  
  local id = FindSphere(sphere[player.ID], player);
  if (id) id.Remove();
  
  local blip = FindBlip(sphere_blip[player.ID], player);
  if (blip) blip.Remove();
  
  sphere[player.ID] = -1;
  sphere_blip[player.ID] = -1;
  return true;
}
//sphere