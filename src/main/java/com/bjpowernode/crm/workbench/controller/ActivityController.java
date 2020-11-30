package com.bjpowernode.crm.workbench.controller;

import com.bjpowernode.crm.aop.SysLog;
import com.bjpowernode.crm.base.bean.PaginationVo;
import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.constants.CrmConstants;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.settings.service.UserService;
import com.bjpowernode.crm.workbench.bean.Activity;
import com.bjpowernode.crm.workbench.bean.ActivityQueryVo;
import com.bjpowernode.crm.workbench.bean.ActivityRemark;
import com.bjpowernode.crm.workbench.service.ActivityService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * @author wj_willem
 * @version 1.0
 * @Description 活动控制层
 * @since 2020-11-17 16:50
 */
@Controller
public class ActivityController {

    @Autowired
    private ActivityService activityService;

    @Autowired
    private UserService userService;

    /**
     * 查询所有活动
     *
     * @param page            页面
     * @param pageSize        页面大小
     * @param activityQueryVo 活动查询实体类
     * @return {@link PaginationVo}
     */
    @SysLog(value = "日志列表查询")
    @RequestMapping("/workbench/activity/queryAllActivity")
    public @ResponseBody PaginationVo queryAllActivity(
            @RequestParam(defaultValue = "1",required = false) int page,
            @RequestParam(defaultValue = "2",required = false) int pageSize,
            ActivityQueryVo activityQueryVo){

        //开启分页功能
        PageHelper.startPage(page, pageSize);

        List<Map<String, String>> activityList = activityService.queryAllActivity(activityQueryVo);

        PageInfo<Map<String, String>> pageInfo = new PageInfo<>(activityList);
        //封装前台分页插件需要的数据
        PaginationVo paginationVo = new PaginationVo(pageInfo);

        return paginationVo;
    }

    /**
     * 异步查询所有用户
     *
     * @return {@link List<User>}
     */
    @SysLog(value = "用户查询")
    @RequestMapping("/workbench/activity/queryAllUsers")
    @ResponseBody
    public List<User> queryAllUsers(){
        return userService.queryAllUsers();
    }


    /**
     * 异步请求保存新建市场活动
     * @param activity
     * @param session
     * @return {@link ResultVo}
     */
    @SysLog(value = "添加市场活动")
    @RequestMapping("/workbench/activity/saveActivity")
    @ResponseBody
    public ResultVo saveActivity(Activity activity, HttpSession session){
        //获取登录用户
        User user = (User) session.getAttribute(CrmConstants.LOGIN_USER);
        //创建者
        activity.setCreateBy(user.getName());
        //编辑者
        activity.setEditBy(user.getName());

        ResultVo resultVo = new ResultVo();

        try {
            activityService.saveActivity(activity);
            resultVo.setSuccess(true);
            resultVo.setMessage("添加成功");
        } catch (CrmException e) {
            resultVo.setSuccess(false);
            //添加异常信息到resultVo
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;

    }

    /**
     * 查询活动通过id
     *
     * @param id id
     * @return {@link Activity}
     */
    @SysLog(value = "通过主键查询市场活动")
    @RequestMapping("/workbench/activity/queryActivityById")
    @ResponseBody
    public Activity queryActivityById(String id){
        return activityService.queryActivityById(id);
    }

    /**
     * 更新活动
     *
     * @param activity 活动
     * @param session  会话
     * @return {@link ResultVo}
     */
    @SysLog(value = "更新市场活动")
    @RequestMapping("/workbench/activity/updateActivity")
    @ResponseBody
    public ResultVo updateActivity(Activity activity, HttpSession session){
        //获取当前登录用户
        User user = (User) session.getAttribute(CrmConstants.LOGIN_USER);
        activity.setEditBy(user.getName());

        ResultVo resultVo = new ResultVo();
        try {
            activityService.updateActivity(activity);
            resultVo.setSuccess(true);
            resultVo.setMessage("更新成功");
        }catch (CrmException e){
            resultVo.setSuccess(false);
            //将异常信息添加到resultVo中
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;

    }


    /**
     * 删除活动根据主键
     *
     * @param id id
     * @return {@link ResultVo}
     */
    @SysLog(value = "通过主键删除市场活动")
    @RequestMapping("/workbench/activity/deleteActivity")
    @ResponseBody
    public ResultVo deleteActivity(String id){

        ResultVo resultVo = new ResultVo();
        try {
            activityService.deleteActivity(id);
            resultVo.setSuccess(true);
            resultVo.setMessage("删除成功");
        }catch (CrmException e){
            resultVo.setSuccess(false);
            //将异常信息添加到resultVo中
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    /**
     * 根据主键删除市场活动
     *
     * @param id id
     * @return {@link String}
     */
    @SysLog(value = "通过主键删除市场活动及备注")
    @RequestMapping("/workbench/activity/deleteActivityByDetail")
    public String deleteActivityByDetail(String id){
        try{
            //删除成功
            activityService.deleteActivity(id);
        }catch (CrmException e){
            e.printStackTrace();
        }
        return "redirect:/toView/activity/index";
    }

    /**
     * 通过id查询活动细节
     *
     * @param id    id
     * @param model 模型
     * @return {@link String}
     */
    @SysLog(value = "通过主键查询市场活动备注")
    @RequestMapping("/workbench/activity/queryActivityDetailById")
    public String queryActivityDetailById(String id, Model model){
        Activity activity = activityService.queryActivityDetailById(id);
        model.addAttribute("activity",activity);
        return "forward:/toView/activity/detail";
    }

    /**
     * 更新活动的备注
     *
     * @param activityRemark 活动的话
     * @return {@link ResultVo}
     */
    @SysLog(value = "更新市场活动备注")
    @RequestMapping("/workbench/activity/updateActivityRemark")
    @ResponseBody
    public ResultVo updateActivityRemark(ActivityRemark activityRemark){

        ResultVo resultVo = new ResultVo();
        try {
            activityService.updateActivityRemark(activityRemark);
            resultVo.setSuccess(true);
            resultVo.setMessage("修改备注成功");
        }catch (CrmException e){
            resultVo.setSuccess(false);
            //将异常信息添加到resultVo中
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    /**
     * 删除活动的备注
     *
     * @param id id
     * @return {@link ResultVo}
     */
    @SysLog(value = "删除市场活动备注")
    @RequestMapping("/workbench/activity/deleteActivityRemark")
    @ResponseBody
    public ResultVo deleteActivityRemark(String id){

        ResultVo resultVo = new ResultVo();
        try {
            activityService.deleteActivityRemark(id);
            resultVo.setSuccess(true);
            resultVo.setMessage("删除备注成功");
        }catch (CrmException e){
            resultVo.setSuccess(false);
            //将异常信息添加到resultVo中
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }


    /**
     * 添加市场活动备注
     *
     * @param activityRemark 活动备注
     * @param session        会话
     * @return {@link ResultVo}
     */
    @SysLog(value = "添加市场活动备注")
    @RequestMapping("/workbench/activity/saveActivityRemark")
    @ResponseBody
    public ResultVo saveActivityRemark(ActivityRemark activityRemark,HttpSession session){
        ResultVo resultVo = new ResultVo();
        try {
            //获取创建人
            User user = (User) session.getAttribute(CrmConstants.LOGIN_USER);
            activityRemark.setCreateBy(user.getName());
            activityService.saveActivityRemark(activityRemark);
            resultVo.setSuccess(true);
            resultVo.setMessage("添加市场活动备注成功");
        }catch (CrmException e){
            resultVo.setSuccess(false);
            //将异常信息添加到resultVo中
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

}
