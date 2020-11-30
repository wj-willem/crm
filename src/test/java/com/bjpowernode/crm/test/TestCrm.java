package com.bjpowernode.crm.test;

import com.bjpowernode.crm.base.constants.CrmExceptionEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.util.DateTimeUtil;
import com.bjpowernode.crm.base.util.MD5Util;
import com.bjpowernode.crm.base.util.UUIDUtil;
import com.bjpowernode.crm.workbench.mapper.ActivityMapper;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;
import java.util.Map;

public class TestCrm {


    //测试主键生成UUID
    @Test
    public void test01(){
        String uuid = UUIDUtil.getUUID();

        System.out.println(uuid);
    }

    //测试MD5加密
    @Test
    public void test02(){
        //测试md5加密
        String admin = MD5Util.getMD5("suibian");

        System.out.println(admin);
    }

    //测试日期比较
    //now>time 返回值>0 now < time 返回值<0
    @Test
    public void test03(){
        String now = DateTimeUtil.getSysTime();

        String time = "2032-02-10";

        System.out.println(now.compareTo(time));
    }

    //测试自定义异常
    @Test
    public void test04(){
//        System.out.println(CrmExceptionEnum.LOGIN_ACCOUNT_ERROR.getMess());
        try{
            int a = 0;
            if(a == 0){
                throw new CrmException(CrmExceptionEnum.LOGIN_ACCOUNT_ERROR);
            }
        }catch (Exception e){
            System.out.println(e.getMessage());
        }

    }

    //测试查询所有市场活动信息数据
/*    @Test
    public void test05(){
        BeanFactory beanFactory =
                new ClassPathXmlApplicationContext("spring/applicationContext.xml");
        SqlSessionFactory sqlSessionFactory = (SqlSessionFactory) beanFactory.getBean("sqlSessionFactory");
        ActivityMapper activityMapper = sqlSessionFactory.openSession().getMapper(ActivityMapper.class);
        List<Map<String, String>> maps = activityMapper.queryAllActivity();
        System.out.println(maps);
    }*/
}