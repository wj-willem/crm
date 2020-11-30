package com.bjpowernode.crm.workbench.bean;

/**
 * @author wj_willem
 * @version 1.0
 * @Description 查询条件实体类
 * @since 2020-11-17 16:42
 */
public class ActivityQueryVo {
    /**
     * 名字
     */
    private String name;
    /**
     * 所有者
     */
    private String owner;
    /**
     * 开始时间
     */
    private String startTime;
    /**
     * 结束时间
     */
    private String endTime;

    @Override
    public String toString() {
        return "ActivityQueryVo{" +
                "name='" + name + '\'' +
                ", owner='" + owner + '\'' +
                ", startTime='" + startTime + '\'' +
                ", endTime='" + endTime + '\'' +
                '}';
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
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