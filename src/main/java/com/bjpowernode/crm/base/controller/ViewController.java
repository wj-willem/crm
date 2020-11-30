package com.bjpowernode.crm.base.controller;

import com.bjpowernode.crm.aop.SysLog;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.File;

/**
 * @author wj_willem
 * @version 1.0
 * @Description 视图转发控制器
 * @since 2020-11-16 20:32
 */
@Controller
public class ViewController {

    @SysLog(value = "页面跳转控制器")
    //跳转所有视图    required:默认是true,每次必须给该变量传值，false可以传值，也可以不传值
    @RequestMapping({"/toView/{firstView}/{secondView}/{finalView}","/toView/{firstView}/{finalView}","/toView/{finalView}"})
    public String toView(
            @PathVariable(value = "firstView",required = false) String firstView,
            @PathVariable(value = "secondView",required = false) String secondView,
            @PathVariable("finalView") String finalView){

        if(firstView != null){
            if(secondView != null){
                return firstView + File.separator + secondView + File.separator + finalView;
            }
            return firstView + File.separator + finalView;
        }else{
            return finalView;
        }
    }
}
