package com.bjpowernode.crm.logManage.service.impl;

import com.bjpowernode.crm.base.constants.CrmExceptionEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.logManage.bean.Log;
import com.bjpowernode.crm.logManage.bean.LogVo;
import com.bjpowernode.crm.logManage.mapper.LogMapper;
import com.bjpowernode.crm.logManage.service.LogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author wj_willem
 * @version 1.0
 * @Description
 * @since 2020-11-20 16:28
 */
@Service("logService")
public class LogServiceImpl implements LogService {

    @Autowired
    private LogMapper logMapper;

    @Override
    public void insertLog(Log log) {
        int i = logMapper.insertSelective(log);
        if (i == 0) {
            throw new CrmException(CrmExceptionEnum.INSERT_LOG_FAIL);
        }
    }

    @Override
    public List<Map<String, String>> queryAllLogs(LogVo logVo) {
        return logMapper.queryAllLogs(logVo);
    }

    @Override
    public void deleteLogs(String ids) {
        String[] stringIds = ids.split(",");
        for (String id : stringIds) {
            int i = logMapper.deleteByPrimaryKey(id);
            if (i == 0) {
                throw new CrmException(CrmExceptionEnum.DELETE_LOG_FAIL);
            }
        }
    }

    @Override
    public List<Log> logExport() {
        List<Log> logList = logMapper.selectAll();
        return logList;
    }
}
