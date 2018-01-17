<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>添加商品</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#inputForm").validate({
                submitHandler: function (form) {
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
        });
        classification()
        //所属区域选择
        function classification(select) {
            $("#belongSpecialty").html('');
            $("#belongSpecialty").prev().find("span.select2-chosen").html('');
            var belongRegion = '${commodity.belongRegion}';
            var commodityClassificationParant = $("#belongRegion").val();//所选的区域
            if (belongRegion != '' && select == undefined) {
                commodityClassificationParant = belongRegion;
            } else if (belongRegion == '' && select == undefined) {
                commodityClassificationParant = 1;//默认贵州
            }
            $.post("${ctx}/commodityClassification/listData?commodityClassificationParant=" + commodityClassificationParant, function (ret) {
                if (ret.code == "0") {
                    var data = ret.data;
                    var str = "";
                    var selected = "";
                    for (var i = 0; i < data.length; i++) {
                        if (data[i].id == '${commodity.belongSpecialty}') {
                            selected = "selected";
                            $("#belongSpecialty").prev().find("span.select2-chosen").html(data[i].commodityClassificationName);
                        } else {
                            selected = "";
                        }
                        str += '<option value="' + data[i].id + '" ' + selected + '>' + data[i].commodityClassificationName + '</option>'
                    }
                    $("#belongSpecialty").append(str);
                }
            })
        }
        function addSpecifications(ev) {
            var evThis = $(ev);
            if (evThis.html() == "-删除规格") {
                evThis.parent().parent().remove();
                return;
            }
            evThis.html("-删除规格");
            var str = '<div class="control-group"><label class="control-label">商品规格:</label><div class="controls">';
            str += '<input type="text" name="specificationsParameter" class="form-control required"/> <label>商品价格:</label>';
            str += '<input type="number" name="specificationsCommodityPice" class="form-control required" maxlength="200"/>';
            str += ' <span class="btn" onclick="addSpecifications(this)">+添加规格</span></div></div>';
            evThis.parent().parent().after(str);
        }
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/commodity/list">商品列表</a></li>
    <li class="active"><a href="#">添加商品</a></li>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="commodity" action="${ctx}/commodity/save" method="post"
           class="form-horizontal">
    <form:hidden path="id"/>
    <sys:message content="${message}"/>
    <div class="control-group">
        <label class="control-label">商品名称:</label>
        <div class="controls">
            <form:input path="commodityName" htmlEscape="false" maxlength="200"
                        class="input-xxlarge required measure-input"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">商品类型:</label>
        <div class="controls">
            <form:select path="commodityType" class="input-mini">
                <form:options items="${fns:getDictList('commodity_type')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
            <label>商品状态:</label>
            <form:select path="commodityState" class="input-mini">
                <form:options items="${fns:getDictList('commodity_state')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
            <label>商品单位:</label>
            <form:select path="commodityCompany" class="input-mini">
                <form:options items="${fns:getDictList('commodity_company')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
            <label>发布状态:</label>
            <form:select path="commodityRelease" class="input-mini">
                <form:options items="${fns:getDictList('commodity_release')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">所属区域:</label>
        <div class="controls">
            <form:select path="belongRegion" class="input-mini" onchange="classification('select')">
                <form:options items="${fns:getDictList('commodity_classification')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
            <label>所属特产:</label>
            <form:select path="belongSpecialty" class="input-mini required">
            </form:select>
            <label>默认快递:</label>
            <form:select path="defaultExpress" class="input-mini">
                <form:options items="${expressList}" itemLabel="expressName" itemValue="id" htmlEscape="false"/>
            </form:select>
            <label>是否包邮:</label>
            <form:select path="freeShipping" class="input-mini">
                <form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">商品口味:</label>
        <div class="controls">
            <c:forEach var="itme" items="${fns:getDictList('commodity_flavor')}">
                <input type="checkbox" value="${itme.value}"
                       id="commodityFlavor${itme.value}" name="commodityFlavors"
                <c:forEach items="${fn:split(commodity.commodityFlavor,',')}" var="flavor">
                       <c:if test="${itme.value == flavor}">checked</c:if>
                </c:forEach>>
                <label for="commodityFlavor${itme.value}">${itme.label}</label>
            </c:forEach>
        </div>
    </div>
    <%-- <div class="control-group">
         <label class="control-label">商品成本价:</label>
         <div class="controls">
             <form:input path="costPrice" htmlEscape="false" maxlength="200" type="number"/>
         </div>
     </div>--%>
    <%--<div class="control-group">
        <label class="control-label">运费:</label>
        <div class="controls">
            <form:input path="freight" htmlEscape="false" maxlength="200" type="number"/>元
        </div>
    </div>--%>
    <div class="control-group">
        <label class="control-label">商品库存量:</label>
        <div class="controls">
            <form:input path="commodityNumber" htmlEscape="false" maxlength="3" class="required" type="number"/>
            <label>商品位置:</label>
            <form:input path="commodityPosition" htmlEscape="false" maxlength="10" type="number"/>位置越小越靠前
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">商品折扣:</label>
        <div class="controls">
            <form:input path="commodityDiscount" htmlEscape="false" maxlength="5" type="number"/>
            <label>打折数量:</label>
            <form:input path="commodityDiscountNum" htmlEscape="false" maxlength="3" type="number"/>满足该数量才打折
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">展示重量:</label>
        <div class="controls">
            <form:input path="commodityWeightShow" htmlEscape="false" class="required" maxlength="5" type="number"/>
            <form:select path="commodityWeightUnit" class="input-mini">
                <form:options items="${fns:getDictList('commodity_nuit')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
            <label>重量:</label>
            <form:input path="weight" htmlEscape="false" class="required" maxlength="5" type="number"/>KG(商品本身重量,不做展示)
        </div>
    </div>
    <c:if test="${specificationsList != '[]'}"><!--等于空-->
        <c:forEach var="itme" items="${specificationsList}">
            <div class="control-group">
                <label class="control-label">商品规格:</label>
                <div class="controls">
                    <input type="text" name="specificationsId" value="${itme.id}" style="display: none">
                    <input type="text" name="specificationsParameter" class="form-control required"
                           value="${itme.specificationsParameter}"/>
                    <label>商品价格:</label>
                    <input type="number" name="specificationsCommodityPice" class="form-control required"
                           maxlength="200" value="${itme.specificationsCommodityPice}"/>
                    <span class="btn" onclick="addSpecifications(this)">-删除规格</span>
                </div>
            </div>
        </c:forEach>
    </c:if>
    <div class="control-group">
        <label class="control-label">商品规格:</label>
        <div class="controls">
            <input type="text" name="specificationsParameter" class="form-control required"/>
            <label>商品价格:</label>
            <input type="number" name="specificationsCommodityPice" class="form-control required" maxlength="200"/>
            <span class="btn" onclick="addSpecifications(this)">+添加规格</span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">商品图片:</label>
        <div class="controls">
            <input type="hidden" id="images" name="commodityImager" class="required"
                   value="${commodity.commodityImager}"/>
            <sys:ckfinder input="images" type="images" uploadPath="/cms/article" selectMultiple="true"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">分享描述:</label>
        <div class="controls">
            <form:textarea path="sharingDescription" htmlEscape="false" class="required"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">商品描述</label>
        <div class="controls">
            <form:textarea id="content" htmlEscape="true" path="commodityMaker" cclass="required" rows="4"
                           maxlength="200"/>
                <%--  <textarea id="commodityMaker" name="commodityMaker" cols="20" rows="2" class="ckeditor">${commodity.commodityMaker}</textarea>--%>
            <sys:ckeditor replace="commodityMaker" uploadPath="/cms/article"/>
        </div>
    </div>

    <div class="form-actions">
        <c:if test="${param.type != 0}"><input id="btnSubmit" class="btn btn-primary" type="submit"
                                               value="保 存"/>&nbsp;</c:if>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>