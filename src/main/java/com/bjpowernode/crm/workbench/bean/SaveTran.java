package com.bjpowernode.crm.workbench.bean;

import org.springframework.stereotype.Component;


@Component
public class SaveTran {
    private String contactsId;
    private String source;
    private String type;
    private String stage;
    private String customerId;
    private String name;
    private String owner;

    @Override
    public String toString() {
        return "SaveTran{" +
                "contactsId='" + contactsId + '\'' +
                ", source='" + source + '\'' +
                ", type='" + type + '\'' +
                ", stage='" + stage + '\'' +
                ", customerId='" + customerId + '\'' +
                ", name='" + name + '\'' +
                ", owner='" + owner + '\'' +
                '}';
    }

    public String getContactsId() {
        return contactsId;
    }

    public void setContactsId(String contactsId) {
        this.contactsId = contactsId;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getStage() {
        return stage;
    }

    public void setStage(String stage) {
        this.stage = stage;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }
}
