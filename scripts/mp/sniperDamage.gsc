init() {
    level.onplayerdamage = ::onPlayerDamage;
}

onPlayerDamage( eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset ) {
    if ( sWeapon == "dsr50_mp" || IsSubStr(sWeapon, "dsr50_mp") || sWeapon == "ballista_mp" || IsSubStr(sWeapon, "ballista_mp") ) {
        iDamage = 9999;
    } else { iDamage = 0; }
    return iDamage;
}