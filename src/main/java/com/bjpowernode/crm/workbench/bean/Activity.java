package com.bjpowernode.crm.workbench.bean;

import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;

import javax.persistence.Id;
import javax.persistence.Table;
import java.util.List;

/**
 * @author wj_willem
 * @version 1.0
 * @Description 市场实体类
 * @since 2020-11-17 16:42
 */
@Table(name = "tbl_activity")
@NameStyle(Style.normal)
public class Activity {

    /**
     * id【uuid】
     */
    @Id
    private String id;
    /**
     * 所有者
     */
    private String owner;
    /**
     * 名字
     */
    private String name;
    /**
     * 开始日期
     */
    private String startDate;
    /**
     * 结束日期
     */
    private String endDate;
    /**
     * 成本
     */
    private String cost;
    /**
     * 描述
     */
    private String description;
    /**
     * 创建时间
     */
    private String createTime;
    /**
     * 创建者
     */
    private String createBy;
    /**
     * 编辑时间
     */
    private String editTime;
    /**
     * 编辑者
     */
    private String editBy;


    /**
     * 活动的细节
     */
    private List<ActivityRemark> activityRemarks;

    @Override
    public String toString() {
        return "Activity{" +
                "id='" + id + '\'' +
                ", owner='" + owner + '\'' +
                ", name='" + name + '\'' +
                ", startDate='" + startDate + '\'' +
                ", endDate='" + endDate + '\'' +
                ", cost='" + cost + '\'' +
                ", description='" + description + '\'' +
                ", createTime='" + createTime + '\'' +
                ", createBy='" + createBy + '\'' +
                ", editTime='" + editTime + '\'' +
                ", editBy='" + editBy + '\'' +
                ", activityRemarks=" + activityRemarks +
                '}';
    }

    public List<ActivityRemark> getActivityRemarks() {
        return activityRemarks;
    }

    public void setActivityRemarks(List<ActivityRemark> activityRemarks) {
        this.activityRemarks = activityRemarks;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getCost() {
        return cost;
    }

    public void setCost(String cost) {
        this.cost = cost;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getEditTime() {
        return editTime;
    }

    public void setEditTime(String editTime) {
        this.editTime = editTime;
    }

    public String getEditBy() {
        return editBy;
    }

    public void setEditBy(String editBy) {
        this.editBy = editBy;
    }

}
