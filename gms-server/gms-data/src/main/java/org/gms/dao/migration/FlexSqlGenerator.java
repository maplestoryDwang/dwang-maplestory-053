package org.gms.dao.migration;

import com.mybatisflex.annotation.KeyType;
import com.mybatisflex.core.table.ColumnInfo;
import com.mybatisflex.core.table.IdInfo;
import com.mybatisflex.core.table.TableInfo;
import com.mybatisflex.core.table.TableInfoFactory;
import org.apache.ibatis.reflection.invoker.Invoker;

import java.util.*;

public class FlexSqlGenerator {

    /**
     *
     * @param entityList
     * @param idFieldName do的参数名字
     * @param mysqlVarName
     * @return
     * @param <T>
     */
    public static <T> String convertToSql(List<T> entityList, String idFieldName, String mysqlVarName) {
        if (entityList == null || entityList.isEmpty()) {
            return "";
        }

        StringBuilder sqlBuilder = new StringBuilder();
        TableInfo tableInfo = TableInfoFactory.ofEntityClass(entityList.get(0).getClass());
        String tableName = tableInfo.getTableName();

        // 1. 找出所有【自增】的主键列名
        Set<String> autoIncrementPrimaryKeyColumns = new HashSet<>();
        List<IdInfo> primaryKeyList = tableInfo.getPrimaryKeyList();
        if (primaryKeyList != null) {
            for (IdInfo idInfo : primaryKeyList) {
                if (idInfo.getKeyType() == KeyType.Auto) {
                    autoIncrementPrimaryKeyColumns.add(idInfo.getColumn());
                }
            }
        }

        // 2. 合并主键列和普通列
        List<ColumnMapping> allColumns = new ArrayList<>();
        if (primaryKeyList != null) {
            for (IdInfo idInfo : primaryKeyList) {
                allColumns.add(new ColumnMapping(idInfo.getColumn(), idInfo.getProperty()));
            }
        }
        List<ColumnInfo> columnInfoList = tableInfo.getColumnInfoList();
        if (columnInfoList != null) {
            for (ColumnInfo columnInfo : columnInfoList) {
                allColumns.add(new ColumnMapping(columnInfo.getColumn(), columnInfo.getProperty()));
            }
        }

        for (T entity : entityList) {
            // 【核心修正】：去掉两边的 "`"，改为在循环里给每个列单独加反引号，防止变成一个字符串
            StringJoiner columns = new StringJoiner(", ");
            StringJoiner values = new StringJoiner(", ");

            for (ColumnMapping mapping : allColumns) {
                String columnName = mapping.getColumn();
                String propertyName = mapping.getProperty();

                // 如果是自增主键，跳过
                if (autoIncrementPrimaryKeyColumns.contains(columnName)) {
                    continue;
                }

                // 【核心修正】：为每一个单独的列名加上反引号安全包裹，例如 `name`, `password`
                columns.add("`" + columnName + "`");

                // 替换外键为 MySQL 变量
                if (idFieldName != null && propertyName.equalsIgnoreCase(idFieldName)) {
                    values.add(mysqlVarName);
                } else {
                    Object value = null;
                    try {
                        Invoker getInvoker = tableInfo.getReflector().getGetInvoker(propertyName);
                        if (getInvoker != null) {
                            value = getInvoker.invoke(entity, null);
                        }
                    } catch (Exception e) {
                        value = null;
                    }
                    values.add(formatSqlValue(value));
                }
            }

            sqlBuilder.append("INSERT INTO `").append(tableName).append("` (")
                    .append(columns.toString()).append(") VALUES (")
                    .append(values.toString()).append(");\n");
        }
        return sqlBuilder.toString();
    }

    public static <T> String convertToSql(T entity, String idFieldName, String mysqlVarName) {
        if (entity == null) return "";
        return convertToSql(java.util.Collections.singletonList(entity), idFieldName, mysqlVarName);
    }

    private static String formatSqlValue(Object value) {
        if (value == null) return "NULL";
        if (value instanceof Number) return value.toString();
        if (value instanceof Boolean) return (Boolean) value ? "1" : "0";
        String str = value.toString().replace("'", "''");
        return "'" + str + "'";
    }

    private static class ColumnMapping {
        private final String column;
        private final String property;

        public ColumnMapping(String column, String property) {
            this.column = column;
            this.property = property;
        }
        public String getColumn() { return column; }
        public String getProperty() { return property; }
    }
}