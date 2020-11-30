package com.bjpowernode.crm.aop;

import java.lang.annotation.*;

/**
 * @author wj_willem
 * @version 1.0
 * @Description 自定义注解，实现日志系统
 * @since 2020-11-20 15:47
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface SysLog {
    String value() default "";
}
