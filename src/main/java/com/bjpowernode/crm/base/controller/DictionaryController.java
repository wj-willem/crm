package com.bjpowernode.crm.base.controller;

import com.bjpowernode.crm.base.bean.DictionaryType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import java.util.List;


@RestController
public class DictionaryController {

    @RequestMapping("/dictionaryCache")
    public List<DictionaryType> dictionaryCache(HttpSession session){
        ServletContext servletContext = session.getServletContext();


        List<DictionaryType> dictionaryTypes = (List<DictionaryType>) servletContext.getAttribute("dictionaryTypes");
        return dictionaryTypes;
    }
}