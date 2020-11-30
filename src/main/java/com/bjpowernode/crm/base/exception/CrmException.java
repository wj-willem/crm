package com.bjpowernode.crm.base.exception;

import com.bjpowernode.crm.base.constants.CrmExceptionEnum;

/**
 * @author wj_willem
 * @version 1.0
 * @Description 自定义异常
 * @since 2020-11-16 19:44
 */
public class CrmException extends RuntimeException {

    private CrmExceptionEnum crmExceptionEnum;

    public CrmException(CrmExceptionEnum crmExceptionEnum) {
        //将异常信息放在堆栈信息中
        super(crmExceptionEnum.getMessage());
        this.crmExceptionEnum = crmExceptionEnum;
    }

    public CrmExceptionEnum getCrmExceptionEnum() {
        return crmExceptionEnum;
    }

    public void setCrmExceptionEnum(CrmExceptionEnum crmExceptionEnum) {
        this.crmExceptionEnum = crmExceptionEnum;
    }
}
