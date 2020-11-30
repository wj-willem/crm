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

    <script type="text/javascript">

        $(function () {

            //定制字段
            $("#definedColumns > li").click(function (e) {
                //防止下拉菜单消失
                e.stopPropagation();
            });

        });

    </script>
</head>
<body>

<!-- 创建客户的模态窗口 -->
<div class="modal fade" id="createCustomerModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel1">创建客户</h4>
            </div>
            <div class="modal-body">
                <form id="createCustomerForm" class="form-horizontal" role="form">

                    <div class="form-group">
                        <label for="create-customerOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-customerOwner">
                            </select>
                        </div>
                        <label for="create-customerName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-customerName">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-website" class="col-sm-2 control-label">公司网站</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-website">
                        </div>
                        <label for="create-phone" class="col-sm-2 control-label">公司座机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-phone">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="create-describe"></textarea>
                        </div>
                    </div>
                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                    <div style="position: relative;top: 15px;">
                        <div class="form-group">
                            <label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" id="create-contactSummary"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" readonly class="form-control" id="create-nextContactTime"/>
                            </div>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                    <div style="position: relative;top: 20px;">
                        <div class="form-group">
                            <label for="create-address1" class="col-sm-2 control-label">详细地址</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="1" id="create-address1"></textarea>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
            <span style="color: darkred" id="create-customerError"></span>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="create_customer">保存</button>
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
                <form class="form-horizontal" role="form">
                    <input type="hidden" id="customerId"/>
                    <div class="form-group">
                        <label for="edit-customerOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-customerOwner">
                            </select>
                        </div>
                        <label for="edit-customerName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-customerName"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-website" class="col-sm-2 control-label">公司网站</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-website"/>
                        </div>
                        <label for="edit-phone" class="col-sm-2 control-label">公司座机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-phone"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="edit-describe"></textarea>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                    <div style="position: relative;top: 15px;">
                        <div class="form-group">
                            <label for="create-contactSummary1" class="col-sm-2 control-label">联系纪要</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" id="create-contactSummary1"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="create-nextContactTime2" class="col-sm-2 control-label">下次联系时间</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" readonly id="create-nextContactTime2"/>
                            </div>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                    <div style="position: relative;top: 20px;">
                        <div class="form-group">
                            <label for="create-address" class="col-sm-2 control-label">详细地址</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="1" id="create-address"></textarea>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="update_customer">更新</button>
            </div>
        </div>
    </div>
</div>


<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>客户列表</h3>
        </div>
    </div>
</div>

<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">

    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

        <div class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">名称</div>
                        <input class="form-control" id="saveName" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">所有者</div>
                        <input class="form-control" id="uname" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">公司座机</div>
                        <input class="form-control" id="savePhone" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">公司网站</div>
                        <input class="form-control" id="saveWebsite" type="text">
                    </div>
                </div>

                <button type="button" onclick="queryCustomer(1,2)" class="btn btn-default">查询</button>

            </form>
        </div>
        <div class="btn-toolbar" role="toolbar"
             style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" class="btn btn-primary" id="create-Customer">
                    <span class="glyphicon glyphicon-plus"></span> 创建
                </button>
                <button type="button" class="btn btn-default" id="update-customer"><span
                        class="glyphicon glyphicon-pencil"></span> 修改
                </button>
                <button type="button" id="delete-customer" class="btn btn-danger"><span
                        class="glyphicon glyphicon-minus"></span> 删除
                </button>
            </div>

        </div>
        <div style="position: relative;top: 10px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input id="parent" type="checkbox"/></td>
                    <td>名称</td>
                    <td>所有者</td>
                    <td>公司座机</td>
                    <td>公司网站</td>
                </tr>
                </thead>
                <tbody id="queryAllCustomer">

                </tbody>
            </table>
        </div>

        <div style="height: 50px; position: relative;top: 30px;" id="customerPage">

        </div>

    </div>

</div>
</body>
</html>

<script>

    //设置模态窗的时间
    $('#create-nextContactTime').datetimepicker({
        language: "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn: true,
        pickerPosition: "bottom-left"
    });

    queryCustomer(1, 2);

    //查询所有客户信息加分页，加多条件复杂查询
    function queryCustomer(page, pageSize) {
        $.ajax({
            url: '${pageContext.request.contextPath}/workbench/customer/saveAllCustomer',
            data: {
                'page': page,
                'pageSize': pageSize,
                'name': $('#saveName').val(),
                'owner': $('#uname').val(),
                'phone': $('#savePhone').val(),
                'website': $('#saveWebsite').val(),
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                //清空上次数据
                $('#queryAllCustomer').html("");
                for (var i = 0; i < data.dataList.length; i++) {
                    //将所有数据动态拼接出来
                    $('#queryAllCustomer').append("<tr class=\"active\">\n" +
                        "<td><input type=\"checkbox\" class=\"son\" value= '" + data.dataList[i].id + "'/></td>\n" +
                        "<td><a style=\"text-decoration: none; cursor: pointer;\"\n" +
                        "href=${pageContext.request.contextPath}/workbench/saveCustomerRemark?id=" + data.dataList[i].id + ">" + data.dataList[i].name + "</a></td>\n" +
                        "<td>" + data.dataList[i].uname + "</td>\n" +
                        "<td>" + data.dataList[i].phone + "</td>\n" +
                        "<td>" + data.dataList[i].website + "</td>\n" +
                        "</tr>"
                    )
                }
                /*采用bootstrap分页插件*/
                $("#customerPage").bs_pagination({
                    currentPage: data.page, // 页码
                    rowsPerPage: data.pageSize, // 每页显示的记录条数
                    maxRowsPerPage: 20, // 每页最多显示的记录条数
                    totalPages: data.Pages, // 总页数
                    totalRows: data.total, // 总记录条数
                    visiblePageLinks: 3, // 显示几个卡片
                    showGoToPage: true,
                    showRowsPerPage: true,
                    showRowsInfo: true,
                    showRowsDefaultInfo: true,
                    onChangePage: function (event, obj) {
                        queryCustomer(obj.currentPage, obj.rowsPerPage);
                    }
                });
            }
        })
    };

    //异步查询所有者
    //点击创建按钮异步查询
    $('#create-Customer').click(function () {
        //清空上次查询的所有者信息
        $('#create-customerOwner').empty();
        //调用查询所有者的方法
        $.ajax({
            url: '${pageContext.request.contextPath}/workbench/activity/queryAllUsers',
            dataType: 'json',
            type: 'post',
            success: function (data) {
                //将所有者信息注入对应的下拉列表框中
                for (var i = 0; i < data.length; i++) {
                    $('#create-customerOwner').append("<option value=" + data[i].id + ">" + data[i].name + "</option>")
                }
            }
        });
        //显示模态窗
        $('#createCustomerModal').modal("show");
    });

    //点击创建客户的保存按钮触发事件
    $('#create_customer').click(function () {
        //名称不能为空
        if ($('#create-customerName').val() == '') {
            $('#create-customerError').html("名称不能为空")
        } else {
            $.ajax({
                url: '${pageContext.request.contextPath}/workbench/create_customer',
                data: {
                    'owner': $('#create-customerOwner').val(),
                    'name': $('#create-customerName').val(),
                    'website': $('#create-website').val(),
                    'phone': $('#create-phone').val(),
                    'description': $('#create-describe').val(),
                    'contactSummary': $('#create-contactSummary').val(),
                    'nextContactTime': $('#create-nextContactTime').val(),
                    'address': $('#create-address1').val(),
                },
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    alert(data.message);
                    if (data.success) {
                        //添加成功,关闭模态窗，刷新界面
                        $('#createCustomerModal').modal("hide");
                        //将模态窗中的所有信息进行重置,reset方法只有js有，需要将jquery转成js，通过[0]或者get(0)
                        $('#createCustomerForm').get(0).reset();
                        queryCustomer(1, 2);
                    }
                }
            });
        }
    });

    //点击修改按钮触发事件
    $('#update-customer').click(function () {
        //判断客户选择修改那个客户信息
        if ($('.son:checked').length == 0) {
            alert("请选择您要修改的客户信息");
        } else if ($('.son:checked').length > 1) {
            alert("每次最多修改一位客户的信息")
        } else {
            var id = $('.son:checked').val();
            var owner = "";
            //异步查询该客户所有信息
            $.ajax({
                url: '${pageContext.request.contextPath}/workbench/saveCustomerById',
                data: {'id': id},
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    owner = data.owner;
                    $('#customerId').val(data.id);
                    $('#edit-customerName').val(data.name);
                    $('#edit-website').val(data.website);
                    $('#edit-phone').val(data.phone);
                    $('#edit-describe').val(data.description);
                    $('#create-contactSummary1').val(data.contactSummary);
                    $('#create-nextContactTime2').val(data.nextContactTime);
                    $('#create-address').val(data.address);
                    //edit-customerOwner
                    //异步查询所有者信息
                    $.ajax({
                        url: '${pageContext.request.contextPath}/workbench/activity/queryAllUsers',
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
        }
    });

    //点击更新按钮
    $('#update_customer').click(function () {
        $.ajax({
            url: '${pageContext.request.contextPath}/workbench/updateCustomerById',
            data: {
                'id': $('#customerId').val(),
                'owner': $('#edit-customerOwner').val(),
                'name': $('#edit-customerName').val(),
                'website': $('#edit-website').val(),
                'phone': $('#edit-phone').val(),
                'description': $('#edit-describe').val(),
                'contactSummary': $('#create-contactSummary1').val(),
                'nextContactTime': $('#create-nextContactTime2').val(),
                'address': $('#create-address').val()
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                alert(data.message);
                if (data.success) {
                    //更新成功,关闭窗口，刷新界面
                    $('#editCustomerModal').modal('hide');
                    queryCustomer(1, 2);
                }
            }
        });
    });
    //删除按钮点击触发事件
    $('#delete-customer').click(function () {
        //判断用户选择删除那个客户信息
        if ($('.son:checked').length == 0) {
            alert("请选择您要删除的客户信息");
        } else if ($('.son:checked').length > 1) {
            alert("每次最多删除一位客户的信息")
        } else {
            var b = confirm("您确定删除这位客户的信息么？");
            if (b) {
                location.href = "${pageContext.request.contextPath}/workbench/delete_customer?id=" + $('.son:checked').val();
            }
        }
    });
    //全选按钮
    $('#parent').click(function () {
        var sons = $('.son');
        //先判断当前按钮是否勾中
        for (var i = 0; i < sons.length; i++) {
            //将selectAll是否勾中的状态赋值给son
            sons[i].checked = this.checked;
        }
    });

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
</script>