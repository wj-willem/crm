package com.bjpowernode.crm.logManage.controller;


import cn.hutool.core.io.IoUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.bjpowernode.crm.aop.SysLog;
import com.bjpowernode.crm.base.bean.PaginationVo;
import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.logManage.bean.Log;
import com.bjpowernode.crm.logManage.bean.LogVo;
import com.bjpowernode.crm.logManage.service.LogService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@Controller
public class LogController{

    @Autowired
    private LogService logService;

    //@SysLog(value = "日志列表查询")
    @RequestMapping("/workbench/log/queryAllLogs")
    public @ResponseBody
    PaginationVo queryAllLogs(
            @RequestParam(defaultValue = "1",required = false) int page,
            @RequestParam(defaultValue = "5",required = false) int pageSize,
            LogVo logVo){

        //开启分页功能
        PageHelper.startPage(page, pageSize);

        List<Map<String, String>> logsList = logService.queryAllLogs(logVo);

        PageInfo<Map<String, String>> pageInfo = new PageInfo<>(logsList);
        //封装前台分页插件需要的数据
        PaginationVo paginationVo = new PaginationVo(pageInfo);

        //System.out.println(paginationVo);

        return paginationVo;

    }


    /**
     * 删除日志
     *
     * @param ids id
     * @return {@link ResultVo}
     */
    @RequestMapping("/workbench/log/deleteLogs")
    @ResponseBody
    public ResultVo deleteLogs(String ids){
        ResultVo resultVo = new ResultVo();
        try{
            logService.deleteLogs(ids);
            resultVo.setSuccess(true);
            resultVo.setMessage("日志删除成功");
        }catch (CrmException e){
            resultVo.setSuccess(false);
            resultVo.setMessage(e.getMessage());
        }

        return resultVo;
    }


    @RequestMapping("workbench/log/logExport")
    public String  logExport(HttpServletResponse response){
        List<Log> logList = logService.logExport();
        ExcelWriter writer = null;
        ServletOutputStream out = null;
        try {
            // 通过工具类创建writer，默认创建xls格式
            writer = ExcelUtil.getWriter();
            // 一次性写出内容，使用默认样式，强制输出标题
            writer.write(logList, true);
            //out为OutputStream，需要写出到的目标流

            //response为HttpServletResponse对象
            response.setContentType("application/vnd.ms-excel;charset=utf-8");
            //test.xls是弹出下载对话框的文件名，不能为中文，中文请自行编码
            response.setHeader("Content-Disposition", "attachment;filename=log.xls");
            out= response.getOutputStream();
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            writer.flush(out, true);
            // 关闭writer，释放内存
            writer.close();
            //此处记得关闭输出Servlet流
            IoUtil.close(out);
        }
        return "log/log";
    }


}
