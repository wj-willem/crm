<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">

<link href="${pageContext.request.contextPath}/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<%--导入layer弹窗--%>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/jquery/layer-v3.1.1/layer/layer.js"></script>
<script type="text/javascript">

	//默认情况下取消和保存按钮是隐藏的
	var cancelAndSaveBtnDefault = true;
	
	$(function(){
		$("#remark").focus(function(){
			if(cancelAndSaveBtnDefault){
				//设置remarkDiv的高度为130px
				$("#remarkDiv").css("height","130px");
				//显示
				$("#cancelAndSaveBtn").show("2000");
				cancelAndSaveBtnDefault = false;
			}
		});
		
		$("#cancelBtn").click(function(){
			//显示
			$("#cancelAndSaveBtn").hide();
			//设置remarkDiv的高度为130px
			$("#remarkDiv").css("height","90px");
			cancelAndSaveBtnDefault = true;
		});
		
		$(".remarkDiv").mouseover(function(){
			$(this).children("div").children("div").show();
		});
		
		$(".remarkDiv").mouseout(function(){
			$(this).children("div").children("div").hide();
		});
		
		$(".myHref").mouseover(function(){
			$(this).children("span").css("color","red");
		});
		
		$(".myHref").mouseout(function(){
			$(this).children("span").css("color","#E6E6E6");
		});
	});
	
</script>

</head>
<body>

    <!-- 修改市场活动的模态窗口 -->
    <div class="modal fade" id="editActivityModal" role="dialog">
        <div class="modal-dialog" role="document" style="width: 85%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">修改市场活动</h4>
                </div>
                <div class="modal-body">

                    <form class="form-horizontal" role="form">

                        <div class="form-group">
                            <label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <select class="form-control" id="edit-marketActivityOwner">
                                    <option>zhangsan</option>
                                    <option>lisi</option>
                                    <option>wangwu</option>
                                </select>
                            </div>
                            <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-marketActivityName" value="发传单">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-startTime" value="2020-10-10">
                            </div>
                            <label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-endTime" value="2020-10-20">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="edit-cost" class="col-sm-2 control-label">成本</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-cost" value="5,000">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" id="edit-describe">市场活动Marketing，是指品牌主办或参与的展览会议与公关市场活动，包括自行主办的各类研讨会、客户交流会、演示会、新产品发布会、体验会、答谢会、年会和出席参加并布展或演讲的展览会、研讨会、行业交流会、颁奖典礼等</textarea>
                            </div>
                        </div>

                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal">更新</button>
                </div>
            </div>
        </div>
    </div>

	<!-- 返回按钮 -->
	<div style="position: relative; top: 35px; left: 10px;">
		<a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left" style="font-size: 20px; color: #DDDDDD"></span></a>
	</div>
	
	<!-- 大标题 -->
	<div style="position: relative; left: 40px; top: -30px;">
		<div class="page-header">
			<h3>市场活动-${activity.name} <small>${activity.startDate} ~ ${activity.endDate}</small></h3>
		</div>
		<div style="position: relative; height: 50px; width: 250px;  top: -72px; left: 700px;">
			<button type="button" class="btn btn-default" data-toggle="modal" data-target="#editActivityModal"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			<button type="button" class="btn btn-danger" id="deleteActivityBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>
	
	<!-- 详细信息 -->
	<div style="position: relative; top: -70px;">
		<div style="position: relative; left: 40px; height: 30px;">
			<div style="width: 300px; color: gray;">所有者</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${activity.owner}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">名称</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${activity.name}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>

		<div style="position: relative; left: 40px; height: 30px; top: 10px;">
			<div style="width: 300px; color: gray;">开始日期</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${activity.startDate}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">结束日期</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${activity.endDate}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 20px;">
			<div style="width: 300px; color: gray;">成本</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${activity.cost}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 30px;">
			<div style="width: 300px; color: gray;">创建者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${activity.createBy}&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">${activity.createTime}</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 40px;">
			<div style="width: 300px; color: gray;">修改者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${activity.editBy}&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">${activity.editTime}</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 50px;">
			<div style="width: 300px; color: gray;">描述</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					${activity.description}
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
	</div>
	
	<!-- 备注 -->
	<div style="position: relative; top: 30px; left: 40px;">
		<div class="page-header">
			<h4>备注</h4>
		</div>

		<div id="abc">
		<!-- 备注1 -->
		<c:forEach items="${activity.activityRemarks}" var="activityRemark">
			<div class="remarkDiv" id="deleteRemarkDiv${activityRemark.id}" style="height: 60px;">
				<img title="zhangsan" src="${pageContext.request.contextPath}/image/user-thumbnail.png" style="width: 30px; height:30px;">
				<div style="position: relative; top: -40px; left: 40px;" >
					<h5 id="activityH5${activityRemark.id}">${activityRemark.noteContent}</h5>
					<font color="gray">市场活动</font> <font color="gray">-</font> <b>${activity.name}</b> <small style="color: gray;"> ${activityRemark.createTime} 由 ${activityRemark.createBy}</small>
					<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
						<a class="myHref" id="editActivityRemark${activityRemark.id}" href="javascript:void(0)"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a class="myHref" id="deleteActivityRemark${activityRemark.id}" href="javascript:void(0);"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>
					</div>
				</div>
			</div>


			<!-- 修改市场活动备注的模态窗口 -->
			<div class="modal fade" id="editRemarkModal${activityRemark.id}" role="dialog">
					<%-- 备注的id --%>
				<input type="hidden" id="remarkId${activityRemark.id}">
				<div class="modal-dialog" role="document" style="width: 40%;">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">×</span>
							</button>
							<h4 class="modal-title" id="myModalLabel1">修改备注</h4>
						</div>
						<div class="modal-body">
							<form class="form-horizontal" role="form">
								<div class="form-group">
									<label for="edit-describe" class="col-sm-2 control-label">内容</label>
									<div class="col-sm-10" style="width: 81%;">
										<textarea class="form-control" rows="3" id="noteContent${activityRemark.id}"></textarea>
									</div>
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
							<button type="button" class="btn btn-primary" id="updateRemarkBtn${activityRemark.id}">更新</button>
						</div>
					</div>
				</div>
			</div>


			<script>
				//点击不同修改按钮，修改对应市场活动备注

				$('#editActivityRemark${activityRemark.id}').click(function () {

					//显示备注窗口
					$('#editRemarkModal${activityRemark.id}').modal('show');
					//把备注的内容显示在模态窗中
					<%--$('#noteContent${activityRemark.id}').val('${activityRemark.noteContent}');--%>
					$('#noteContent${activityRemark.id}').val($('#activityH5${activityRemark.id}').html());

					//把隐藏域的内容改成当前备注的主键
					$('#remarkId${activityRemark.id}').val('${activityRemark.id}');
				});


				//点击更新备注按钮，异步修改备注信息
				$('#updateRemarkBtn${activityRemark.id}').click(function () {

					//获取每个模态窗对应隐藏域的备注的id号
					var remarkId = $('#remarkId${activityRemark.id}').val();
					//发送异步请求，更新备注信息
					$.ajax({
						url : '${pageContext.request.contextPath}/workbench/activity/updateActivityRemark',
						data : {
							'id' : remarkId,
							'noteContent':$('#noteContent${activityRemark.id}').val()
						},
						type : 'get',
						dataType : 'json',
						success : function(data){
							if(data.success){
								layer.alert(data.message, {icon: 6});
								//关闭模态窗口
								$('#editRemarkModal${activityRemark.id}').modal('hide');
								//先修改成功，才能修改页面
								//获取最新数据(刷新页面不想走后台再次查询)，把模态床中最新输入的内容给填充到被修改的备注中即可
								var noteContent = $('#noteContent${activityRemark.id}').val();
								$('#activityH5${activityRemark.id}').html(noteContent);
							}

						}
					});

				});

				//点击删除按钮删除备注
				$('#deleteActivityRemark${activityRemark.id}').click(function () {

					//把隐藏域的内容改成当前备注的主键
					$('#remarkId${activityRemark.id}').val('${activityRemark.id}');
					//获取每个模态窗对应隐藏域的备注的id号
					var remarkId = $('#remarkId${activityRemark.id}').val();

					//发送异步请求，删除备注信息
					$.ajax({
						url : '${pageContext.request.contextPath}/workbench/activity/deleteActivityRemark',
						data : {
							'id' : remarkId
						},
						type : 'get',
						dataType : 'json',
						success : function(data){
							if(data.success){
								layer.alert(data.message, {icon: 6});
								//删除页面元素
								$('#deleteRemarkDiv${activityRemark.id}').remove();
							}

						}
					});

				});
			</script>
		</c:forEach>
		</div>
		<div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
			<form role="form" style="position: relative;top: 10px; left: 10px;">
				<textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"  placeholder="添加备注..."></textarea>
				<p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
					<button id="cancelBtn" type="button" class="btn btn-default">取消</button>
					<button type="button" id="saveRemarkBtn" class="btn btn-primary">保存</button>
				</p>
			</form>
		</div>
	</div>
	<div style="height: 200px;"></div>
	<script>
		//添加备注
		$('#saveRemarkBtn').click(function () {
			//获取用户输入的备注内容，向后台发送异步请求
			$.ajax({
				url : '${pageContext.request.contextPath}/workbench/activity/saveActivityRemark',
				data : {
					'noteContent' : $('#remark').val(),
					'activityId' : '${activity.id}'
				},
				type : 'post',
				dataType : 'json',
				success : function(data){
					//添加成功
					if(data.success){
						//弹窗提示
						layer.alert(data.message, {icon: 6});
						//将页面的内容修改
						location.href = "${pageContext.request.contextPath}/workbench/activity/queryActivityDetailById?id=${activity.id}";
					}
				}
			});
		});


		//点击删除按钮
		$('#deleteActivityBtn').click(function () {
			//因为删除按钮就在市场活动详情页面，如果使用ajax删除之后会返回当前页面，而当前页面的已经被删除
			//会导致删除成功后回到本页面会没有数据量
			//采用传统请求 除了ajax之外都是传统请求
			layer.msg('确定删除当前市场活动吗？', {
				time: 0 //不自动关闭
				, btn: ['确定', '取消']
				, yes: function (index) {
					// 点击确定按钮，执行代码块，不会关闭当前提示
					layer.close(index);
					location.href = '${pageContext.request.contextPath}/workbench/activity/deleteActivityByDetail?id=${activity.id}';
				}
			});
		});
	</script>

</body>
</html>