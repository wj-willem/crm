package com.bjpowernode.crm.workbench.controller;

import com.bjpowernode.crm.aop.SysLog;
import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.constants.CrmConstants;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.bean.*;
import com.bjpowernode.crm.workbench.service.ClueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @ProjectName: crm
 * @Package: com.bjpowernode.crm.workbench.controller
 * @Description: java类作用描述
 * @Author: Andy
 * @CreateDate: 2020/11/21 14:24
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
@Controller
public class ClueController {

    @Autowired
    private ClueService clueService;


    @SysLog(value = "线索添加")
    @RequestMapping("/workbench/clue/saveClue")
    @ResponseBody
    public ResultVo saveClue(Clue clue, HttpSession session){

        ResultVo resultVo = new ResultVo();
        try{
            User user = (User) session.getAttribute(CrmConstants.LOGIN_USER);
            clue.setCreateBy(user.getName());
            clueService.saveClue(clue);
            resultVo.setSuccess(true);
            resultVo.setMessage("添加线索成功");
        }catch (CrmException e){
            resultVo.setSuccess(false);
            resultVo.setMessage(e.getMessage());
        }

        return resultVo;
    }

    //根据线索id查询线索信息及其线索备注
    @SysLog(value = "查询线索信息及其备注")
    @RequestMapping("/workbench/clue/queryClueDetailById")
    public String queryClueDetailById(String id, Model model){

        Clue clue = clueService.queryClueDetailById(id);
        model.addAttribute("clue",clue);
        return "/clue/detail";
    }

    //更新线索备注
    @SysLog(value = "更新线索备注")
    @RequestMapping("/workbench/clue/updateClueRemark")
    @ResponseBody
    public ResultVo updateClueRemark(ClueRemark clueRemark,HttpSession session){
        ResultVo resultVo = new ResultVo();
        try{
            User user = (User) session.getAttribute(CrmConstants.LOGIN_USER);
            clueRemark.setEditBy(user.getName());
            clueService.updateClueRemark(clueRemark);
            resultVo.setSuccess(true);
            resultVo.setMessage("更新线索备注成功");
        }catch (CrmException e){
            resultVo.setSuccess(false);
            resultVo.setMessage(e.getMessage());
        }

        return resultVo;
    }

    //添加线索备注
    @SysLog(value = "添加线索备注")
    @RequestMapping("/workbench/clue/saveClueRemark")
    @ResponseBody
    public ResultVo saveClueRemark(ClueRemark clueRemark,HttpSession session){
        ResultVo resultVo = new ResultVo();
        try{
            User user = (User) session.getAttribute(CrmConstants.LOGIN_USER);
            clueRemark.setCreateBy(user.getName());
            clueService.saveClueRemark(clueRemark);
            resultVo.setSuccess(true);
            resultVo.setMessage("添加线索备注成功");
        }catch (CrmException e){
            resultVo.setSuccess(false);
            resultVo.setMessage(e.getMessage());
        }

        return resultVo;
    }

    //解除线索和市场活动的关联
    @SysLog(value = "解除线索和市场活动关联")
    @RequestMapping("/workbench/clue/deleteBind")
    @ResponseBody
    public ResultVo deleteBind(ClueActivityRelation clueActivityRelation){
        ResultVo resultVo = new ResultVo();
        try{
            clueService.deleteBind(clueActivityRelation);
            resultVo.setSuccess(true);
            resultVo.setMessage("线索和市场活动解绑成功");
        }catch (CrmException e){
            resultVo.setSuccess(false);
            resultVo.setMessage(e.getMessage());
        }

        return resultVo;
    }

    //解除多个线索和市场活动的关联
    @SysLog(value = "解除多个线索和市场活动关联")
    @RequestMapping("/workbench/clue/deleteManyBind")
    @ResponseBody
    public ResultVo deleteManyBind(String clueId,String activityIds){
        ResultVo resultVo = new ResultVo();
        try{
            clueService.deleteManyBind(clueId,activityIds);
            resultVo.setSuccess(true);
            resultVo.setMessage("线索和市场活动解绑成功");
        }catch (CrmException e){
            resultVo.setSuccess(false);
            resultVo.setMessage(e.getMessage());
        }

        return resultVo;
    }

    //查询所有市场活动，但是不包含当前线索的市场活动
    @SysLog(value = "查询市场活动")
    @RequestMapping("/workbench/clue/queryActivityExculdeNow")
    @ResponseBody
    public List<Activity> queryActivityExculdeNow(String clueId,String activityName){
        List<Activity> activities = clueService.queryActivityExculdeNow(clueId,activityName);
        return activities;
    }

    //线索转换发生交易查询当前线索下的所有市场活动
    @SysLog(value = "线索转换-查询当前线索下所有市场活动")
    @RequestMapping("/workbench/clue/queryActivityIncludeNow")
    @ResponseBody
    public List<Activity> queryActivityIncludeNow(String clueId,String activityName){
        List<Activity> activities = clueService.queryActivityIncludeNow(clueId,activityName);
        return activities;
    }

    //保存线索和市场活动的关联
    @SysLog(value = "保存线索和市场活动的关联")
    @RequestMapping("/workbench/clue/saveBind")
    @ResponseBody
    public ResultVo saveBind(String clueId,String activityIds){
        ResultVo resultVo = new ResultVo();
        try{
            clueService.saveBind(clueId,activityIds);
            resultVo.setSuccess(true);
            resultVo.setMessage("线索和市场活动绑定成功");
        }catch (CrmException e){
            resultVo.setSuccess(false);
            resultVo.setMessage(e.getMessage());
        }

        return resultVo;
    }

    //线索和市场活动关联成功后，再异步查询关联后的所有市场活动
    @SysLog(value = "查询关联后的市场活动")
    @RequestMapping("/workbench/clue/queryClueActivity")
    @ResponseBody
    public List<Activity> queryClueActivity(String clueId){
        List<Activity> activities = clueService.queryClueActivity(clueId);
        return activities;
    }

    //跳转到线索转换页面
    @SysLog(value = "跳转线索转换页")
    @RequestMapping("/workbench/clue/toConvertView")
    public String toConvertView(String id,Model model){
        Clue clue = clueService.queryClueDetailById(id);
        model.addAttribute("clue",clue);
        return "/clue/convert";
    }

    //转换
    @RequestMapping("/workbench/clue/convert")
    /*
    * transaction:用于接收创建交易的表单
    * clueId:线索id
    * isCreateTransaction:是否进行交易
    * */
    @SysLog(value = "线索转换")
    public String convert(Transaction transaction, String clueId, HttpSession session, String isCreateTransaction){
        User user = (User) session.getAttribute(CrmConstants.LOGIN_USER);
        clueService.saveConvert(transaction,clueId,user.getName(),isCreateTransaction);
        return "redirect:/toView/clue/index";
    }


    @RequestMapping("/workbench/chart/clue/queryClueEcharts")
    @ResponseBody
    public ClueEchartsResultVo queryClueEcharts(){
        return clueService.queryClueEcharts();
    }
}