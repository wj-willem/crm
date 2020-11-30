package com.bjpowernode.crm.base.cache;

import com.bjpowernode.crm.base.bean.DictionaryType;
import com.bjpowernode.crm.settings.service.DictionaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import java.util.*;

/**
 * @author wj_willem
 * @version 1.0
 * @Description 数据字典
 * @since 2020-11-25 8:40
 */
@Component
public class CrmCache {

    @Autowired
    private DictionaryService dictionaryService;

    @Autowired
    private ServletContext servletContext;


   // @PostConstruct
    public void cache(){
        //数据字典数据缓冲
        List<DictionaryType> dictionaryTypes = dictionaryService.queryDictionary();
        //将dictionaryTypes设置到servlContext中
        servletContext.setAttribute("dictionaryTypes",dictionaryTypes);



        //读取Stage2Possibility.properties文件到域对象中(包名.属性文件名)不呀后缀名
        ResourceBundle resourceBundle = ResourceBundle.getBundle("mybatis.Stage2Possibility");
        //获取所有的key
        Enumeration<String> keys = resourceBundle.getKeys();

        //把所有阶段和可能性放到map中
        Map<String, String> map = new HashMap<>();
        while (keys.hasMoreElements()){
            String key = keys.nextElement();
            String value = resourceBundle.getString(key);
            map.put(key, value);
        }
        //将map设置到servlContext中
        servletContext.setAttribute("stage2PossibilityMap",map);
    }
}
