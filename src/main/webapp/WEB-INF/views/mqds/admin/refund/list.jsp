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

        textarea {
            width: 80%;
        }
    </style>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active">退款列表</li>
</ul>
<sys:message content="${message}"/>
<form:form id="searchForm" modelAttribute="order" action="${ctx}/refund/reFundList" method="post"
           class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form">
        <li>
            <label>退款状态：</label>
            <input id="commodityRelease1" name="refuntState"
                   onclick="$('#searchForm').submit();" type="radio" value="1"
                   <c:if test="${applyRefund.refuntState == '1'}">checked </c:if>/>
            <label for="commodityRelease1">退款中</label>
            <input id="commodityRelease2" name="refuntState"
                   onclick="$('#searchForm').submit();" type="radio" value="0"
                   <c:if test="${applyRefund.refuntState == '0'}">checked </c:if>/>
            <label for="commodityRelease2">退款成功</label>
            <input id="commodityRelease3" name="refuntState"
                   onclick="$('#searchForm').submit();" type="radio" value="-1"
                   <c:if test="${applyRefund.refuntState == '-1'}">checked </c:if>/>
            <label for="commodityRelease3">退款失败</label>
        </li>
        <li class="clearfix"></li>
    </ul>
</form:form>
<table id="treeTable" class="table table-striped table-bordered table-condensed">
    <tr>
        <th>订单号</th>
        <th>退款商品</th>
        <th>退款数量</th>
        <th>单价</th>
        <th>申请退款金额</th>
        <th>申请描述</th>
        <th>申请时间</th>
        <th>操作人</th>
        <th>操作描述</th>
        <th>操作状态</th>
        <th>操作时间</th>
        <th>操作</th>
    </tr>
    <c:forEach items="${reFundListMap}" var="tpl">
        <tr>
            <td>${tpl.orderNumber}</td>
            <td>${tpl.comName}</td>
            <td>${tpl.ordNumber}</td>
            <td>${tpl.ordPrice}</td>
            <td>${tpl.applyFundMoney}</td>
            <td>${tpl.applyDescribe}</td>
            <td><fmt:formatDate value="${tpl.applyRefuntDate}" pattern="yyyy-mm-dd HH:mm:ss"/></td>
            <td>${tpl.applyUpdateName}</td>
            <td>${tpl.refundDescribe}</td>
            <td>
                <c:if test="${tpl.applyRefuntState == '1'}">
                    申请退款中
                </c:if>
                <c:if test="${tpl.applyRefuntState == '0'}">
                    退款成功
                </c:if>
                <c:if test="${tpl.applyRefuntState == '-1'}">
                    退款失败
                </c:if>
            </td>
            <td><fmt:formatDate value="${tpl.applyUpdateDate}" pattern="yyyy-mm-dd HH:mm:ss"/></td>
            <td>
                <c:if test="${tpl.applyRefuntState == '1'}"> <!--申请退款中-->
                    <a href="javascript:delivery('${tpl.refundId}','${tpl.orderId}','${tpl.orderNumber}','${tpl.comId}')">同意退款</a>
                </c:if>
            </td>
        </tr>
    </c:forEach>
</table>
<div class="pagination">${page}</div>
<!--发货框-->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">操作</h4>
            </div>
            <div class="modal-body">
                <textarea placeholder="请输入退款描述" id="refundDescribe"></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="refund()">确定退款</button>
            </div>
        </div>
    </div>
</div>
<script>
    var paramDate = {
        refundState: "0",//(0已退款，1退款中，-1退款失败）
        refundId: "",//退款ID
        refundPeolpe: '${fns:getUser().name}',//退款人
        refundDescribe: "",//退款操作人描述
        orderId: "",//订单的ID
        updateBy: '${fns:getUser().id}', //退款人Id
        orderNumber: "",//订单号用于扣除已经分成的上线
        commodityId: ""//商品Id用于扣除已经分成的上线
    }
    //退款窗口
    function delivery(id, orderId, orderNumber, commodityId) {
        paramDate.refundId = id;
        paramDate.orderId = orderId;
        paramDate.orderNumber = orderNumber;
        paramDate.commodityId = commodityId;
        $('#myModal').modal('show');
    }
    //确认退款
    function refund() {
        var refundDescribe = $("#refundDescribe").val();
        if (refundDescribe == "") {
            alertx("请输入退款描述");
            return;
        }
        paramDate.refundDescribe = refundDescribe;
        $.post("${ctx}/refund/operation", paramDate, function (ret) {
            if (ret.code == "0") {
                $("#searchForm").submit();
            } else {
                alert(ret.msg);
            }
        })
    }
</script>
</body>
</html>