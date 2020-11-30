package com.bjpowernode.crm.workbench.mapper;


import com.bjpowernode.crm.workbench.bean.SaveTran;
import com.bjpowernode.crm.workbench.bean.Tran;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;
import java.util.Map;


public interface TranMapper extends Mapper<Tran> {

    //查询所有交易信息，支持模糊查询，分页
    List<Map<String, String>> saveAllTran(SaveTran saveTran);
}
