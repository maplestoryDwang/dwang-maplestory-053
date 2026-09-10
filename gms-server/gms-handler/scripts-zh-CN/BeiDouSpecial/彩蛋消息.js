/**
 * @description 隐藏地图全探索 - 终极彩蛋情报 NPC
 *  todo 未完成
 */
var status = -1;

function start() {
    status = -1;
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode <= 0) {
        cm.dispose();
        return;
    }
    mode === 1 ? status++ : status--;

    if (status === 0) {
        var text = "#e#r[隐藏地图探索专家]#k#n\r\n\r\n恭喜你走遍了冒险岛所有隐秘的角落！这里是为你准备的探索彩蛋情报：\r\n\r\n";
        text += "#b1.#k 猪的海岸入口在【三岔路】左上角树洞；\r\n";
        text += "#b2.#k 坠落主义的隐藏入口在【废弃都市】爵士的地下酒吧垃圾桶；\r\n";
        text += "#b3.#k 猴子森林的树洞可以直接通往【邪恶猴子森林】；\r\n";
        text += "#b4.#k 黄金海岸有未公开的【隐藏海滩】，内部刷新极高密度龙虾！\r\n\r\n";
        text += "#b5.#k 黄金海岸有未公开的【隐藏海滩】，内部刷新极高密度龙虾！\r\n\r\n";
        text += "#g希望这些秘密能帮你在冒险之旅中发现更多乐趣！#k";
        cm.sendOk(text);
        cm.dispose();
    }
}