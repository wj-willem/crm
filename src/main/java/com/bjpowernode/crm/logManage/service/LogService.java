package com.bjpowernode.crm.logManage.service;


import com.bjpowernode.crm.logManage.bean.Log;
import com.bjpowernode.crm.logManage.bean.LogVo;

import java.util.List;
import java.util.Map;

public interface LogService {


    void insertLog(Log log);

    List<Map<String, String>> queryAllLogs(LogVo logVo);

    void deleteLogs(String ids);

    List<Log> logExport();
}
