<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <meta charset="UTF-8">

    <link href="${pageContext.request.contextPath}/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css"
          rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/jquery/bs_pagination/jquery.bs_pagination.min.css" type="text/css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery/bs_pagination/en.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery/bs_typeahead/bootstrap3-typeahead.min.js"></script>

    <script type="text/javascript">

        //默认情况下取消和保存按钮是隐藏的
        var cancelAndSaveBtnDefault = true;

        $(function () {
            $("#remark").focus(function () {
                if (cancelAndSaveBtnDefault) {
                    //设置remarkDiv的高度为130px
                    $("#remarkDiv").css("height", "130px");
                    //显示
                    $("#cancelAndSaveBtn").show("2000");
                    cancelAndSaveBtnDefault = false;
                }
            });

            $("#cancelBtn").click(function () {
                //显示
                $("#cancelAndSaveBtn").hide();
                //设置remarkDiv的高度为130px
                $("#remarkDiv").css("height", "90px");
                cancelAndSaveBtnDefault = true;
            });
            $('#parent').on('mouseover', '.remarkDiv', function () {
                $(this).children("div").children("div").show();
            });
            /*  $(".remarkDiv").mouseover(function () {
                  $(this).children("div").children("div").show();
              });*/
            $('#parent').on('mouseout', '.remarkDiv', function () {
                $(this).children("div").children("div").hide();
            });
            /* $(".remarkDiv").mouseout(function () {
                 $(this).children("div").children("div").hide();
             });*/
            $('#parent').on('mouseover', '.myHref', function () {
                $(this).children("span").css("color", "red");
            });
            /* $(".myHref").mouseover(function () {
                 $(this).children("span").css("color", "red");
             });*/
            $('#parent').on('mouseout', '.myHref', function () {
                $(this).children("span").css("color", "#E6E6E6");
            });
            /*$(".myHref").mouseout(function () {
                $(this).children("span").css("color", "#E6E6E6");
            });*/
        });

    </script>

</head>
<body>
<!-- 删除联系人的模态窗口 -->
<div class="modal fade" id="removeContactsModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 30%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">删除联系人</h4>
                <input type="hidden" id="contactsId"/>
            </div>
            <div class="modal-body">
                <p>您确定要删除该联系人吗？</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger" onclick="deleteContactsbtn($('#contactsId').val())">删除
                </button>
            </div>
        </div>
    </div>
</div>

<!-- 删除交易的模态窗口 -->
<div class="modal fade" id="removeTransactionModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 30%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">删除交易</h4>
            </div>
            <div class="modal-body">
                <p>您确定要删除该交易吗？</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger" onclick="deleteTranBtn()" id="deleteTranBtn">删除</button>
            </div>
        </div>
    </div>
</div>

<!-- 创建联系人的模态窗口 -->
<div class="modal fade" id="createContactsModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" onclick="$('#createContactsModal').modal('hide');">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabelx">创建联系人</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="createContactsForm" role="form">
                    <div class="form-group">
                        <label for="create-contactsOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" name="owner" id="create-contactsOwner">

                            </select>
                        </div>
                        <label for="create-clueSource" class="col-sm-2 control-label">来源</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" name="source" id="create-clueSource">
                                <option></option>
                                <c:forEach items="${dictionaryTypes}" var="dictionaryType">
                                    <c:if test="${dictionaryType.code =='source'}">
                                        <c:forEach items="${dictionaryType.dictionaryValues}" var="dictionaryValue">
                                            <option value="${dictionaryValue.value}">${dictionaryValue.text}</option>
                                        </c:forEach>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-surname" class="col-sm-2 control-label">姓名<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" name="fullname" id="create-surname"/>
                        </div>
                        <label for="create-call" class="col-sm-2 control-label">称呼</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" name="appellation" id="create-call">
                                <option></option>
                                <c:forEach items="${dictionaryTypes}" var="dictionaryType">
                                    <c:if test="${dictionaryType.code =='appellation'}">
                                        <c:forEach items="${dictionaryType.dictionaryValues}" var="dictionaryValue">
                                            <option value="${dictionaryValue.value}">${dictionaryValue.text}</option>
                                        </c:forEach>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </div>

                    </div>

                    <div class="form-group">
                        <label for="create-job" class="col-sm-2 control-label">职位</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" name="job" id="create-job">
                        </div>
                        <label for="create-mphone" class="col-sm-2 control-label">手机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" name="mphone" id="create-mphone">
                        </div>
                    </div>

                    <div class="form-group" style="position: relative;">
                        <label for="create-email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" name="email" id="create-email">
                        </div>
                        <label for="create-birth" class="col-sm-2 control-label">生日</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" name="birth" readonly class="form-control" id="create-birth">
                        </div>
                    </div>

                    <div class="form-group" style="position: relative;">
                        <label for="create-customerName" class="col-sm-2 control-label">客户名称</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-customerName"
                                   placeholder="支持自动补全，输入客户不存在则新建"/>
                            <input type="hidden" id="customerNameId"/>
                        </div>
                    </div>

                    <div class="form-group" style="position: relative;">
                        <label for="create-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" name="description" id="create-describe"></textarea>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                    <div style="position: relative;top: 15px;">
                        <div class="form-group">
                            <label for="create-contactSummary1" class="col-sm-2 control-label">联系纪要</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" name="contactSummary"
                                          id="create-contactSummary1"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="create-nextContactTime1" class="col-sm-2 control-label">下次联系时间</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" name="nextContactTime" readonly class="form-control"
                                       id="create-nextContactTime1">
                            </div>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                    <div style="position: relative;top: 20px;">
                        <div class="form-group">
                            <label for="edit-address1" class="col-sm-2 control-label">详细地址</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" name="address" rows="1" id="edit-address1"></textarea>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="addContacts()">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改客户的模态窗口 -->
<div class="modal fade" id="editCustomerModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">修改客户</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="updateCustomerForm" role="form">
                    <input type="hidden" name="id" id="customerId"/>
                    <div class="form-group">
                        <label for="edit-customerOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" name="owner" id="edit-customerOwner">
                            </select>
                        </div>
                        <label for="edit-customerName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" name="fullname" class="form-control" id="edit-customerName"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-website" class="col-sm-2 control-label">公司网站</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" name="website" class="form-control" id="edit-website"/>
                        </div>
                        <label for="edit-phone" class="col-sm-2 control-label">公司座机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" name="phone" class="form-control" id="edit-phone">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" name="description" rows="3" id="edit-describe"></textarea>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                    <div style="position: relative;top: 15px;">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">联系纪要</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" name="contactSummary" rows="3"
                                          id="createcontactSummary1"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="create-nextContactTime2" class="col-sm-2 control-label">下次联系时间</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" name="nextContactTime" readonly
                                       id="create-nextContactTime2"/>
                            </div>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                    <div style="position: relative;top: 20px;">
                        <div class="form-group">
                            <label for="edit-address" class="col-sm-2 control-label">详细地址</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" name="address" rows="1" id="edit-address"></textarea>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" onclick="updateCustomerBtn()" class="btn btn-primary">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 返回按钮 -->
<div style="position: relative; top: 35px; left: 10px;">
    <a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left"
                                                                         style="font-size: 20px; color: #DDDDDD"></span></a>
</div>

<!-- 大标题 -->
<div style="position: relative; left: 40px; top: -30px;">
    <div class="page-header">
        <h3>${customer.name}
            <small><a href="http://${customer.website}" target="_blank">${customer.website}</a></small>
        </h3>
    </div>
    <div style="position: relative; height: 50px; width: 500px;  top: -72px; left: 700px;">
        <button type="button" class="btn btn-default" onclick="updateCustomer()"><span
                class="glyphicon glyphicon-edit"></span> 编辑
        </button>
        <button type="button" onclick="deleteCustomer()" class="btn btn-danger"><span
                class="glyphicon glyphicon-minus"></span> 删除
        </button>
    </div>
</div>

<!-- 详细信息 -->
<div style="position: relative; top: -70px;">
    <div style="position: relative; left: 40px; height: 30px;">
        <div style="width: 300px; color: gray;">所有者</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${customer.owner}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">名称</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${customer.name}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 10px;">
        <div style="width: 300px; color: gray;">公司网站</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${customer.website}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">公司座机</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${customer.phone}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 20px;">
        <div style="width: 300px; color: gray;">创建者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${customer.createBy}&nbsp;&nbsp;</b>
            <small style="font-size: 10px; color: gray;">${customer.createTime}</small>
        </div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 30px;">
        <div style="width: 300px; color: gray;">修改者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${customer.editBy}&nbsp;&nbsp;</b>
            <small style="font-size: 10px; color: gray;">${customer.editTime}</small>
        </div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 40px;">
        <div style="width: 300px; color: gray;">联系纪要</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${customer.contactSummary}
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 50px;">
        <div style="width: 300px; color: gray;">下次联系时间</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${customer.nextContactTime}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px; "></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 60px;">
        <div style="width: 300px; color: gray;">描述</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${customer.description}
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 70px;">
        <div style="width: 300px; color: gray;">详细地址</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${customer.address}
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
</div>

<!-- 备注 -->
<div id="parent" style="position: relative; top: 10px; left: 40px;">
    <div class="page-header">
        <h4>备注</h4>
    </div>

    <!-- 备注 -->
    <c:forEach items="${customer.customerRemarks}" var="customerRemark">
        <div class="remarkDiv" id="div${customerRemark.id}" style="height: 60px;">
            <img title="${customer.owner}" src="${pageContext.request.contextPath}/image/user-thumbnail.png" style="width: 30px; height:30px;">
            <div style="position: relative; top: -40px; left: 40px;">
                <h5 id="noteContent${customerRemark.id}">${customerRemark.noteContent}</h5>
                <font color="gray">创建人</font>${customerRemark.createBy} <font color="gray">-</font> <b></b>
                <small style="color: gray;"> ${customer.createTime} 由${customer.owner}</small>
                <div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
                    <a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit"
                                                                       onclick="updateCustomerRemark('${customerRemark.id}',$('#noteContent${customerRemark.id}').html())"
                                                                       style="font-size: 20px; color: #E6E6E6;"></span></a>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove"
                                                                       onclick="deleteCustomerRemark('${customerRemark.id}')"
                                                                       style="font-size: 20px; color: #E6E6E6;"></span></a>
                </div>
            </div>
        </div>
    </c:forEach>


    <div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
        <form role="form" style="position: relative;top: 10px; left: 10px;">
            <textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"
                      placeholder="添加备注..."></textarea>
            <p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
                <button id="cancelBtn" type="button" class="btn btn-default">取消</button>
                <button type="button" class="btn btn-primary" onclick="addCustomerRemark($('#remark').val())">保存
                </button>
            </p>
        </form>
    </div>
</div>

<!-- 交易 -->
<div>
    <div style="position: relative; top: 20px; left: 40px;">
        <div class="page-header">
            <h4>交易</h4>
        </div>
        <div style="position: relative;top: 0px;">
            <table id="activityTable2" class="table table-hover" style="width: 900px;">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td>名称</td>
                    <td>金额</td>
                    <td>阶段</td>
                    <td>可能性</td>
                    <td>预计成交日期</td>
                    <td>类型</td>
                    <td></td>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${customer.trans}" var="tran">
                    <tr id="tr${tran.id}">
                        <td><a href="../transaction/detail.html" style="text-decoration: none;">${tran.name}</a></td>
                        <td>${tran.money}</td>
                        <td>${tran.stage}</td>
                        <td></td>
                        <td>${tran.expectedDate}</td>
                        <td>${tran.type}</td>
                        <td><a href="javascript:void(0);" onclick="deleteTran('${tran.id}')"
                               style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>删除</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <div>
            <a href="${pageContext.request.contextPath}/toView/transaction/save" style="text-decoration: none;"><span
                    class="glyphicon glyphicon-plus"></span>新建交易</a>
        </div>
    </div>
</div>

<!-- 联系人 -->
<div>
    <div style="position: relative; top: 20px; left: 40px;">
        <div class="page-header">
            <h4>联系人</h4>
        </div>
        <div id="father" style="position: relative;top: 0px;">
            <table id="activityTable" class="table table-hover" style="width: 900px;">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td>名称</td>
                    <td>邮箱</td>
                    <td>手机</td>
                    <td></td>
                </tr>
                </thead>
                <tbody id="contacts">
                <c:forEach items="${customer.contacts}" var="contact">
                    <tr id="tr${contact.id}">
                        <td><a href="../contacts/detail.html" style="text-decoration: none;">${contact.fullname}</a>
                        </td>
                        <td>${contact.email}</td>
                        <td>${contact.mphone}</td>
                        <td><a href="javascript:void(0);" onclick="deleteContact('${contact.id}')"
                               style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>删除</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <div>
            <a href="javascript:void(0);" onclick="insertContacts()"
               style="text-decoration: none;"><span class="glyphicon glyphicon-plus"></span>新建联系人</a>
        </div>
    </div>
</div>

<div style="height: 200px;"></div>
<!-- 修改客户备注的模态窗口 -->
<div class="modal fade" id="editRemarkModal" role="dialog">
    <%-- 备注的id --%>
    <input type="hidden" id="remarkId">
    <div class="modal-dialog" role="document" style="width: 40%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">修改备注</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">内容</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="noteContent"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary"
                        onclick="updateRemarkBtn($('#remarkId').val(),$('#noteContent').val())">更新
                </button>
            </div>
        </div>
    </div>
</div>

</body>
</html>
<script>
    //修改备注
    function updateCustomerRemark(id, noteContent) {
        //将数据插入模态窗中对应的位置
        //remarkId noteContent editRemarkModal updateRemarkBtn
        $('#remarkId').val(id);
        $('#noteContent').val(noteContent);
        $('#editRemarkModal').modal('show');
    }

    //点击备注的更新按钮触发事件
    function updateRemarkBtn(id, noteContext) {
        $.ajax({
            url: '${pageContext.request.contextPath}/workbench/updateCustomerRemark',
            data: {
                'id': id,
                'noteContent': noteContext
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                alert(data.message);
                if (data.success) {
                    //修改成功,关闭模态窗，修改相关信息
                    $('#editRemarkModal').modal('hide');
                    $('#' + 'noteContent' + ($('#remarkId').val())).html($('#noteContent').val());
                }
            }
        });
    };

    //删除备注
    function deleteCustomerRemark(id) {
        $.ajax({
            url: '${pageContext.request.contextPath}/workbench/deleteCustomerRemark',
            data: {
                'id': id
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                alert(data.message);
                if (data.success) {
                    //删除对应的备注
                    $('#div' + id).remove();
                }
            }
        });
    };

    //添加备注
    function addCustomerRemark(noteContext) {
        $.ajax({
            url: '${pageContext.request.contextPath}/workbench/addCustomerRemark',
            data: {
                'customerId': '${customer.id}',
                'noteContent': noteContext
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                //若返回成功,则进行页面添加备注
                $('#remarkDiv').before(" <div class='remarkDiv' id='div" + data.id + "' style=\"height: 60px;\">\n" +
                    " <img title=\"${customer.owner}\" src=\"${pageContext.request.contextPath}/image/user-thumbnail.png\" style=\"width: 30px; height:30px;\">\n" +
                    " <div style=\"position: relative; top: -40px; left: 40px;\">\n" +
                    " <h5 id='noteContent" + data.id + "'>" + data.noteContent + "</h5>\n" +
                    " <font color=\"gray\">联系人</font> <font color=\"gray\">-</font> <b></b>\n" +
                    " <small style=\"color: gray;\"> " + data.createTime + "由${customer.owner}</small>\n" +
                    " <div style=\"position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;\">\n" +
                    " <a class=\"myHref\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-edit\"\n" +
                    " onclick=\"updateCustomerRemark('" + data.id + "',$('#noteContent" + data.id + "').text())\"\n" +
                    " style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
                    " &nbsp;&nbsp;&nbsp;&nbsp;\n" +
                    " <a class=\"myHref\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-remove\"\n" +
                    " onclick=\"deleteCustomerRemark('" + data.id + "')\"\n" +
                    " style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
                    " </div>\n" +
                    " </div>\n" +
                    " </div>")
                //清空添加备注文本框的内容
                $('#remark').val("");
            }
        })
    };
    //editCustomerModal updateCustomer
    //点击修改用户按钮
    function updateCustomer() {
        //异步查询该客户所有信息
        var owner = "";
        $.ajax({
            url: '${pageContext.request.contextPath}/workbench/saveCustomerById',
            data: {'id': '${customer.id}'},
            dataType: 'json',
            type: 'post',
            success: function (data) {
                owner = data.owner;
                $('#customerId').val(data.id);
                $('#edit-customerName').val(data.name);
                $('#edit-website').val(data.website);
                $('#edit-phone').val(data.phone);
                $('#edit-describe').val(data.description);
                $('#createcontactSummary1').val(data.contactSummary);
                $('#create-nextContactTime2').val(data.nextContactTime);
                $('#edit-address').val(data.address);
                //edit-customerOwner
                //异步查询所有者信息
                $.ajax({
                    url: '${pageContext.request.contextPath}/settings/saveAllUser',
                    dataType: 'json',
                    type: 'post',
                    success: function (data2) {
                        $('#edit-customerOwner').empty();
                        //将所有者信息注入对应的下拉列表框中
                        for (var i = 0; i < data2.length; i++) {
                            $('#edit-customerOwner').append("<option value=" + data2[i].id + ">" + data2[i].name + "</option>")
                        }
                        $('#edit-customerOwner option').each(function () {
                            if ($(this).val() == owner) {
                                $(this).prop("selected", true);
                            }
                        })
                    }
                });
            }
        });
        //显示模态窗
        $('#editCustomerModal').modal('show');
    };
    $('#create-nextContactTime2').datetimepicker({
        language: "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn: true,
        pickerPosition: "bottom-left"
    });

    //删除按钮交易
    function deleteTran(id) {
        $('#deleteTranBtn').val(id);
        $('#removeTransactionModal').modal('show');
    }

    //确认删除交易
    function deleteTranBtn() {
        $.ajax({
            url: '${pageContext.request.contextPath}/workbench/tran/deleteTranById',
            data: {
                'id': $('#deleteTranBtn').val()
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                //关闭模态窗
                $('#removeTransactionModal').modal('hide');
                alert(data.message);
                if (data.success) {
                    //删除成功删除对应的界面元素
                    $('#tr' + ($('#deleteTranBtn').val())).remove();
                }
            }
        })
    };

    //删除联系人
    function deleteContact(id) {
        $('#contactsId').val(id);
        $('#removeContactsModal').modal('show');
    }

    //删除联系人按钮
    function deleteContactsbtn(id) {
        $('#removeContactsModal').modal('hide');
        $.ajax({
            url: '${pageContext.request.contextPath}/workbench/contacts/deleteContactsById',
            data: {'id': id},
            dataType: 'json',
            type: 'post',
            success: function (data) {
                alert(data.message);
                if (data.success) {
                    //删除界面dom元素
                    $('#tr' + id).remove();
                }
            }
        });
    };

    //点击新建联系人按钮
    function insertContacts() {
        $('#create-contactsOwner').empty();
        //异步查询所有者信息
        $.ajax({
            url: '${pageContext.request.contextPath}/workbench/saveOwner',
            type: 'post',
            dataType: 'json',
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    $('#create-contactsOwner').append("<option value=" + data[i].id + " >" + data[i].name + "</option>")
                }
                /* //循环异步的所有者，当等于owner时将当前的option的seleted属性挑选出来
                 $('#edit-marketActivityOwner option').each(function () {
                     if (owner == $(this).val()) {
                         $(this).prop("selected", true);
                     }
                 })*/
                //显示模态窗
                $('#createContactsModal').modal('show');
            }
        });
    };
    //新建联系人     自动补全功能
    $('#create-customerName').typeahead({
        source: function (customerName, process) {
            $.post(
                "${pageContext.request.contextPath}/workbench/customer/queryCustomerName",
                {"customerName": customerName},
                function (data) {
                    //alert(data);
                    process(data);
                },
                "json"
            );
        },
        //输入内容后延迟多长时间弹出提示内容
        delay: 1000
    });
    //当客户名称input失去焦点时异步查询
    $('#create-customerName').blur(function () {
        $.ajax({
            url: '${pageContext.request.contextPath}/workbench/customer/saveCustomerName',
            data: {
                'company': $(this).val()
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                $('#create-customerName').next().val(data.message);

            }
        });
    });
    //创建联系人生日选框
    $('#create-birth').datetimepicker({
        language: "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn: true,
        pickerPosition: "bottom-left"
    });
    $('#create-nextContactTime1').datetimepicker({
        language: "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn: true,
        pickerPosition: "bottom-left"
    });

    //点击保存联系人按钮
    function addContacts() {
        //姓名不能为空
        if ($('#create-surname').val() == undefined && $('#create-surname').val() == "") {
            alert("姓名不能为空");
            return;
        } else {
            //表单序列化
            var serialize = $('#createContactsForm').serialize();
            //异步提交表单
            $.ajax({
                url: '${pageContext.request.contextPath}/workbench/contacts/addContacts?' + serialize,
                data: {
                    'company': $('#create-customerName').val(),
                    'customerId': $('#create-customerName').next().val()
                },
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    alert(data.message);
                    if (data.success) {
                        $('#createContactsModal').modal('hide');
                        //刷新界面
                        location.href = "${pageContext.request.contextPath}/workbench/saveCustomerRemark?id=${customer.id}"
                    }
                }
            });
        }
    };

    //修改客户信息
    function updateCustomerBtn() {
        //表单序列化
        var serialize = $('#updateCustomerForm').serialize();
        $.ajax({
            url: '${pageContext.request.contextPath}/workbench/updateCustomerById?' + serialize,
            dataType: 'json',
            type: 'post',
            success: function (data) {
                alert(data.message);
                if (data.success) {
                    //更新成功,关闭窗口
                    $('#editCustomerModal').modal('hide');
                    //刷新界面
                    location.href = "${pageContext.request.contextPath}/workbench/saveCustomerRemark?id=${customer.id}"
                }
            }
        });
    };

    //删除事件
    function deleteCustomer() {
        var flag = confirm("您确定删除该客户么?");
        if (flag) {
            location.href = "${pageContext.request.contextPath}/workbench/delete_customer?id=${customer.id}"
        }
    }
</script>