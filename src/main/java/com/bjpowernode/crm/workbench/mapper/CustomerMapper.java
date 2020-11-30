package com.bjpowernode.crm.workbench.mapper;

import com.bjpowernode.crm.workbench.bean.Customer;
import com.bjpowernode.crm.workbench.bean.CustomerQueryVo;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;
import java.util.Map;

/**
 * 客户映射器
 *
 * @author wj_willem
 * @date 2020/11/30
 */
public interface CustomerMapper extends Mapper<Customer> {
    //查询所有客户信息
    List<Map<String, String>> saveAllCustomer(CustomerQueryVo customerQueryVo);
}
