package com.bjpowernode.crm.settings.service.impl;

import com.bjpowernode.crm.base.constants.CrmExceptionEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.util.DateTimeUtil;
import com.bjpowernode.crm.base.util.MD5Util;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import com.bjpowernode.crm.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author wj_willem
 * @version 1.0
 * @Description
 * @since 2020-11-16 20:00
 */
@Service("userService")
public class UserServiceImpl implements UserService {


    @Autowired
    private UserMapper userMapper;

    @Override
    public User login(User user) {
        //将用户输入的密码加密
        String md5Pwd = MD5Util.getMD5(user.getLoginPwd());
        user.setLoginPwd(md5Pwd);

        //获取当前用户登录的IP地址
        String userAllowIps = user.getAllowIps();
        user.setAllowIps(null);
        user = userMapper.selectOne(user);

        //用户名密码错误
        if(user==null){
            throw new CrmException(CrmExceptionEnum.LOGIN_ACCOUNT_ERROR);
        }else{
            //检验用户是否失效
            String expireTime = user.getExpireTime();
            String sysTime = DateTimeUtil.getSysTime();

            //失效了
            if(sysTime.compareTo(expireTime)>0){
                throw new CrmException(CrmExceptionEnum.LOGIN_ACCOUNT_EXPIRED);
            }
            //用户账户是否被禁用 0:禁用 1:可用
            if ("0".equals(user.getLockState())){
                throw new CrmException(CrmExceptionEnum.LOGIN_ACCOUNT_FORBID);
            }
            if (user.getAllowIps()!=null){
                if (user.getAllowIps().contains(userAllowIps)){
                    throw new CrmException(CrmExceptionEnum.LOGIN_ACCOUNT_IP);
                }
            }
        }
        return user;
    }

    @Override
    public List<User> queryAllUsers() {
        return userMapper.selectAll();
    }
}
