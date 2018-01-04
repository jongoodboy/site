<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/treetable.jsp" %>
    <script type="text/javascript">
        $(document).ready(function () {
        });
        function page(n, s) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
        function updateSort() {
            loading('正在提交，请稍等...');
            $("#listForm").attr("action", "${ctx}/cms/category/updateSort");
            $("#listForm").submit();
        }
    </script>
    <style>
        .form-search .ul-form li label {
            width: auto;
            margin: 0;
        }

        .form-search .ul-form li {
            margin-right: 40px;
        }
    </style>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="#">提现列表</a></li>
</ul>
<sys:message content="${message}"/>
<form:form id="searchForm" modelAttribute="cashWithDrawal" action="${ctx}/withdrawals/list" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <form:select path="delFlag" class="input-mini"  onchange="$('#searchForm').submit();">
        <form:options items="${fns:getDictList('withdrawals_state')}" itemLabel="label" itemValue="value" htmlEscape="false" />
    </form:select>
</form:form>
<table id="treeTable" class="table table-striped table-bordered table-condensed">
    <tr>
        <th>提现时间</th>
        <th>所属银行</th>
        <th>提现卡号</th>
        <th>用户名字</th>
        <th>提现金额</th>
        <th>提现状态</th>
        <th>操作</th>
    </tr>
    <c:forEach items="${page.getList()}" var="tpl">
        <tr>
            <td><fmt:formatDate value="${tpl.createDate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td>${tpl.bankName}</td>
            <td>${tpl.bankNumber}</td>
            <td>${tpl.bankNumberName}</td>
            <td>${tpl.getCash}</td>
            <td>${fns:getDictLabel(tpl.delFlag, 'withdrawals_state', '')}</td>
            <td><c:if test="${tpl.delFlag == '0'}"><a href="javascript:transferAccounts('${tpl.id}','${tpl.getCash}')">转账</a></c:if></td>
        </tr>
    </c:forEach>
</table>
<!--转账提示框-->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">操作</h4>
            </div>
            <div class="modal-body">
                <span>本次转账金额为:<span id="transferAccounts"></span>元</span><br/>
                <span>请确保已为用户转账</span>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="determine()">确定转账</button>
            </div>
        </div>
    </div>
</div>
<div class="pagination">${page}</div>
<script>
    var DATA = {
        id:"",
        delFlag:"1"//处理状态(0处理中,1已到账,2提现失败,-1标记删除)
    }
    //转账提示框
    function transferAccounts(id, money) {
        DATA.id = id;
        $('#myModal').modal('show');
        $("#transferAccounts").html(money);
    }

    //确定转账
    function determine() {
        $.post("${ctx}/withdrawals/determine",DATA, function (ret) {
            alertx(ret.msg);
            if(ret.code == "0"){
                $("#searchForm").submit();
            }
        })
    }
</script>
</body>
</html>