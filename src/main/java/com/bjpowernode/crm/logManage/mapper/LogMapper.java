package com.bjpowernode.crm.logManage.mapper;


import com.bjpowernode.crm.logManage.bean.Log;
import com.bjpowernode.crm.logManage.bean.LogVo;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;
import java.util.Map;


public interface LogMapper extends Mapper<Log> {
    List<Map<String, String>> queryAllLogs(LogVo logVo);
}
