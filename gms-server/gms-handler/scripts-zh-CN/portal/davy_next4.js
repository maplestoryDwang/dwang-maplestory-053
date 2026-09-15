function enter(pi) {
    if (pi.getMap().getReactorByName("sMob1").getState() >= 1 && pi.getMap().getReactorByName("sMob2").getState() >= 1 && pi.getMap().getReactorByName("sMob3").getState() >= 1 && pi.getMap().getReactorByName("sMob4").getState() >= 1 && pi.getMap().getMonsters().size() == 0) {
        var eim = pi.getEventInstance();

        if (eim.getProperty("spawnedBoss") == null) {
            var level = parseInt(eim.getProperty("level"));
            var chests = parseInt(eim.getProperty("openedChests"));
            var boss;

            const LifeFactory = Java.type('org.gms.server.life.LifeFactory');
            if (chests == 0) {
                boss = LifeFactory.getMonster(9300119); // 普海盗船长 (Lord Pirate)
            } else {
                // 随机在 9300105, 9300106, 9300107 里面选一个
                var bossIds = [9300105, 9300106, 9300107];
                var randomBossId = bossIds[Math.floor(Math.random() * bossIds.length)];
                boss = LifeFactory.getMonster(randomBossId);
            }

            boss.changeDifficulty(level, true);

            const Point = Java.type('java.awt.Point');
            pi.getMap(925100500).spawnMonsterOnGroundBelow(boss, new Point(777, 140));
            eim.setProperty("spawnedBoss", "true");
        }

        pi.playPortalSound();
        pi.warp(925100500, 0);
        return true;
    } else {
        pi.playerMessage(5, "传送门尚未开启。");
        return false;
    }
}