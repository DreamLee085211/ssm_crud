<%--
  Created by IntelliJ IDEA.
  User: lee
  Date: 2020/7/10
  Time: 21:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <% pageContext.setAttribute("APP_PATH",request.getContextPath()); %>
    <title>员工列表</title>
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="static/js/jquery-3.1.1.js"></script>
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<%--新增员工模态框--%>
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="emp_input_lastname" class="col-sm-2 control-label">lastName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="emp_input_lastname" placeholder="lastName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="emp_input_email" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="emp_input_email" placeholder="@lee.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <%--json获取的是value值，而且数据库gender字段规格为1，不改会报错405--%>
                                <input type="radio"  name="gender" id="genderOpt1" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="genderOpt2" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">department</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="empaddmodal_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>


<%--编辑员工模态框--%>
<div class="modal fade" id="empEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel2">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="emp_input_lastname" class="col-sm-2 control-label">lastName</label>
                        <div class="col-sm-10">
                            <p id="emp_edit_static" class="form-control-static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="emp_input_email" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="emp_edit_email" placeholder="@lee.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <%--json获取的是value值，而且数据库gender字段规格为1，不改会报错405--%>
                                <input type="radio"  name="gender" id="genderOpt3" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="genderOpt4" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">department</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="empeditmodal_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <!-- 标题部分 -->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM_CRUD</h1>
        </div>
    </div>
    <!-- 操作部分 -->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button id="add_emp_botton" class="btn btn-primary">新增</button>
            <button id="del_emp_button" class="btn btn-dange" >删除</button>
        </div>
    </div>
    <!-- 列表部分 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>
                            <input id="check_all" type="checkbox"/>
                        </th>
                        <th>#</th>
                        <th>lastName</th>
                        <th>email</th>
                        <th>gender</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody></tbody>

            </table>
        </div>
    </div>
    <!-- 页码部分 -->
    <div class="row">
        <%--页码--%>
        <div class="col-md-6" id="page_info_area">
        </div>
        <%--导航栏--%>
        <div class="col-md-6" id="page_nav_area">

        </div>
            <script type="text/javascript">
                //总记录数
                var totalRecord,currentPage;
                $(function () {
                    to_page(1);
                });

                function to_page(pn) {
                    $.ajax({
                        url:"${APP_PATH}/emps",
                        data:"pn="+pn,
                        type:"GET",
                        success:function (result) {
                            //console.log(result);
                            build_emps_table(result);
                            build_page_info(result);
                            build_page_nav(result)
                        }
                    })
                }
                /**
                 * 解析显示员工信息
                 * */
                function build_emps_table(result) {
                    $("#emps_table tbody").empty();
                    var emps = result.extend.pageInfo.list;
                    $.each(emps,function (index,item) {
                        var checkboxTd = $("<td><input type='checkbox' class='check_item'/></td>")
                        var empIdTd = $("<td></td>").append(item.empId);
                        var empNameTd = $("<td></td>").append(item.empName);
                        var emailTd = $("<td></td>").append(item.email);
                        var genderTd = $("<td></td>").append(item.gender);
                        var deptNameTd = $("<td></td>").append(item.department.deptName);
                        var edit_button = $("<button></button>").addClass("btn btn-primary edit_btn").append($("<span></span>")).addClass("glyphicon glyphicon-pencil").append("编辑");
                        edit_button.attr("edit_id",item.empId);
                        var del_button = $("<button></button>").addClass("btn btn-danger del_btn").append($("<span></span>")).addClass("glyphicon glyphicon-trash").append("删除");
                        del_button.attr("edit_id",item.empId);
                        var btnTd = $("<td></td>").append(edit_button).append(" ").append(del_button);
                        $("<tr></tr>").append(checkboxTd).append(empIdTd).append(empNameTd).append(emailTd).append(genderTd).append(deptNameTd).append(btnTd).appendTo("#emps_table tbody");
                    });
                }

                /**
                 * 解析分页信息
                 */
                function build_page_info(result) {
                    $("#page_info_area").empty();
                    $("#page_info_area").append("当前第"+result.extend.pageInfo.pageNum+"页,总"+result.extend.pageInfo.pages+"页,总共有"+result.extend.pageInfo.total+"条记录");
                    totalRecord = result.extend.pageInfo.total;
                    currentPage = result.extend.pageInfo.pageNum;
                }

                /**
                 * 解析导航信息
                 */
                function build_page_nav(result){
                    $("#page_nav_area").empty();
                    var fistPage = $("<li></li>").append(($("<a></a>")).append("首页").attr("href","#"));
                    var prePage = $("<li></li>").append(($("<a></a>")).append("&laquo;").attr("href","#"));
                    if(!result.extend.pageInfo.hasPreviousPage){
                        fistPage.addClass("disabled");
                        prePage.addClass("disabled");
                    }else{
                        fistPage.click(function () {
                            to_page(1);
                        })
                        prePage.click(function () {
                            to_page(result.extend.pageInfo.pageNum - 1);
                        })
                    }
                    var ulLi = $("<ul></ul>").addClass("pagination").append(fistPage).append(prePage);
                    $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
                        var pageLi = $("<li></li>").append(($("<a></a>")).append(item).attr("href","#"));
                        if(result.extend.pageInfo.pageNum == item){
                            pageLi.addClass("active");
                        }
                        pageLi.click(function () {
                            to_page(item);
                        })
                        ulLi.append(pageLi);
                    })
                    var nextPage = $("<li></li>").append(($("<a></a>")).append("&raquo;").attr("href","#"));
                    var lastPage = $("<li></li>").append(($("<a></a>")).append("末页").attr("href","#"));
                    if(!result.extend.pageInfo.hasNextPage){
                        lastPage.addClass("disabled");
                        nextPage.addClass("disabled");
                    }else{
                        nextPage.click(function () {
                            to_page(result.extend.pageInfo.pageNum +1);
                        })
                        lastPage.click(function () {
                            to_page(result.extend.pageInfo.pages);
                        })
                    }
                    ulLi.append(nextPage).append(lastPage);
                    var navLi = $("<nav></nav>").append(ulLi);
                    navLi.appendTo("#page_nav_area");
                }

                /**
                 * 表单重置
                 */
                function reset_form(ele) {
                    $(ele)[0].reset();
                    $(ele).find("*").removeClass("has-error has-success");
                    $(ele).find(".help-block").text("");
                }

                /**
                 * 全选全不选实现
                 */
                $("#check_all").click(function () {
                    //prop获取dom原生属性，attr获取自定义属性的值
                    $(".check_item").prop("checked",$("#check_all").prop("checked"));
                })
                $(document).on("click",".check_item",function () {
                    var flag = $(".check_item:checked").length == $(".check_item").length;
                    $("#check_all").prop("checked",flag);
                })

                /**
                 * 删除按钮点击事件
                 */
                $("#del_emp_button").click(function () {
                    var empName = "";
                    var del_ids = "";
                    $.each($(".check_item:checked"),function () {
                        empName += $(this).parents("tr").find("td:eq(2)").text()+",";
                        del_ids += $(this).parents("tr").find("td:eq(1)").text()+"-";
                    });
                    //去除最后的，和-
                    empName = empName.substring(0,empName.length-1);
                    del_ids = del_ids.substring(0,del_ids.length-1);
                    if(confirm("确定删除"+empName+"吗?")){
                        $.ajax({
                            url:"${APP_PATH}/emp/"+del_ids,
                            type:"DELETE",
                            success:function (result) {
                                alert(result.msg);
                                to_page(currentPage);
                            }
                        })
                    }
                })

                /**
                 * 删除按钮点击事件
                 */
                $(document).on("click",".del_btn",function () {
                    var empName = $(this).parents("tr").find("td:eq(2)").text();
                    if(confirm("确认删除["+empName+"]吗?")){
                        $.ajax({
                            url:"${APP_PATH}/emp/"+$(this).attr("edit_id"),
                            type:"DELETE",
                            success:function (result) {
                                alert("删除["+empName+"]成功");
                                to_page(currentPage);
                            }
                        })
                    }
                })

                /**
                 * 新增模态框中新增按钮点击事件
                 */
                $("#add_emp_botton").click(function () {
                    //清空模态框信息
                    reset_form("#empAddModal form");
                    //获取部门信息
                    getDepts("#empAddModal select");
                    //弹出模态框
                    $("#empAddModal").modal({
                        backdrop:"static"
                    });
                })

                /**
                 * 编辑模态框
                 */
                //1、我们是按钮创建之前就绑定了click，所以绑定不上
                //1）可以再创建之前绑定click   2）绑定.on
                $(document).on("click",".edit_btn",function () {
                    //清空模态框信息
                    reset_form("#empEditModal form");
                    //获取部门信息
                    getDepts("#empEditModal select");
                    getEmp($(this).attr("edit_id"));
                    var id = $(this).attr("edit_id");
                    console.log(id);
                    //给更新按钮绑定员工id
                    $("#empeditmodal_update_btn").attr("edit_id",id);
                    //弹出模态框
                    $("#empEditModal").modal({
                        backdrop:"static"
                    });

                })

                /**
                 * 获取下拉列表部门信息
                 */
                function getDepts(ele) {
                    $(ele).empty();
                    $.ajax({
                        url:"${APP_PATH}/depts",
                        type: "GET",
                        success:function (result) {
                            $.each(result.extend.depts,function () {
                                var option = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                                $(ele).append(option);
                            })
                        },
                    });
                }

                /**
                 * 获取员工信息
                 */
                function getEmp(id) {
                    $.ajax({
                        url:"${APP_PATH}/emp/"+id,
                        type:"GET",
                        success:function (result) {
                            //console.log(result);
                            var empData = result.extend.emp;
                            $("#emp_edit_static").text(empData.empName);
                            $("#emp_edit_email").val(empData.email);
                            $("#empEditModal input[name=gender]").val([empData.gender]);
                            $("#empEditModal select").val([empData.dId]);
                        }
                    })
                }

                /**
                 * 校验信息
                 */
                function show_validate_msg(ele,status,msg){
                    $(ele).parent().removeClass("has-success has-error");
                    $(ele).next("span").text("");
                    if("success" == status){
                        $(ele).parent().addClass("has-success");
                        $(ele).next("span").text(msg);
                    }else if("error" == status){
                        $(ele).parent().addClass("has-error");
                        $(ele).next("span").text(msg);
                    }
                }

                /**
                 * 验证用户名是否重复
                 */
                $("#emp_input_lastname").change(function () {
                    var empName = this.value;
                    $.ajax({
                        url:"${APP_PATH}/checkUser",
                        type:"POST",
                        data:"empName="+empName,
                        success:function (result) {
                            if(result.code == 100){
                                show_validate_msg("#emp_input_lastname","success","用户名可用");
                                $("#empaddmodal_save_btn").attr("ajax_va","success");
                            }else{
                                show_validate_msg("#emp_input_lastname","error",result.extend.va_msg);
                                $("#empaddmodal_save_btn").attr("ajax_va","error");
                            }
                        }
                    })
                })

                /**
                 * 编辑模态框更新按钮
                 */
                $("#empeditmodal_update_btn").click(function () {
                    var email = $("#emp_edit_email").val();
                    var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                    if(!regEmail.test(email)){
                        show_validate_msg("#emp_edit_email","error","邮箱不正确");
                    }else{
                        show_validate_msg("#emp_edit_email","success","");
                    }
                    $.ajax({
                        url:"${APP_PATH}/emp/"+$(this).attr("edit_id"),
                        type:"PUT",
                        data:$("#empEditModal form").serialize(),
                        success:function (result) {
                            if (result.code == 100) {
                                $("#empEditModal").modal("hide");
                                to_page(currentPage);
                            } else {
                                alert("更新失败");
                            }
                        }
                    })
                })

                /**
                 * 新增模态框保存按钮
                 */
                $("#empaddmodal_save_btn").click(function () {
                    //校验姓名和邮箱
                    var name = $("#emp_input_lastname").val();
                    var regName = /(^[A-Za-z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
                    if(!regName.test(name)){
                        show_validate_msg("#emp_input_lastname","error","jq-用户名不正确");
                        return false;
                    }else{
                        show_validate_msg("#emp_input_lastname","success","");
                    }

                    var name = $("#emp_input_email").val();
                    var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                    if(!regEmail.test(name)){
                        show_validate_msg("#emp_input_email","error","jq-邮箱不正确");
                        return false;
                    }else{
                        show_validate_msg("#emp_input_email","success","");
                    }
                    if($(this).attr("ajax_va") == "error"){
                        return false;
                    }
                    $.ajax({
                        url:"${APP_PATH}/emp",
                        type:"POST",
                        data: $("#empAddModal form").serialize(),
                        success:function (result) {
                            if(result.code == 100){
                                //员工保存成功
                                //1、关闭模态框
                                $('#empAddModal').modal('hide');
                                //2、跳转到最后一页，显示数据
                                to_page(totalRecord);
                            }else{
                                if("undefined" != result.extend.errorFields.empName){
                                    show_validate_msg("#emp_input_lastname","error",result.extend.errorFields.empName);
                                }
                                if("undefined" != result.extend.errorFields.email){
                                    show_validate_msg("#emp_input_email","error",result.extend.errorFields.email);
                                }
                            }
                        }
                    })


                })
            </script>
    </div>
</div>
</body>
</html>
