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
    <li class="active"><a href="${ctx}/cms/category/">订单列表</a></li>
</ul>
<sys:message content="${message}"/>
<form:form id="searchForm" modelAttribute="order" action="${ctx}/order/orderList" method="post"
           class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form">
        <li>
            <label>订单状态：</label>
            <c:forEach items="${fns:getDictList('order_state')}" var="type">
                <input id="commodityRelease${type.value}" name="orderState"
                       onclick="$('#searchForm').submit();" type="radio" value="${type.value}"
                       <c:if test="${type.value == order.orderState}">checked </c:if>/>
                <label for="commodityRelease${type.value}">${type.label}</label>
            </c:forEach>
        </li>
        <li class="clearfix"></li>
    </ul>
</form:form>
<table id="treeTable" class="table table-striped table-bordered table-condensed">
    <tr>
        <th>订单号</th>
        <th>商品名称</th>
        <th>购买数量</th>
        <th>单位</th>
        <th>单价</th>
        <th>下单时间</th>
        <th>收货人</th>
        <th>收货人电话</th>
        <th>收货地址</th>
        <th>快递</th>
        <th>快递单号</th>
        <th>发货时间</th>
        <th>发货人</th>
        <th>状态</th>
        <th>操作</th>
    </tr>
    <c:forEach items="${orderListMap}" var="tpl">
        <tr>
            <td>${tpl.orderNumber}</td>
            <td>${tpl.commodityName}</td>
            <td>${tpl.commodityNumber}</td>
            <td>${fns:getDictLabel(tpl.company, 'commodity_company', '')}</td>
            <td>${tpl.commodityPrice}</td>
            <td><fmt:formatDate value="${tpl.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td>${tpl.consignee}</td>
            <td>${tpl.consigneePhone}</td>
            <td>${tpl.address}</td>
            <td>${tpl.express}</td>
            <td>${tpl.expressNumber}</td>
            <td><fmt:formatDate value="${tpl.deliveryTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td>${tpl.deliveryPeolpe}</td>
            <td>${fns:getDictLabel(tpl.orderState, 'order_state', '')}</td>
            <td>
                <c:if test="${tpl.orderState == '2'}"> <!--已付款-->
                    <a href="javascript:delivery('${tpl.id}')">发货</a>
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
                <input type="text" placeholder="输入货运单" name="expressNumber"><br/>
               <%-- <c:forEach items="${fns:getDictList('express_type')}" var="express">
                    <input id="expressType${express.value}" type="radio" value="${express.value}"
                           onclick="express(this)"
                           <c:if test="${express.value == '1'}">checked </c:if>/>
                    <label for="expressType${express.value}">${express.label}</label>
                </c:forEach>--%>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="deliveryActeve()">确定发货</button>
            </div>
        </div>
    </div>
</div>
<script>
    var paramDate = {
        orderState: "3",//(0已完成,1待付款,2.待发货,3已发货,4退款中,5已退款)
        orderId: "",//订单ID
        expressNumber: "",//快递单号
     /*   express: "1",//快递公司 默认圆通*/
        deliveryPeolpe: '${fns:getUser().name}'//发货人
    }
    //打开发货窗口
    function delivery(id) {
        paramDate.orderId = id;
        $('#myModal').modal('show');
    }
    //发货单选框事件
    function express(ev) {
        $(ev).siblings().attr("checked", false);
        paramDate.express = $(ev).val();
    }
    //确认发货
    function deliveryActeve() {
        var expressNumber = $("input[name='expressNumber']").val();
        if (expressNumber == "") {
            alertx("请输入订单号");
            return;
        }
      /*  if (paramDate.express == "") {
            alert("请选择快递公司");
            return;
        }*/
        paramDate.expressNumber = expressNumber;
        $.post("${ctx}/order/delivery", paramDate, function (ret) {
            alertx(ret.msg);
            if (ret.code == "0") {
                $("#searchForm").submit();
            }
        })
    }
</script>
</body>
</html>