package com.bjpowernode.crm.aop;


import com.bjpowernode.crm.base.constants.CrmConstants;
import com.bjpowernode.crm.base.util.MyUtil;
import com.bjpowernode.crm.base.util.WebUtils;
import com.bjpowernode.crm.logManage.bean.Log;
import com.bjpowernode.crm.logManage.service.LogService;
import com.bjpowernode.crm.settings.bean.User;
import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Method;
import java.util.Enumeration;

/**
 * @author wj_willem
 * @version 1.0
 * @Description 日志切点类
 * @since 2020-11-20 15:47
 */
@Aspect
@Component
@EnableAspectJAutoProxy
public  class SystemLogAspect {

    //注入Service用于把日志保存数据库
    @Autowired
    private LogService logService;
    //本地异常日志记录对象
    private  static  final Logger logger = LoggerFactory.getLogger(SystemLogAspect.class);

    //Controller层 切点
    @Pointcut("@annotation(com.bjpowernode.crm.aop.SysLog)")
    public  void controllerAspect() { }

    /**
     * 前置通知 用于拦截Controller层记录用户的操作
     *
     * @param joinPoint 切点
     */
//    ProceedingJoinPoint
    @Before("controllerAspect()")
    public  void doBefore(JoinPoint joinPoint) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        HttpSession session = request.getSession();
        // 请求用户名 (读取session中保存的用户信息)
        User user = (User) session.getAttribute(CrmConstants.LOGIN_USER);
        // 请求类
        String strClassName = joinPoint.getTarget().getClass().getName();
        // 请求地址
        String requestURI=request.getRequestURI();
        // 请求参数
        StringBuffer bfParams = new StringBuffer();
        Object[] params = joinPoint.getArgs();
        Enumeration<String> paraNames = null;
        if (params != null && params.length > 0) {
            paraNames = request.getParameterNames();
            String key;
            String value;
            while (paraNames.hasMoreElements()) {
                key = paraNames.nextElement();
                value = request.getParameter(key);
                bfParams.append(key).append("=").append(value).append("&");
            }
            if (StringUtils.isBlank(bfParams)) {
                bfParams.append(request.getQueryString());
            }
        }
        // 请求的IP
        String ip= WebUtils.getRemoteAddr(request);
        try {
            // System.out.println("=====前置通知开始=====");
            // 获取操作名称
            String operation=getControllerMethodDescription(joinPoint);
            // 获取登录用户名
            String loginName=user.getName();

            Log log = new Log();
            log.setLoginName(loginName);
            log.setOperationName(operation);
            log.setOperationClass(strClassName);
            log.setOperationAddress(requestURI);
            log.setParams(bfParams.toString());
            log.setIp(ip);
            log.setCreateTime(MyUtil.getNowDateStr2());
            //*========保存数据库日志=========*//
            System.out.println(log);
            // 保存数据库
            System.out.println("执行保存操作前");
            logService.insertLog(log);
            System.out.println("执行保存操作后");
        }  catch (Exception e) {
            //记录本地异常日志
            logger.error("==前置通知异常==");
            logger.error("异常信息:{}", e.getMessage());
        }
    }

    /**
     * 获取注解中对方法的描述信息 用于Controller层注解
     *
     * @param joinPoint 切点
     * @return 方法描述
     * @throws Exception
     */
    public  static String getControllerMethodDescription(JoinPoint joinPoint)  throws Exception {
        String targetName = joinPoint.getTarget().getClass().getName();
        String methodName = joinPoint.getSignature().getName();
        Object[] arguments = joinPoint.getArgs();
        Class targetClass = Class.forName(targetName);
        Method[] methods = targetClass.getMethods();
        String description = "";
        for (Method method : methods) {
            if (method.getName().equals(methodName)) {
                Class[] clazzs = method.getParameterTypes();
                if (clazzs.length == arguments.length) {
                    description = method.getAnnotation(SysLog.class).value();
                    break;
                }
            }
        }
        return description;
    }
}
