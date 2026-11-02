package org.gms.dao.service;

import com.mybatisflex.core.query.QueryWrapper;
import lombok.AllArgsConstructor;
import org.gms.dao.entity.MobDropPityDO;
import org.gms.dao.mapper.MobDropPityMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.gms.dao.entity.table.MobDropPityDOTableDef.MOB_DROP_PITY_D_O;

/**
 * 怪物掉落保底绑定的数据访问层（Spring 管理）。
 * <p>
 * 表 {@code mob_drop_pity} 只存"当前生效的绑定"：解绑即删行，角色删除按 chr_id 整体清理。
 * 写入走 {@link #sync(int, List)}，由 {@code MobDropPityManager} 在角色存档时整批调用，
 * 平时游戏内只操作内存缓存。
 *
 * @author dwang
 * @since 2026-11-02
 */
@Service
@AllArgsConstructor
public class MobDropPityService {

    private final MobDropPityMapper mobDropPityMapper;

    /**
     * 查询某个角色已开启的全部保底绑定。
     */
    public List<MobDropPityDO> selectByChrId(int chrId) {
        return mobDropPityMapper.selectListByQuery(QueryWrapper.create()
                .where(MOB_DROP_PITY_D_O.CHR_ID.eq(chrId))
                .orderBy(MOB_DROP_PITY_D_O.MOB_ID.asc(), MOB_DROP_PITY_D_O.ITEM_ID.asc()));
    }

    /**
     * 用内存里的整份数据覆盖库中该角色的绑定（角色存档时调用）。
     * <p>
     * 按唯一键 (chr_id, mob_id, item_id) 对齐：库里没有的插入、已有的更新（保留主键和首次绑定时间）、
     * 库里有但内存里已经没有的删除（解绑）。
     *
     * @param chrId 角色 id
     * @param rows  内存里的全部绑定（每行的 chrId 会被覆盖成入参）
     * @return 实际写入（新增 + 更新 + 删除）的记录数
     */
    @Transactional(rollbackFor = Exception.class)
    public int sync(int chrId, List<MobDropPityDO> rows) {
        Map<String, MobDropPityDO> existing = new HashMap<>();
        for (MobDropPityDO old : selectByChrId(chrId)) {
            existing.put(key(old.getMobId(), old.getItemId()), old);
        }

        int affected = 0;
        for (MobDropPityDO row : rows) {
            row.setChrId(chrId);
            MobDropPityDO old = existing.remove(key(row.getMobId(), row.getItemId()));
            if (old == null) {
                mobDropPityMapper.insertSelective(row);
            } else {
                row.setId(old.getId());
                mobDropPityMapper.update(row);
            }
            affected++;
        }

        for (MobDropPityDO removed : existing.values()) {
            mobDropPityMapper.deleteById(removed.getId());
            affected++;
        }
        return affected;
    }

    /**
     * 删除某个角色的全部保底绑定（角色删除时清理）。
     *
     * @return 受影响行数
     */
    public int deleteByChrId(int chrId) {
        return mobDropPityMapper.deleteByQuery(QueryWrapper.create().where(MOB_DROP_PITY_D_O.CHR_ID.eq(chrId)));
    }

    private static String key(Integer mobId, Integer itemId) {
        return mobId + "_" + itemId;
    }
}
