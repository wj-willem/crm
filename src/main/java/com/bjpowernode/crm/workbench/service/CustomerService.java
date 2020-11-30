package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.workbench.bean.Customer;
import com.bjpowernode.crm.workbench.bean.CustomerQueryVo;
import com.bjpowernode.crm.workbench.bean.CustomerRemark;

import java.util.List;
import java.util.Map;

/**
 * @author wj_willem
 * @version 1.0
 * @Description
 * @since 2020-11-30 8:39
 */
public interface CustomerService {


    //新建客户
    void add_customer(Customer customer);

    //根据主键查询客户
    Customer saveCustomerById(String id);

    //根据主键进行更新
    void updateCustomerById(Customer customer);

    //根据主键进行删除
    void delete_customer(String id);

    //根据主键进行查询客户及其备注的信息
    Customer saveCustomerRemark(String id);

    //根据主键修改备注
    void updateCustomerRemark(CustomerRemark customerRemark);

    //根据主键删除备注
    void deleteCustomerRemark(String id);
    //添加备注
    CustomerRemark addCustomerRemark(CustomerRemark customerRemark);
    //异步查询所有的客户姓名
    List<String> queryCustomerName(String customerName);
    //根据客户姓名异步查询客户id
    String saveCustomerName(String company);

    List<Map<String, String>> saveAllCustomer(CustomerQueryVo customerQueryVo);
}
