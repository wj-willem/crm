package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.workbench.bean.*;

import java.util.List;

public interface ClueService {
    void saveClue(Clue clue);

    Clue queryClueDetailById(String id);

    void updateClueRemark(ClueRemark clueRemark);

    void saveClueRemark(ClueRemark clueRemark);

    void deleteBind(ClueActivityRelation clueActivityRelation);

    void deleteManyBind(String clueId, String activityIds);

    List<Activity> queryActivityExculdeNow(String clueId, String activityName);

    void saveBind(String clueId, String activityIds);

    List<Activity> queryClueActivity(String clueId);

    void saveConvert(Transaction transaction, String clueId, String username, String isCreateTransaction);

    List<Activity> queryActivityIncludeNow(String clueId, String activityName);

    ClueEchartsResultVo queryClueEcharts();
}
