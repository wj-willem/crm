package com.bjpowernode.crm.workbench.service.impl;


import com.bjpowernode.crm.base.constants.CrmExceptionEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.util.DateTimeUtil;
import com.bjpowernode.crm.base.util.UUIDUtil;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import com.bjpowernode.crm.workbench.bean.*;
import com.bjpowernode.crm.workbench.mapper.ContactsMapper;
import com.bjpowernode.crm.workbench.mapper.CustomerMapper;
import com.bjpowernode.crm.workbench.mapper.CustomerRemarkMapper;
import com.bjpowernode.crm.workbench.mapper.TranMapper;
import com.bjpowernode.crm.workbench.service.CustomerService;
import org.aspectj.bridge.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;


@Service
public class CustomerServiceImpl implements CustomerService {
    @Autowired
    private CustomerMapper customerMapper;
    @Autowired
    private CustomerRemarkMapper customerRemarkMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private TranMapper tranMapper;
    @Autowired
    private ContactsMapper contactsMapper;



    //根据客户姓名异步查询客户id
    @Override
    public String saveCustomerName(String company) {
        Example example = new Example(Customer.class);
        example.createCriteria().andEqualTo("name",company);
        List<Customer> customers = customerMapper.selectByExample(example);
        if (customers.size()>0){
            return customers.get(0).getId();
        }else {
            //客户不存在，创建客户
            return "1";
        }
    }

    //异步查询所有的客户姓名
    @Override
    public List<String> queryCustomerName(String customerName) {
        Example example = new Example(Customer.class);
        example.createCriteria().andLike("name","%"+customerName+"%");
        List<Customer> customers = customerMapper.selectByExample(example);
        List<String>list=new ArrayList<>();
        for (Customer customer : customers) {
            list.add(customer.getName());
        }
        return list;
    }

    //查询所有客户信息
    @Override
    public List<Map<String, String>> saveAllCustomer(CustomerQueryVo customerQueryVo) {
        return customerMapper.saveAllCustomer(customerQueryVo);
    }

    //新建客户
    @Override
    public void add_customer(Customer customer) {
        //设置创建时间
        customer.setCreateTime(DateTimeUtil.getSysTime());
        //设置主键
        customer.setId(UUIDUtil.getUUID());
        //执行新建客户方法
        int i = customerMapper.insertSelective(customer);
        if (i == 0) {
            throw new CrmException(CrmExceptionEnum.CUSTOMER_CREATE_FAIL);
        }
    }

    //根据主键查询客户信息
    @Override
    public Customer saveCustomerById(String id) {
        return customerMapper.selectByPrimaryKey(id);
    }

    //更具主键进行更新
    @Override
    public void updateCustomerById(Customer customer) {
        //设置修改时间
        customer.setEditTime(DateTimeUtil.getSysTime());
        int i = customerMapper.updateByPrimaryKeySelective(customer);
        if (i == 0) {
            throw new CrmException(CrmExceptionEnum.CUSTOMER_UPDATE_FAIL);
        }
    }

    //根据主键进行删除
    @Override
    public void delete_customer(String id) {
        //删除客户
        customerMapper.deleteByPrimaryKey(id);
        Example example = new Example(CustomerRemark.class);
        example.createCriteria().andEqualTo("customerId", id);
        int i = customerRemarkMapper.selectCountByExample(example);
        if (i > 0) {
            customerRemarkMapper.deleteByExample(example);
        }
        //删除客户的备注
        example = new Example(CustomerRemark.class);
        example.createCriteria().andEqualTo("customerId",id);
        List<CustomerRemark> customerRemarks = customerRemarkMapper.selectByExample(example);
        if (customerRemarks.size()>0){
            i  = customerRemarkMapper.deleteByExample(example);
            if (i > 0) {
                customerRemarkMapper.deleteByExample(example);
            }
        }
    }

    //根据主键进行查询客户及其备注的信息
    @Override
    public Customer saveCustomerRemark(String id) {
        //查询客户信息
        Customer customer = customerMapper.selectByPrimaryKey(id);
        //查询所有人姓名
        User user = userMapper.selectByPrimaryKey(customer.getOwner());
        customer.setOwner(user.getName());
        //查询备注
        Example example = new Example(CustomerRemark.class);
        example.createCriteria().andEqualTo("customerId", id);
        List<CustomerRemark> customerRemarks = customerRemarkMapper.selectByExample(example);
        customer.setCustomerRemarks(customerRemarks);
        //查询客户名下所有交易
        example=new Example(Tran.class);
        example.createCriteria().andEqualTo("customerId",customer.getId());
        List<Tran> trans = tranMapper.selectByExample(example);
        customer.setTrans(trans);
        //查询客户相关联系人
        example=new Example(Contacts.class);
        example.createCriteria().andEqualTo("customerId",customer.getId());
        List<Contacts> contacts = contactsMapper.selectByExample(example);
        customer.setContacts(contacts);
        return customer;
    }

    //根据主键修改备注
    @Override
    public void updateCustomerRemark(CustomerRemark customerRemark) {
        customerRemark.setEditFlag("1");
        customerRemark.setEditTime(DateTimeUtil.getSysTime());
        int i = customerRemarkMapper.updateByPrimaryKeySelective(customerRemark);
        if (i==0){
            throw new CrmException(CrmExceptionEnum.CUSTOMER_REMARK_UPDATE_FAIL);
        }
    }
    //根据主键删除备注
    @Override
    public void deleteCustomerRemark(String id) {
        int i = customerRemarkMapper.deleteByPrimaryKey(id);
        if (i==0){
            throw new CrmException(CrmExceptionEnum.CUSTOMER_REMARK_DELETE_FAIL);
        }
    }
    //添加备注
    @Override
    public CustomerRemark addCustomerRemark(CustomerRemark customerRemark) {
        //创建时间
        customerRemark.setCreateTime(DateTimeUtil.getSysTime());
        //设置修改状态
        customerRemark.setEditFlag("0");
        //设置主键
        customerRemark.setId(UUIDUtil.getUUID());
        int i = customerRemarkMapper.insertSelective(customerRemark);
        if (i==0){
            throw new CrmException(CrmExceptionEnum.CUSTOMER_REMARK_ADD_FAIL);
        }
        return customerRemark;
    }
}
