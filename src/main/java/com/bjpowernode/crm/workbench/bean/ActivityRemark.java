package com.bjpowernode.crm.workbench.bean;

import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;

import javax.persistence.Id;
import javax.persistence.Table;


/**
 * @author wj_willem
 * @version 1.0
 * @Description 市场活动备注实体类
 * @since 2020-11-17 16:42
 */
@Table(name = "tbl_activity_remark")
@NameStyle(Style.normal)
public class ActivityRemark {
    /**
     * id
     */
    @Id
    private String id;
    /**
     * 注意的内容
     */
    private String noteContent;
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
     * 编辑标记
     */
    private String editFlag;
    /**
     * 活动id
     */
    private String activityId;

    @Override
    public String toString() {
        return "ActivityRemark{" +
                "id='" + id + '\'' +
                ", noteContent='" + noteContent + '\'' +
                ", createTime='" + createTime + '\'' +
                ", createBy='" + createBy + '\'' +
                ", editTime='" + editTime + '\'' +
                ", editBy='" + editBy + '\'' +
                ", editFlag='" + editFlag + '\'' +
                ", activityId='" + activityId + '\'' +
                '}';
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNoteContent() {
        return noteContent;
    }

    public void setNoteContent(String noteContent) {
        this.noteContent = noteContent;
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

    public String getEditFlag() {
        return editFlag;
    }

    public void setEditFlag(String editFlag) {
        this.editFlag = editFlag;
    }

    public String getActivityId() {
        return activityId;
    }

    public void setActivityId(String activityId) {
        this.activityId = activityId;
    }
}