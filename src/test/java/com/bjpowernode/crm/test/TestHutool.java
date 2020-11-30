package com.bjpowernode.crm.test;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.bjpowernode.crm.workbench.bean.Transaction;
import com.bjpowernode.crm.workbench.mapper.TransactionMapper;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.lang.NonNull;

import java.util.ArrayList;
import java.util.List;

/**
 * @author wj_willem
 * @version 1.0
 * @Description
 * @since 2020-11-28 16:52
 */
public class TestHutool {
    @Test
    public void test10(){
        BeanFactory beanFactory =
                new ClassPathXmlApplicationContext("spring/applicationContext.xml");
        SqlSessionFactory sqlSessionFactory = (SqlSessionFactory) beanFactory.getBean("sqlSessionFactory");
        TransactionMapper transactionMapper = sqlSessionFactory.openSession().getMapper(TransactionMapper.class);


        List<List<String>> data = new ArrayList<>();
        List<Transaction> transactions = transactionMapper.selectAll();


        //交易的字段名称
        List<String> titles = CollUtil.newArrayList("所有者","金额","名称","预计成交日期","客户",
                "阶段","类型","来源","市场活动","联系人","创建人","创建时间"
                ,"修改人","修改时间","描述","联系纪要","下次联系时间");
        data.add(titles);
        for(int i = 0 ; i < transactions.size(); i++){
            Transaction transaction = transactions.get(i);
            for(int j = 0 ; j < titles.size(); j++) {

                List<String> row  = CollUtil.newArrayList(transaction.getOwner(), transaction.getMoney(), transaction.getName(),
                        transaction.getExpectedDate(), transaction.getCustomerId(), transaction.getStage(), transaction.getType(),
                        transaction.getSource(), transaction.getActivityId(), transaction.getContactsId(), transaction.getCreateBy(),
                        transaction.getCreateTime(), transaction.getEditBy(), transaction.getEditTime(), transaction.getDescription(),
                        transaction.getContactSummary(), transaction.getNextContactTime());
                data.add(row);
            }
        }





        ExcelWriter excelWriter = ExcelUtil.getWriter("d:/交易.xls");
        excelWriter.merge(titles.size() - 1, "交易报表新");
        excelWriter.write(data, true);
        //关闭writer，释放内存
        excelWriter.close();
    }



}
