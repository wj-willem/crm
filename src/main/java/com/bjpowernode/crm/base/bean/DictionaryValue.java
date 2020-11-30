package com.bjpowernode.crm.base.bean;

import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;

import javax.persistence.Id;
import javax.persistence.Table;


/**
 * @author wj_willem
 * @version 1.0
 * @Description 数据字典value类
 * @since 2020-11-17 16:42
 */
@Table(name = "tbl_dic_value")
@NameStyle(Style.normal)
public class DictionaryValue {

    @Id
    private String id;
    private String value;
    private String text;
    private String orderNo;
    private String typeCode;


    public String getId() {
        return id;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public String getTypeCode() {
        return typeCode;
    }

    public void setTypeCode(String typeCode) {
        this.typeCode = typeCode;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "DictionaryValue{" +
                "id='" + id + '\'' +
                ", value='" + value + '\'' +
                ", text='" + text + '\'' +
                ", orderNo='" + orderNo + '\'' +
                ", typeCode='" + typeCode + '\'' +
                '}';
    }

}