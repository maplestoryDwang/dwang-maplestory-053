function enter(pi) {
    pi.playPortalSound();
    var eim = pi.getEventInstance();
    var target = eim.getMapInstance(108010101);

    pi.getPlayer().changeMap(target, target.getPortal("st00"));
    return true;
}