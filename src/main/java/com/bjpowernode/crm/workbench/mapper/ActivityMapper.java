package com.bjpowernode.crm.workbench.mapper;

import com.bjpowernode.crm.workbench.bean.Activity;
import com.bjpowernode.crm.workbench.bean.ActivityQueryVo;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;
import java.util.Map;

/**
 * @author wj_willem
 * @version 1.0
 * @Description
 * @since 2020-11-17 17:00
 */
public interface ActivityMapper extends Mapper<Activity> {
    List<Map<String, String>> queryAllActivity(ActivityQueryVo activityQueryVo);
}
