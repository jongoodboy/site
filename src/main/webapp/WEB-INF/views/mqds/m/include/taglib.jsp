<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fns" uri="/WEB-INF/tlds/fns.tld" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}${fns:getFrontPath()}"/>
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static"/>
<%
    Object version = new Date().getTime();
%>
<c:set var="version" value="<%=version%>"></c:set>
<script>
    var ctx = '${ctx}';
</script>
