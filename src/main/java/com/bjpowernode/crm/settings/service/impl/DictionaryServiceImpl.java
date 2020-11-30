package com.bjpowernode.crm.settings.service.impl;

import com.bjpowernode.crm.base.bean.DictionaryType;
import com.bjpowernode.crm.base.bean.DictionaryValue;
import com.bjpowernode.crm.settings.mapper.DictionaryTypeMapper;
import com.bjpowernode.crm.settings.mapper.DictionaryValueMapper;
import com.bjpowernode.crm.settings.service.DictionaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.List;

/**
 * @author wj_willem
 * @version 1.0
 * @Description
 * @since 2020-11-25 8:45
 */
@Service("dictionaryService")
public class DictionaryServiceImpl implements DictionaryService {

    @Autowired
    private DictionaryTypeMapper dictionaryTypeMapper;

    @Autowired
    private DictionaryValueMapper dictionaryValueMapper;


    @Override
    public List<DictionaryType> queryDictionary() {

        List<DictionaryType> dictionaryTypes = dictionaryTypeMapper.selectAll();

        for (DictionaryType dictionaryType : dictionaryTypes) {
            //取出字典类型的主键，查询该类型下的对应的values

            Example example = new Example(DictionaryValue.class);
            //按orderNo排序
            example.setOrderByClause("orderNo");
            example.createCriteria().andEqualTo("typeCode", dictionaryType.getCode());

            List<DictionaryValue> dictionaryValues = dictionaryValueMapper.selectByExample(example);
            //将dictionaryValues设置到字典类型中
            dictionaryType.setDictionaryValues(dictionaryValues);

        }
        return dictionaryTypes;
    }
}
