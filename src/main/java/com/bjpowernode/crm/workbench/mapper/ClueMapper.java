package com.bjpowernode.crm.workbench.mapper;

import com.bjpowernode.crm.workbench.bean.Clue;
import com.bjpowernode.crm.workbench.bean.ClueEchartsResultVo;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;
import java.util.Map;


public interface ClueMapper extends Mapper<Clue> {
    List<Map<String, String>> queryClueEcharts();
}