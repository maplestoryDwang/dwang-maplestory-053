package org.gms.dwutil;

import com.mybatisflex.core.query.QueryWrapper;
import com.mybatisflex.core.update.UpdateChain;
import org.gms.client.Character;
import org.gms.client.Client;
import org.gms.dao.entity.AccountsDO;
import org.gms.dao.entity.CharactersDO;
import org.gms.dao.mapper.AccountsMapper;
import org.gms.dao.mapper.CharactersMapper;
import org.gms.net.server.Server;
import org.gms.net.server.coordinator.session.SessionCoordinator;
import org.gms.util.DatabaseConnection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.sql.*;
import java.util.Calendar;

import static org.gms.dao.entity.table.AccountsDOTableDef.ACCOUNTS_D_O;
import static org.gms.dao.entity.table.CharactersDOTableDef.CHARACTERS_D_O;

/**
 * 控制登录状态和离线状态
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/13 13:41
 */

@Component
public class ClientDBUtils {

    private static AccountsMapper accountsMapper;
    private static CharactersMapper charactersMapper;




    // 静态注入 Mapper
    @Autowired
    public void setAccountsDOMapper(AccountsMapper accountsMapper) {
        ClientDBUtils.accountsMapper = accountsMapper;
    }

    @Autowired
    public void setCharactersMapper(CharactersMapper charactersMapper) {
        ClientDBUtils.charactersMapper = charactersMapper;
    }


    public static int getLoginState(Client client) {
        // 1. 根据原 SQL 仅查询loggedin, lastlogin, birthday 三个字段
        AccountsDO account = accountsMapper.selectOneByQuery(
                QueryWrapper.create()
                        .select(ACCOUNTS_D_O.LOGGEDIN, ACCOUNTS_D_O.LASTLOGIN, ACCOUNTS_D_O.BIRTHDAY)
                        .where(ACCOUNTS_D_O.ID.eq(client.getAccID()))
        );

        if (account == null) {
            throw new RuntimeException("获取登录状态-客户端账号：" + client.getAccID());
        }

        // 2. 设置 Birthday
        client.setBirthday(Calendar.getInstance());
        if (account.getBirthday() != null) {
            client.getBirthday().setTime(account.getBirthday());
        }

        int state = account.getLoggedin();

        // 3. 处理 SERVER_TRANSITION 切换状态超时
        if (state == Client.LOGIN_SERVER_TRANSITION) {
            Timestamp lastlogin = account.getLastlogin();
            // 兼容历史已创建账号和自动注册未登录账号
            if (lastlogin == null || lastlogin.getTime() + 30000 < Server.getInstance().getCurrentTime()) {
                int accountId = client.getAccID();
                state = Client.LOGIN_NOTLOGGEDIN;

                // 保留原注释说明：ACCID = 0, issue found thanks to Tochi & K u ssss o & Thora & Omo Oppa
                updateLoginState(client, Client.LOGIN_NOTLOGGEDIN);
                client.setAccID(accountId);
            }
        }

        // 4. 获取状态后顺便更新 Client 状态与数据库
        if (state == Client.LOGIN_LOGGEDIN) {
            client.setLoggedIn(true);
        } else if (state == Client.LOGIN_SERVER_TRANSITION) {
            // 原 SQL: UPDATE accounts SET loggedin = 0 WHERE id = ?
            AccountsDO updateBean = new AccountsDO();
            updateBean.setId(client.getAccID());
            updateBean.setLoggedin(0);
            accountsMapper.update(updateBean);
        } else {
            client.setLoggedIn(false);
        }

        return state;
    }

    public static void updateLoginState(Client client, int newState) {
        // rules out possibility of multiple account entries
        if (newState == Client.LOGIN_LOGGEDIN) {
            SessionCoordinator.getInstance().updateOnlineClient(client);
        }

        // 原 SQL: UPDATE accounts SET loggedin = ?, lastlogin = ? WHERE id = ?
        AccountsDO updateBean = new AccountsDO();
        updateBean.setId(client.getAccID());
        updateBean.setLoggedin(newState);
        updateBean.setLastlogin(new Timestamp(Server.getInstance().getCurrentTime()));

        accountsMapper.update(updateBean);

        // 更新 Client 内存状态
        if (newState == Client.LOGIN_NOTLOGGEDIN) {
            client.setLoggedIn(false);
            client.setServerTransition(false);
            client.setAccID(0);
        } else {
            boolean serverTransition = (newState == Client.LOGIN_SERVER_TRANSITION);
            boolean loggedIn = !serverTransition;

            client.setServerTransition(serverTransition);
            client.setLoggedIn(loggedIn);
        }
    }


    /**
     *
     * @desc 数据库多一个标志位，和 updateLoginState同时调用
     * 1. 账号 LOGIN_NOTLOGGEDIN 所有角色全部设置下线，以防止存在多个登录状态
     * 2. 账号 LOGIN_LOGGEDIN    尝试找到登录的player
     * 3. 账号 LOGIN_SERVER_TRANSITION 不进行任何操作
     *
     * @param charId
     * @param newState
     */

    public static void updatePlayerLoginState(int accId, int charId, int newState) {
        if (newState == Client.LOGIN_NOTLOGGEDIN) {
            // 账号下线：将该账号下所有角色全部设为下线
            CharactersDO update = new CharactersDO();
            update.setLoggedin(false);
            charactersMapper.updateByQuery(update, QueryWrapper.create().where(CHARACTERS_D_O.ACCOUNTID.eq(accId)));
        } else if (newState == Client.LOGIN_LOGGEDIN) {
            if (charId > 0) {
                // 1. 先把该账号下所有角色设为下线（清空历史残留数据）
                CharactersDO offlineAll = new CharactersDO();
                offlineAll.setLoggedin(false);
                charactersMapper.updateByQuery(offlineAll, QueryWrapper.create().where(CHARACTERS_D_O.ACCOUNTID.eq(accId)));

                // 2. 再将当前登录的角色设为上线
                CharactersDO onlineChar = new CharactersDO();
                onlineChar.setId(charId);
                onlineChar.setLoggedin(true);
                charactersMapper.update(onlineChar);
            }
        }
    }
    public static void updatePlayerLoginStateUpdateChain(int accId, int charId, int newState) {
        if (newState == Client.LOGIN_NOTLOGGEDIN) {
            // 账号下线：把该账号下所有角色下线
            UpdateChain.of(CharactersDO.class)
                    .set(CHARACTERS_D_O.LOGGEDIN, false)
                    .where(CHARACTERS_D_O.ACCOUNTID.eq(accId))
                    .update();

        } else if (newState == Client.LOGIN_LOGGEDIN && charId > 0) {
            // 1. 先把该账号下的所有角色下线
            UpdateChain.of(CharactersDO.class)
                    .set(CHARACTERS_D_O.LOGGEDIN, false)
                    .where(CHARACTERS_D_O.ACCOUNTID.eq(accId))
                    .update();

            // 2. 再精准上线指定角色
            UpdateChain.of(CharactersDO.class)
                    .set(CHARACTERS_D_O.LOGGEDIN, true)
                    .where(CHARACTERS_D_O.ID.eq(charId))
                    .update();
        }
    }



/*
    public static int getLoginStateold(Client client) {  // 0 = LOGIN_NOTLOGGEDIN, 1= LOGIN_SERVER_TRANSITION, 2 = LOGIN_LOGGEDIN
        try (Connection con = DatabaseConnection.getConnection()) {
            int state;
            try (PreparedStatement ps = con.prepareStatement("SELECT loggedin, lastlogin, birthday FROM accounts WHERE id = ?")) {
                ps.setInt(1, client.getAccID());

                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next()) {
                        throw new RuntimeException("获取登录状态-客户端账号：" + client.getAccID());
                    }
                    client.setBirthday(Calendar.getInstance());
                    try {
                        client.getBirthday().setTime(rs.getDate("birthday"));

                    } catch (SQLException e) {
                    }

                    state = rs.getInt("loggedin");
                    if (state == Client.LOGIN_SERVER_TRANSITION) {
                        Timestamp lastlogin = rs.getTimestamp("lastlogin");
                        // 兼容历史已经创建的账号，和自动注册但未登录的账号
                        if (lastlogin == null || lastlogin.getTime() + 30000 < Server.getInstance().getCurrentTime()) {
                            int accountId = client.getAccID();
                            state = Client.LOGIN_NOTLOGGEDIN;
                            updateLoginState(client, Client.LOGIN_NOTLOGGEDIN);   // ACCID = 0, issue found thanks to Tochi & K u ssss o & Thora & Omo Oppa
                            client.setAccID(accountId);
                        }
                    }
                }
            }


            // 获取状态之后顺便更新状态
            if (state == Client.LOGIN_LOGGEDIN) {
                client.setLoggedIn(true);

            } else if (state == Client.LOGIN_SERVER_TRANSITION) {
                try (PreparedStatement ps2 = con.prepareStatement("UPDATE accounts SET loggedin = 0 WHERE id = ?")) {
                    ps2.setInt(1, client.getAccID());
                    ps2.executeUpdate();
                }
            } else {
                client.setLoggedIn(false);
            }
            return state;
        } catch (SQLException e) {
            client.setLoggedIn(false);
            e.printStackTrace();
            throw new RuntimeException("登录状态错误");
        }
    }

    public static void updateLoginStateold(Client client, int newState) {
        // rules out possibility of multiple account entries
        if (newState == Client.LOGIN_LOGGEDIN) {
            SessionCoordinator.getInstance().updateOnlineClient(client);
        }

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE accounts SET loggedin = ?, lastlogin = ? WHERE id = ?")) {
            // using sql currenttime here could potentially break the login, thanks Arnah for pointing this out

            ps.setInt(1, newState);
            ps.setTimestamp(2, new java.sql.Timestamp(Server.getInstance().getCurrentTime()));
            ps.setInt(3, client.getAccID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (newState == Client.LOGIN_NOTLOGGEDIN) {
            client.setLoggedIn(false);
            client.setServerTransition(false);
            client.setAccID(0);
        } else {
            boolean serverTransition = (newState == Client.LOGIN_SERVER_TRANSITION);
            boolean loggedIn = !serverTransition;

            client.setServerTransition(serverTransition);
            client.setLoggedIn(loggedIn);

        }
    }
*/







}
