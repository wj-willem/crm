package com.bjpowernode.crm.settings.controller;

import com.bjpowernode.crm.aop.SysLog;
import com.bjpowernode.crm.base.constants.CrmConstants;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;

/**
 * @author wj_willem
 * @version 1.0
 * @Description 用户控制层
 * @since 2020-11-16 19:31
 */
@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @SysLog(value = "用户登录系统")
    @PostMapping("/settings/user/login")
    public String login(User user, Model model, HttpSession session, HttpServletRequest request) {

        //获取用户当前登录IP地址
        String remoteAddr = request.getRemoteAddr();
        user.setAllowIps(remoteAddr);

        try {
            user = userService.login(user);
            session.setAttribute(CrmConstants.LOGIN_USER,user);
        } catch (CrmException e) {
            //登录失败，各种异常
            String message = e.getMessage();
            model.addAttribute("message", message);
            //转发到登录页面，显示错误信息
            return "../../login";
        }
        return "index";
    }


    //退出系统
    @SysLog(value = "用户退出登录")
    @RequestMapping("/settings/user/loginOut")
    public String loginOut(HttpSession session){
        //从session移除用户
        session.removeAttribute(CrmConstants.LOGIN_USER);
        return "redirect:/login.jsp";
    }

}
