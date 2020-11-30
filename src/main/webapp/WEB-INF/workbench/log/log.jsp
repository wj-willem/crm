<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">

    <link href="${pageContext.request.contextPath}/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css"
          rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css"
          type="text/css" rel="stylesheet"/>

    <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
    <%--导入layer弹窗--%>
    <script type="text/javascript" charset="utf-8"
            src="${pageContext.request.contextPath}/jquery/layer-v3.1.1/layer/layer.js"></script>
    <%--导入分页插件--%>
    <link href="${pageContext.request.contextPath}/jquery/bs_pagination/jquery.bs_pagination.min.css" type="text/css"
          rel="stylesheet"/>
    <script type="application/javascript"
            src="${pageContext.request.contextPath}/jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
    <script type="application/javascript" src="${pageContext.request.contextPath}/jquery/bs_pagination/en.js"></script>

</head>
<body>


<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>系统日志列表</h3>
        </div>
    </div>
</div>
<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

        <div class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">操作</div>
                        <input class="form-control" id="operationName" type="text" placeholder="请输入相应操作">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">开始日期</div>
                        <input class="form-control" type="text" id="startTime"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">结束日期</div>
                        <input class="form-control" type="text" id="endTime">
                    </div>
                </div>


                <button type="button" class="btn btn-default" onclick="queryLogs()">查询</button>

            </form>
        </div>
        <div class="btn-toolbar" role="toolbar"
             style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button id="deleteLog" type="button" class="btn btn-danger"><span
                        class="glyphicon glyphicon-minus"></span> 删除
                </button>
                <a type="button" href="${pageContext.request.contextPath}/workbench/log/logExport" class="btn btn-success">
                    <span class="glyphicon glyphicon-minus"></span>导出Excel
                </a>
            </div>

        </div>
        <div style="position: relative;top: 10px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input type="checkbox" id="father"/></td>
                    <td>操作类型</td>
                    <td>请求类</td>
                    <td>请求路径</td>
                    <td>请求参数</td>
                    <td>IP</td>
                    <td>操作人</td>
                </tr>
                </thead>
                <tbody id="logBoby">
                <%--异步查询动态拼接--%>
                </tbody>
            </table>
        </div>

        <%--分页插件--%>
        <div style="height: 50px; position: relative;top: 30px;">
            <div id="logPage"></div>
        </div>

    </div>

</div>
</body>
<script type="text/javascript">


    //多条件查询函数
    function queryLogs() {

        pageList(1, 5);
    }

    //参数1:当前页码 参数2:每页记录数

    pageList(1, 5);

    function pageList(page, pageSize) {

        $.ajax({
            url: '${pageContext.request.contextPath}/workbench/log/queryAllLogs',
            data: {
                'page': page,
                'pageSize': pageSize,
                'operationName': $('#operationName').val(),
                'startTime': $('#startTime').val(),
                'endTime': $('#endTime').val(),
            },
            type: 'get',
            dataType: 'json',
            success: function (data) {
                console.log(data);
                //清空上一次拼接的数据
                $('#logBoby').html("");
                //后台传递的每页的总数居
                var dataList = data.dataList;
                for (var i = 0; i < dataList.length; i++) {
                    //list:每次遍历的数据
                    var list = dataList[i];
                    $('#logBoby').append(
                        "<tr class=\"active\">\n" +
                        "<td><input type=\"checkbox\" class=\"son\" value=\"" + list.id + "\"/></td>\n" +
                        "<td>" + list.operationName + "</td>\n" +
                        "<td>" + list.operationClass + "</td>\n" +
                        "<td>" + list.operationAddress + "</td>\n" +
                        "<td>" + list.params + "</td>\n" +
                        "<td>" + list.ip + "</td>\n" +
                        "<td>" + list.loginName + "</td>\n" +
                        "</tr> ");
                }

                //利用分页插件查询第一页数据
                $("#logPage").bs_pagination({
                    currentPage: data.page, // 页码
                    rowsPerPage: data.pageSize, // 每页显示的记录条数
                    maxRowsPerPage: 20, // 每页最多显示的记录条数
                    totalPages: data.pages, // 总页数
                    totalRows: data.total, // 总记录条数
                    visiblePageLinks: 3, // 显示几个卡片
                    showGoToPage: true,
                    showRowsPerPage: true,
                    showRowsInfo: true,
                    showRowsDefaultInfo: true,
                    //回调函数，用户每次点击分页插件进行翻页的时候就会触发该函数
                    onChangePage: function (event, obj) {
                        //刷新页面，obj.currentPage:当前点击的页码
                        pageList(obj.currentPage, obj.rowsPerPage);
                    }
                });
            }
        });
    }

    //批量删除日志
    $('#deleteLog').click(function () {
        var $chek = $(".son:checked");
        if ($chek.length == 0) {
            layer.alert("请选择需要删除的记录", {icon: 6});
            return;
        } else {
            //获取勾中的记录
            var logids = [];
            $('.son').each(function () {
                if ($(this).prop('checked')) {
                    logids.push($(this).val());
                }
            });
            $.ajax({
                url: '${pageContext.request.contextPath}/workbench/log/deleteLogs',
                data: {
                    'ids': logids.join()
                },
                type: 'post',
                dataType: 'json',
                success: function (data) {
                    if (data.success) {
                        layer.alert(data.message, {icon: 6});
                        pageList(1, 5);
                    }
                }
            });
        }
    });


    //条件查询日历插件
    $("#startTime").datetimepicker({
        language: "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "hour",//设置只显示到小时
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn: true,
        pickerPosition: "bottom-left"
    });

    $("#endTime").datetimepicker({
        language: "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "hour",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn: true,
        pickerPosition: "bottom-left"
    });


    //全选、反选
    $('#father').click(function () {
        var father = $(this); //father
        $('.son').each(function () {
            //$(this):son
            $(this).prop('checked', father.prop('checked'));
        });
    });

    //根据son决定father是否勾中
    $('.son').each(function () {
        $(this).click(function () {
            //获取勾中的son
            var selectedSon = $('.son:checked');
            if (selectedSon.length == $('.son').length) {
                $('#father').prop('checked', true);
            } else {
                $('#father').prop('checked', false);
            }
        });
    });

</script>
</html>
