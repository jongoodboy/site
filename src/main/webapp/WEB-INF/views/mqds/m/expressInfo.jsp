<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/taglib.jsp" %>
<html>
<head>
    <script src="${ctxStatic}/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${ctxStatic}/m/css/express.css"/>
</head>
<body>
<script type="text/javascript">
    $(document).ready(function (e) {
        var t = JSON.parse('${data}');//物流信息
        var str = "";
        for (var i = 0; i < t.result.list.length; i++) {
            str += "<li>"  + t.result.list[i].time + t.result.list[i].status + "</li>";
        }
        $("#expressInfo").append(str);
        var h = $(".about4_main ul li:first-child").height() / 2;
        <!--第一个li高度的一半-->
        var h1 = $(".about4_main ul li:last-child").height() / 2;
        <!--最后一个li高度的一半-->
        $(".line").css("top", h);
        $(".line").height($(".about4_main").height() - h1 - h);
    });
</script>
<div class="about4">
    <div class="about4_ch">物流信息</div>
    <div class="about4_main">
        <div class="line"></div>
        <ul id="expressInfo">
            <%--  <c:forEach items="${data.result.list}" var="itme">
                  <li>
                          ${itme.status}
                  </li>
              </c:forEach>--%>
        </ul>
    </div>
</div>
</body>
</html>
