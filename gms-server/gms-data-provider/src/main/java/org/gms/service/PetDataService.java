package org.gms.service;

import com.mybatisflex.core.query.QueryWrapper;
import lombok.AllArgsConstructor;
import org.gms.client.inventory.pet.Pet;
import org.gms.dao.entity.PetsDO;
import org.gms.dao.entity.table.PetsDOTableDef;
import org.gms.dao.mapper.ExtendValueMapper;
import org.gms.dao.mapper.PetsMapper;
import org.gms.server.ItemInformationProvider;
import org.gms.util.CashIdGenerator;
import org.springframework.stereotype.Service;

import static org.gms.dao.entity.table.PetsDOTableDef.PETS_D_O;

/**
 * 宠物信息
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/15 11:29
 */
@Service
@AllArgsConstructor
public class PetDataService {

    private final PetsMapper  petsMapper;
    /**
     * 从数据库加载宠物信息
     */
    public Pet loadFromDb(int itemid, short position, int petid) {
        // 使用 selectOneById 或 QueryWrapper 查询指定字段
        PetsDO record = petsMapper.selectOneByQuery(
                QueryWrapper.create()
                        .select(PETS_D_O.NAME, PETS_D_O.LEVEL, PETS_D_O.CLOSENESS, PETS_D_O.FULLNESS, PETS_D_O.SUMMONED, PETS_D_O.FLAG)
                        .where(PETS_D_O.PETID.eq(petid))
        );

        if (record == null) {
            return null;
        }

        Pet ret = new Pet(itemid, position, petid);
        ret.setName(record.getName());
        ret.setTameness((int) Math.min(record.getCloseness() != null ? record.getCloseness() : 0, 30000));
        ret.setLevel((byte) Math.min(record.getLevel() != null ? record.getLevel() : 1, 30));
        ret.setFullness((int) Math.min(record.getFullness() != null ? record.getFullness() : 100, 100));
        ret.setSummoned(record.getSummoned() != null && record.getSummoned());
        ret.setPetAttribute(record.getFlag() != null ? record.getFlag().intValue() : 0);
        return ret;
    }

    /**
     * 保存/更新宠物信息到数据库
     */
    public void saveToDb(Pet pet) {
        if (pet == null) {
            return;
        }

        PetsDO entity = new PetsDO();
        entity.setPetid((long) pet.getUniqueId());
        entity.setName(pet.getName());
        entity.setLevel((long) pet.getLevel());
        entity.setCloseness(Long.valueOf(pet.getTameness()));
        entity.setFullness(Long.valueOf(pet.getFullness()));
        entity.setSummoned(pet.isSummoned());
        entity.setFlag(Long.valueOf(pet.getPetAttribute()));

        // 根据主键 petid 忽略 null 值更新
        petsMapper.update(entity);
    }

    /**
     * 创建新宠物记录
     */
    public int createPet(int itemid) {
        int petId = CashIdGenerator.generateCashId();

        PetsDO entity = new PetsDO();
        entity.setPetid((long) petId);
        entity.setName(ItemInformationProvider.getInstance().getName(itemid));
        entity.setLevel(1L);
        entity.setCloseness(0L);
        entity.setFullness(100L);
        entity.setSummoned(false);
        entity.setFlag(0L);

        // 使用 insertWithPk 避免使用自增主键生成策略覆盖自定义的 CashId
        int rows = petsMapper.insertWithPk(entity);
        return rows > 0 ? petId : -1;
    }

}
