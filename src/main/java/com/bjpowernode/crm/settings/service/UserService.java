package com.bjpowernode.crm.settings.service;

import com.bjpowernode.crm.settings.bean.User;

import java.util.List;

/**
 * @author wj_willem
 * @version 1.0
 * @Description
 * @since 2020-11-16 19:32
 */
public interface UserService {

    User login(User user);

    List<User> queryAllUsers();
}
