package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.bean.Activity;
import com.bjpowernode.crm.workbench.bean.ActivityQueryVo;
import com.bjpowernode.crm.workbench.bean.ActivityRemark;

import java.util.List;
import java.util.Map;

/**
 * @author wj_willem
 * @version 1.0
 * @Description
 * @since 2020-11-17 16:51
 */
public interface ActivityService {

    /**
     * 查询所有活动
     *
     * @param activityQueryVo 活动查询条件vo
     * @return {@link List<Map<String, String>>}
     */
    List<Map<String, String>> queryAllActivity(ActivityQueryVo activityQueryVo);

    /**
     * 保存活动
     *
     * @param activity 活动
     */
    void saveActivity(Activity activity);

    /**
     * 查询活动通过id
     *
     * @param id id
     * @return {@link Activity}
     */
    Activity queryActivityById(String id);

    /**
     * 更新活动
     *
     * @param activity 活动
     */
    void updateActivity(Activity activity);

    /**
     * 删除活动
     *
     * @param id id
     */
    void deleteActivity(String id);

    /**
     * 通过id查询活动细节
     *
     * @param id id
     * @return {@link Activity}
     */
    Activity queryActivityDetailById(String id);

    /**
     * 更新活动的细节
     *
     * @param activityRemark 活动的话
     */
    void updateActivityRemark(ActivityRemark activityRemark);

    /**
     * 删除活动的话
     *
     * @param id id
     */
    void deleteActivityRemark(String id);

    /**
     * 保存活动的备注
     *
     * @param activityRemark 活动备注
     */
    void saveActivityRemark(ActivityRemark activityRemark);
}
