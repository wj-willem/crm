package com.bjpowernode.crm.logManage.bean;

import java.io.Serializable;
import java.util.Date;

public class LogVo implements Serializable{

    private static final long serialVersionUID = -4388138342174328269L;


    // 请求名称
    private String operationName;
    //开始时间
    private String startTime;
    //结束时间
    private String endTime;


    public String getOperationName() {
        return operationName;
    }

    public void setOperationName(String operationName) {
        this.operationName = operationName;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }
}
