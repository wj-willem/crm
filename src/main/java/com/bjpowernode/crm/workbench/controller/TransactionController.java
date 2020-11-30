package com.bjpowernode.crm.workbench.controller;

import com.bjpowernode.crm.aop.SysLog;
import com.bjpowernode.crm.base.constants.CrmConstants;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.bean.Transaction;
import com.bjpowernode.crm.workbench.bean.TransactionEchartsResultVo;
import com.bjpowernode.crm.workbench.service.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;


@Controller
public class TransactionController {


    @Autowired
    private TransactionService transactionService;

    //只能给前端返回字符串{1,2,3,4}
    @SysLog(value = "客户智能补全")
    @RequestMapping("/workbench/transaction/queryCustomerName")
    @ResponseBody
    public List<String> queryCustomerName(String customerName){
        return transactionService.queryCustomerName(customerName);
    }

    //选中阶段，向后台发送异步请求查询阶段对应的可能性
    @SysLog(value = "查询阶段对应可能性")
    @RequestMapping("/workbench/transaction/queryPossibilityByStage")
    @ResponseBody
    public String queryPossibilityByStage(String stage, HttpSession session){
        Map<String,String> stage2PossibilityMap =
                (Map<String, String>) session.getServletContext().getAttribute("stage2PossibilityMap");
        return stage2PossibilityMap.get(stage);
    }

    //保存交易
    @RequestMapping("/workbench/transaction/saveTransaction")
    public String saveTransaction(Transaction transaction, String company, HttpSession session){
        User user = (User) session.getAttribute(CrmConstants.LOGIN_USER);
        transaction.setCreateBy(user.getName());
        transactionService.saveTransaction(transaction,company);
        return "/transaction/index";
    }

    //异步查询客户的主键
    @RequestMapping("/workbench/transaction/queryCustomerByName")
    @ResponseBody
    public String queryCustomerByName(String name){
        String customerId = transactionService.queryCustomerByName(name);
        return customerId;
    }

    //从交易列表页面点击具体交易，查询出对应交易信息，跳转到交易详情页面
    @RequestMapping("/workbench/transaction/queryTransactionById")
    public String queryTransactionById(String id, HttpSession session, Model model){
        Map<String,String> map =
                (Map<String, String>) session.getServletContext().getAttribute("stage2PossibilityMap");
        Transaction transaction = transactionService.queryTransactionById(id,map);
        model.addAttribute("transaction",transaction);
        return "/transaction/detail";
    }


    //返回交易阶段图标,同时支持交易详情点击交易图标，改变交易阶段的状态
    @RequestMapping("/workbench/transaction/stageList")
    @ResponseBody
    public List<Map<String, ? extends Object>> stageList(Integer index,String tranId,HttpSession session){
        Map<String,String> map =
                (Map<String, String>) session.getServletContext().getAttribute("stage2PossibilityMap");
        User user = (User) session.getAttribute(CrmConstants.LOGIN_USER);
        List<Map<String, ? extends Object>> stageList = transactionService.stageList(user.getName(),index,tranId,map);
        return stageList;
    }

    //异步查询统计交易图表信息
    @RequestMapping("/workbench/chart/transaction/queryTransactionEcharts")
    @ResponseBody
    public TransactionEchartsResultVo queryTransactionEcharts(){
        return transactionService.queryTransactionEcharts();
    }
}