package com.bjpowernode.crm.base.constants;

/**
 * @author wj_willem
 * @version 1.0
 * @Description 异常类型
 * @since 2020-11-16 19:45
 */
public enum CrmExceptionEnum {

    /**
     * 登录账号错误
     */
    LOGIN_ACCOUNT_ERROR("001", "用户名或密码不正确"),
    /**
     * 登录账户过期
     */
    LOGIN_ACCOUNT_EXPIRED("001", "账户已失效"),
    /**
     * 登录帐户禁止
     */
    LOGIN_ACCOUNT_FORBID("001", "账户被禁用"),
    /**
     * 登录账户ip
     */
    LOGIN_ACCOUNT_IP("001", "不允许的IP地址"),
    /**
     * 活动保存
     */
    ACTIVITY_SAVE("002","添加市场活动失败"),
    /**
     * 活动更新
     */
    ACTIVITY_UPDATE("002","更新市场活动失败"),
    /**
     * 活动删除
     */
    ACTIVITY_DELETE("002","删除市场活动失败"),
    /**
     * 活动备注更新
     */
    ACTIVITY_REMARK_UPDATE("002","更新市场活动备注失败"),
    /**
     * 活动备注删除
     */
    ACTIVITY_REMARK_DELETE("002","删除市场活动备注失败"),
    /**
     * 活动备注保存
     */
    ACTIVITY_REMARK_SAVE("002","添加市场活动备注失败"),

    /**
     *  添加线索
     */
    CLUE_SAVE("003","添加线索失败"),
    /**
     * 线索备注更新
     */
    CLUE_REMARK_UPDATE("003","更新线索备注失败"),
    /**
     * 线索备注保存
     */
    CLUE_REMARK_SAVE("003","添加线索备注失败"),
    /**
     * 活动线索解绑
     */
    CLUE_ACTIVITY_UNBIND("003","线索和市场活动解绑失败"),
    /**
     * 线索活动绑定
     */
    CLUE_ACTIVITY_BIND("003","线索和市场活动绑定失败"),
    /**
     * 线索转换
     */
    CLUE_CONVERT("003","线索转换失败"),
    /**
     * 插入日志失败
     */
    INSERT_LOG_FAIL("099","日志插入失败"),
    /**
     * 删除日志失败
     */
    DELETE_LOG_FAIL("099", "日志删除失败"),
    /**
     *添加客户失败
     */
    CUSTOMER_CREATE_FAIL("003","添加客户失败"),
    /**
     * 客户更新失败
     */
    CUSTOMER_UPDATE_FAIL("003","修改客户信息失败"),
    /**
     * 客户备注更新失败
     */
    CUSTOMER_REMARK_UPDATE_FAIL("003","修改客户备注失败"),
    /**
     * 客户备注删除失败
     */
    CUSTOMER_REMARK_DELETE_FAIL("003","删除客户备注失败"),
    /**
     * 客户备注添加失败
     */
    CUSTOMER_REMARK_ADD_FAIL("003","添加客户备注失败"),

    /**
     * 交易保存
     */
    TRANSACTION_SAVE("004","交易失败"),
    /**
     * 交易历史记录保存
     */
    TRANSACTION_HISTORY_SAVE("004","交易历史创建失败"),
    /**
     * 交易阶段更新
     */
    TRANSACTION_STAGE_UPDATE("004","交易阶段修改失败"),

    /**
     * 客户添加失败
     */
    CUSTOMER_ADD_FAIL("003","创建客户失败");



    /**
     * //业务状态码 001:用户登录 002:交易模块
     */
    private String code;
    /**
     * 提示信息
     */
    private String message;

    CrmExceptionEnum(String code, String message) {
        this.code = code;
        this.message = message;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
