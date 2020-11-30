package com.bjpowernode.crm.base.bean;

/**
 * @author wj_willem
 * @version 1.0
 * @Description 反馈消息实体类
 * @since 2020-11-17 16:42
 */
public class ResultVo {


    private boolean success;

    private String message;

    @Override
    public String toString() {
        return "ResultVo{" +
                "success=" + success +
                ", message='" + message + '\'' +
                '}';
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}