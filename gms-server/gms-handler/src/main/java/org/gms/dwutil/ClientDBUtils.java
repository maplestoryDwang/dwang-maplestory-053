package org.gms.dwutil;

import org.gms.client.Client;
import org.gms.net.server.Server;
import org.gms.net.server.coordinator.session.SessionCoordinator;
import org.gms.util.DatabaseConnection;
import org.springframework.stereotype.Component;

import java.sql.*;
import java.util.Calendar;

/**
 * 控制登录状态和离线状态
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/13 13:41
 */

@Component
public class ClientDBUtils {




    public static int getLoginState(Client client) {  // 0 = LOGIN_NOTLOGGEDIN, 1= LOGIN_SERVER_TRANSITION, 2 = LOGIN_LOGGEDIN
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

    public static void updateLoginState(Client client, int newState) {
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







}
