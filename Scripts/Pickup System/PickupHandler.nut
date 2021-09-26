
//ammu nation
max_mission_pickups <- 5000;

mission_pickup <- array(max_mission_pickups, 0);
mission_pickup_ammo <- array(max_mission_pickups, 0);
mission_pickup_id <- array(max_mission_pickups, 0);
mission_pickup_price <- array(max_mission_pickups, 0);
mission_pickup_slot <- array(max_mission_pickups, 0);
mission_pickup_x <- array(max_mission_pickups, 0);
mission_pickup_y <- array(max_mission_pickups, 0);
mission_pickup_z <- array(max_mission_pickups, 0);

function CreateMissionPickup(id, slot, x, y, z, model, ammo, price) {
  mission_pickup[id] = model;
  mission_pickup_ammo[id] = ammo;
  mission_pickup_price[id] = price;
  mission_pickup_slot[id] = slot;
  mission_pickup_x[id] = x;
  mission_pickup_y[id] = y;
  mission_pickup_z[id] = z;
  
  local pickup = CreatePickup(model, Vector(x, y, z));
  mission_pickup_id[id] = pickup.ID;
  pickup.RespawnTime = 10;
}

function BuyWeapon(player, slot) {

  for (local i=0;i<max_mission_pickups;i++) {
    if (mission_pickup_slot[i] == slot) {
      if (IsPlayerInSphere(player, mission_pickup_x[i], mission_pickup_y[i], mission_pickup_z[i], 10)) {
      
        if (money[player.ID] < mission_pickup_price[i]) {
          Notify(0, "~r~You don't have enough money!", player);
          Notify(1, "~r~NEDOSTATOCHNO SREDSTV!", player);
          return true;
        }
        
        GiveMoney(player, -mission_pickup_price[i]);
        spent_weapon[player.ID] += mission_pickup_price[i];
        
        GiveWeapon(player, mission_pickup[i], mission_pickup_ammo[i]);
     
        break;
      }
    }
  }

  return true;
}
//ammu nation


function onPickupPickedUp( pPlayer, pPickup )
{

  
  local iModel = pPickup.Model;
  MissionPickup(pPlayer, pPickup.ID)
    
  switch( iModel )
  {
//-----------------------------------------------//
// Weapon Pickups

    /* Grenade Pickup */
    case 170:
      pPlayer.SetWeapon( 11, 15 );
      break;
    /* AK-47 Pickup */
    case 171:
      pPlayer.SetWeapon( 5, 750 );
      break;
    /* Baseball Bat Pickup */
    case 172:
      /*for (local i=0;i<max_mission_pickups;i++) 
      {
        if (pickup.ID == mission_pickup_id[i]) 
        {*/
          The_Bum(pPlayer, 4, 0, true, 0) 

          pPlayer.SetWeapon( 1, 1 );
    
          return true;
        /*}
      }*/
      break;
    /* Colt .45 Pickup */
    case 173:
      pPlayer.SetWeapon( 2, 500 );
      break;
    /* Molotov Pickup */
    case 174:
      pPlayer.SetWeapon( 10, 15 );
      break;       
    /* Rocket Launcher Pickup */
    case 175:
      pPlayer.SetWeapon( 8, 50 );
      break;
    /* Shotgun Pickup */
    case 176:
      pPlayer.SetWeapon( 4, 50 );
      break;
    /* Sniper Rifle Pickup */
    case 177:
      pPlayer.SetWeapon( 7, 50 );
      break;
    /* UZI Pickup */
    case 178:
      pPlayer.SetWeapon( 3, 500 );
      break;
    /* M16 Pickup */
    case 180:
      pPlayer.SetWeapon( 6, 1000 );
      break;
    /* Flame Thrower Pickup */
    case 181:
      pPlayer.SetWeapon( 9, 250 );
      break;

//-----------------------------------------------//
// Other Pickups
        
    /* Health Pickup */
    case 1362:
      pPlayer.Health = 100;
      break;
    /* Armour Pickup */  
    case 1364:
      pPlayer.Armour = 100;
      break;
  }
  
  return 1;
}