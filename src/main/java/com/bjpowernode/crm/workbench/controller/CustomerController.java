package com.bjpowernode.crm.workbench.controller;

import com.bjpowernode.crm.base.bean.PaginationVo;
import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.constants.CrmConstants;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.bean.Customer;
import com.bjpowernode.crm.workbench.bean.CustomerQueryVo;
import com.bjpowernode.crm.workbench.bean.CustomerRemark;
import com.bjpowernode.crm.workbench.service.CustomerService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.aspectj.bridge.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;


@Controller
public class CustomerController {
    @Autowired
    private CustomerService customerService;

    //根据客户姓名异步查询客户id
    @RequestMapping("/workbench/customer/saveCustomerName")
    @ResponseBody
    public ResultVo saveCustomerName(String company){
        ResultVo resultVo = new ResultVo();
        String customerId=customerService.saveCustomerName(company);
        resultVo.setMessage(customerId);
        return resultVo;

    }
    //异步查询所有的客户姓名
    @RequestMapping("/workbench/customer/queryCustomerName")
    @ResponseBody
    public List<String> queryCustomerName(String customerName) {
        return customerService.queryCustomerName(customerName);
    }

    //添加备注
    @RequestMapping("/workbench/addCustomerRemark")
    public @ResponseBody
    CustomerRemark addCustomerRemark(CustomerRemark customerRemark, HttpSession session) {
        User user = (User) session.getAttribute(CrmConstants.LOGIN_USER);
        customerRemark.setCreateBy(user.getName());
        try {
            customerRemark = customerService.addCustomerRemark(customerRemark);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return customerRemark;
    }

    //根据主键删除备注
    @RequestMapping("/workbench/deleteCustomerRemark")
    public @ResponseBody
    ResultVo deleteCustomerRemark(String id) {
        ResultVo resultVo = new ResultVo();
        try {
            customerService.deleteCustomerRemark(id);
            resultVo.setSuccess(true);
            resultVo.setMessage("备注删除成功");
        } catch (CrmException e) {
            resultVo.setSuccess(false);
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //修改备注
    @RequestMapping("/workbench/updateCustomerRemark")
    public @ResponseBody
    ResultVo updateCustomerRemark(CustomerRemark customerRemark, HttpSession session) {
        User user = (User) session.getAttribute(CrmConstants.LOGIN_USER);
        customerRemark.setEditBy(user.getName());
        ResultVo resultVo = new ResultVo();
        try {
            customerService.updateCustomerRemark(customerRemark);
            resultVo.setSuccess(true);
            resultVo.setMessage("修改备注成功");
        } catch (CrmException e) {
            resultVo.setSuccess(false);
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //根据主键查询详情信息
    @RequestMapping("/workbench/saveCustomerRemark")
    public String saveCustomerRemark(@RequestParam("id") String id, HttpServletRequest request) {
        Customer customer = customerService.saveCustomerRemark(id);
        request.setAttribute("customer", customer);
        return "/customer/detail";
    }

    //根据主键进行删除
    @RequestMapping("/workbench/delete_customer")
    public String delete_customer(@RequestParam("id") String id) {
        try {
            customerService.delete_customer(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "/customer/index";
    }

    //更具主键进行更新
    @RequestMapping("/workbench/updateCustomerById")
    @ResponseBody
    public ResultVo updateCustomerById(Customer customer, HttpSession session) {
        ResultVo resultVo = new ResultVo();
        User user = (User) session.getAttribute(CrmConstants.LOGIN_USER);
        customer.setEditBy(user.getName());
        try {
            customerService.updateCustomerById(customer);
            resultVo.setSuccess(true);
            resultVo.setMessage("更新客户信息成功");
        } catch (CrmException e) {
            resultVo.setSuccess(false);
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //根据主键查询客户信息
    @RequestMapping("/workbench/saveCustomerById")
    @ResponseBody
    public Customer saveCustomerById(@RequestParam("id") String id) {
        Customer customer = customerService.saveCustomerById(id);
        return customer;
    }

    @RequestMapping("/workbench/create_customer")
    @ResponseBody
    public ResultVo add_customer(Customer customer, HttpSession session) {
        ResultVo resultVo = new ResultVo();
        User user = (User) session.getAttribute(CrmConstants.LOGIN_USER);
        //加入创建者
        customer.setCreateBy(user.getName());
        try {
            customerService.add_customer(customer);
            resultVo.setSuccess(true);
            resultVo.setMessage("用户添加成功");
        } catch (CrmException e) {
            resultVo.setSuccess(false);
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //查询所有客户信息
    @RequestMapping("/workbench/customer/saveAllCustomer")
    public @ResponseBody
    PaginationVo saveAllCustomer(@RequestParam(defaultValue = "1", required = false) int page,
                                 @RequestParam(defaultValue = "2", required = false) int pageSize,
                                 CustomerQueryVo customerQueryVo) {
        PageHelper.startPage(page, pageSize);
        List<Map<String, String>> list = customerService.saveAllCustomer(customerQueryVo);
        PageInfo<Map<String, String>> pageInfo = new PageInfo<>(list);
        PaginationVo paginationVo = new PaginationVo(pageInfo);
        return paginationVo;
    }
}
