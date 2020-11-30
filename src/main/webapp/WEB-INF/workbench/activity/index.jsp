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

    <script type="text/javascript">

        $(function () {


        });

    </script>
</head>
<body>

<!-- 创建市场活动的模态窗口 -->
<div class="modal fade" id="createActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
            </div>
            <div class="modal-body">

                <form id="createActivityForm" class="form-horizontal" action="${pageContext.request.contextPath}/workbench/activity/saveActivity" method="post" role="form">

                    <div class="form-group">
                        <label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-marketActivityOwner" name ="owner">
                                <%--点击新建异步请求所有用户数据，动态拼接--%>
                            </select>
                        </div>
                        <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-marketActivityName" name="name">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-startTime" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-startTime" name="startDate">
                        </div>
                        <label for="create-endTime" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-endTime" name="endDate">
                        </div>
                    </div>
                    <div class="form-group">

                        <label for="create-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-cost" name="cost">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="create-describe" name="description"></textarea>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="saveActivityBtn">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改市场活动的模态窗口 -->
<div class="modal fade" id="editActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" role="form">
                    <%--隐藏域用于存放要修改的ID值--%>
                    <input type="hidden"  id="edit-id">

                    <div class="form-group">
                        <label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-marketActivityOwner">
                                <%--动态拼接--%>
                            </select>
                        </div>
                        <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-marketActivityName">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-startTime">
                        </div>
                        <label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-endTime">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-cost">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="edit-describe"></textarea>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="updateActivityBtn">更新</button>
            </div>
        </div>
    </div>
</div>


<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>市场活动列表</h3>
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
                        <input class="form-control" id="name" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">所有者</div>
                        <input class="form-control" id="owner" type="text">
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

                <button type="submit" class="btn btn-default" onclick="queryActivity()">查询</button>

            </form>
        </div>
        <div class="btn-toolbar" role="toolbar"
             style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button id="createActivity" type="button" class="btn btn-primary" data-toggle="modal" data-target="#createActivityModal">
                    <span class="glyphicon glyphicon-plus"></span> 创建
                </button>
                <button id="editActivity" type="button" class="btn btn-default" data-toggle="modal" ><span
                        class="glyphicon glyphicon-pencil"></span> 修改
                </button>
                <button id = "deleteActivity" type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
            </div>

        </div>
        <div style="position: relative;top: 10px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input type="checkbox" id = "father"/></td>
                    <td>名称</td>
                    <td>所有者</td>
                    <td>开始日期</td>
                    <td>结束日期</td>
                </tr>
                </thead>
                <tbody id="activityBody">
                    <%--异步查询动态拼接--%>
                </tbody>
            </table>
        </div>

        <%--分页插件--%>
        <div style="height: 50px; position: relative;top: 30px;">
            <div id="activityPage"></div>
        </div>

    </div>

</div>
</body>
</html>
<script type="application/javascript">

    //删除市场活动
    $('#deleteActivity').bind('click',function () {
        //获取勾中的记录，获取主键
        $.ajax({
            url : '${pageContext.request.contextPath}/workbench/activity/deleteActivity',
            data : {
                'id' : $('.son:checked').val()
            },
            type : 'get',
            dataType : 'json',
            success : function(data){
                refresh(data);
            }
        });
    });

    //增删改之后弹出消息、刷新页面
    function refresh(data) {
        layer.alert(data.message, {icon: 6});
        //刷新页面
        pageList(1,3);
    }






    /*打开修改市场活动模态窗查询所有用户*/
    $('#editActivity').click(function (){

        var $chek = $(".son:checked");
        if ($chek.length==0){
            layer.alert("请选择需要修改的记录", {icon: 6});
            return;
        }else if ($chek.length>1){
            layer.alert("只能修改一条记录哦", {icon: 6});
            return;
        }else {
            //手动显示模态窗
            $('#editActivityModal').modal('show');

            $.ajax({
                url : '${pageContext.request.contextPath}/workbench/activity/queryAllUsers',
                type: 'get',
                dataType: 'json',
                success :function (data){
                    for(var i = 0 ; i < data.length;i++){
                        $('#edit-marketActivityOwner')
                            .append("<option value="+data[i].id+">"+data[i].name+"</option>");
                    }
                }
            });


            //向后台传递主键，查询该条市场活动信息
            $.ajax({

                url : "${pageContext.request.contextPath}/workbench/activity/queryActivityById",
                data :{
                    'id' : $chek.val()
                },
                type : "get",
                dataType : "json",
                success : function (data) {
                    // alert(data.id);
                    $('#edit-id').val(data.id);
                    //让修改模态窗的所有者要和查询出来的市场活动所有者相同
                    //市场活动的owner
                    var owner = data.owner;

                    $('#edit-marketActivityOwner option').each(function (){
                       if ($(this).val()===owner){
                           //选中
                           $(this).prop('selected', true);
                       }
                    });
                    $('#edit-marketActivityName').val(data.name);
                    $('#edit-startTime').val(data.startDate);
                    $('#edit-endTime').val(data.endDate);
                    $('#edit-cost').val(data.cost);
                    $('#edit-describe').val(data.description);
                }
            })
        }
    });


    //点击修改模态窗口更新按钮，提交表单
    $('#updateActivityBtn').click(function (){
        $.ajax({
            url : '${pageContext.request.contextPath}/workbench/activity/updateActivity',
            data : {
                'id' : $('#edit-id').val(),
                'owner' : $('#edit-marketActivityOwner').val(),
                'name' : $('#edit-marketActivityName').val(),
                'startDate' : $('#edit-startTime').val(),
                'endDate' : $('#edit-endTime').val(),
                'cost' : $('#edit-cost').val(),
                'description' : $('#edit-describe').val(),
            },
            type : 'post',
            dataType : 'json',
            success : function(data){
                layer.alert(data.message, {icon: 6});
                //刷新页面
                pageList(1,3);
                //关闭模态窗口
                $('#editActivityModal').modal('hide');
            }
        });



    });


    //提交新建市场活动表单
    $('#saveActivityBtn').click(function () {

        //异步提交创建市场活动表单
        $.ajax({
            url : '${pageContext.request.contextPath}/workbench/activity/saveActivity',
            data : {
                'owner' : $('#create-marketActivityOwner').val(),
                'name'  : $('#create-marketActivityName').val(),
                'startDate' : $('#create-startTime').val(),
                'endDate'  : $('#create-endTime').val(),
                'cost' :$('#create-cost').val(),
                'description' : $('#create-describe').val()
            },
            type : 'post',
            dataType : 'json',
            success : function(data){
                layer.alert(data.message, {icon: 6})
                /*
                modal函数:弹窗函数 show:显示 hide:隐藏
                 */
                //隐藏模态窗口
                $('#createActivityModal').modal('hide');

                $('#createActivityForm')[0].reset();
                //调用pageList刷新页面
                pageList(1,3);
            }
        });
    });

    /*打开新建市场活动模态窗查询所有用户*/
    $('#createActivity').click(function (){
        $.ajax({
            url : '${pageContext.request.contextPath}/workbench/activity/queryAllUsers',
            type: 'get',
            dataType: 'json',
            success :function (data){
                for(var i = 0 ; i < data.length;i++){
                    $('#create-marketActivityOwner')
                        .append("<option value="+data[i].id+">"+data[i].name+"</option>");
                }
            }
        })
    });

    //参数1:当前页码 参数2:每页记录数
    pageList(1, 3);

    //多条件查询函数
    function queryActivity() {
        pageList(1, 3);
    }

    //跳转到活动列表首页的时候，向后台发送查询所有市场活动信息列表的异步请求
    //刷新页面的方法
    function pageList(page, pageSize) {
        $.ajax({
            url: '${pageContext.request.contextPath}/workbench/activity/queryAllActivity',
            data: {
                'page': page,
                'pageSize': pageSize,
                'name': $('#name').val(),
                'owner': $('#owner').val(),
                'startTime': $('#startTime').val(),
                'endTime': $('#endTime').val(),
            },
            type: 'get',
            dataType: 'json',
            success: function (data) {
                console.log(data);
                //清空上一次拼接的数据
                $('#activityBody').html("");
                //后台传递的每页的总数居
                var dataList = data.dataList;
                for (var i = 0; i < dataList.length; i++) {
                    //list:每次遍历的数据
                    var list = dataList[i];
                    $('#activityBody').append("<tr class=\"active\">\n" +
                        "<td><input type=\"checkbox\" class=\"son\" value=\"" +list.id+ "\"/></td>\n" +
                        "<td><a style=\"text-decoration: none; cursor: pointer;\" href='${pageContext.request.contextPath}/workbench/activity/queryActivityDetailById?id="+list.id+"'>" + list.name + "</a></td>\n" +
                        "<td>" + list.uname + "</td>\n" +
                        "<td>" + list.startDate + "</td>\n" +
                        "<td>" + list.endDate + "</td>\n" +
                        "</tr> ");
                }

                //利用分页插件查询第一页数据
                $("#activityPage").bs_pagination({
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

    //条件查询日历插件
    $("#startTime").datetimepicker({
        language: "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn: true,
        pickerPosition: "bottom-left"
    });

    $("#endTime").datetimepicker({
        language: "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn: true,
        pickerPosition: "bottom-left"
    });

    //创建市场活动日期
    $("#create-startTime").datetimepicker({
        language: "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn: true,
        pickerPosition: "bottom-left"
    });
    $("#create-endTime").datetimepicker({
        language: "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn: true,
        pickerPosition: "bottom-left"
    });

    //修改模态窗的日历插件
    $("#edit-startTime").datetimepicker({
        language: "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn: true,
        pickerPosition: "bottom-left"
    });
    $("#edit-endTime").datetimepicker({
        language: "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
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