<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/taglib.jsp" %>
<html>
<!--我的店铺-->
<head>
    <%@include file="include/head.jsp" %>
    <script src="${ctxStatic}/m/js/echarts.common.min.js" type="text/javascript"></script>
</head>
<style>
    .am-list-news-bd {
        background: #fff;
        padding: 5px;
        margin-bottom: 10px;
    }

    span {
        font-size: 14px;
    }

    .span {
        display: inline-block;
        width: 100%;
        text-align: center;
    }

    .am-cf li {
        text-align: center;
    }

    .to-date-money, .the-month-money {
        font-size: 30px;
        font-weight: bold;
    }

    .the-month-money {
        font-size: 20px;
    }

    .the-month-title {
        font-size: 18px;
    }

    .admin-sidebar-list {
        display: none;
        margin: 0;
    }

    a:focus, a:hover, a {
        color: #333;
    }

    .am-panel > .am-list > li > a {
        font-size: 12px;
        padding: 0;
    }

    .am-panel > .am-list > li > a > span {
        display: inline-block;
        width: 20%;
        text-align: right;
    }

    .am-panel > .am-list > li > a > span:first-child {
        width: 60%;
        text-align: left;
    }

    .am-panel > .am-list > li {
        padding: 0 5px;
        border-bottom: 1px solid #f9f9f9;
    }
</style>
<body>
<div class="am-list-news-bd header">
    <span class="span">今日收益</span>
    <span class="span to-date-money">${toDateProfit}</span>
    <ul class="am-navbar-nav am-cf am-avg-sm-3">
        <li>
            <span>团队收益</span><br>
            <span>${team}</span>
        </li>
        <li>
            <span>开店收益</span><br>
            <span>${shop}</span>
        </li>
        <li>
            <span>累积收益</span><br>
            <c:if test="${shop == toDateProfit || team == toDateProfit}"><!--如果今日收等于开店收益说明是第一天卖出去东西累计金额不加上今日收益-->
            <span>${team + shop}</span>
            </c:if>
            <c:if test="${shop != toDateProfit && team != toDateProfit}">
                <span>${team + shop+toDateProfit}</span>
            </c:if>
        </li>
    </ul>
</div>
<div class="am-list-news-bd">
    <span class="the-month-title span">月收益</span>
    <span class="the-month-money span">0.00</span>
    <div id="main" style="width: 100%;height:50%;"></div>
    <span class="span month-detail">查看更多></span>
    <ul class="am-list admin-sidebar-list">
        <!-- 每周收益明细-->
    </ul>
</div>
<div class="am-list-news-bd">
    <span>订单中心</span>
    <ul class="am-navbar-nav am-cf am-avg-sm-4 ul-order" style="margin-top: 20px">
        <li class="all">
            <a href="${ctx}/m/orderList?index=1" class="">
                <i class="all-order"></i>
                <span>全部订单</span>
            </a>
        </li>
        <li>
            <a href="${ctx}/m/orderList?index=2" class="">
                <i class="daifahuo"></i>
                <span>待发货</span>
            </a>
        </li>
        <li class="shipment">
            <a href="${ctx}/m/orderList?index=3" class="">
                <i class="daishouhuo"></i>
                <span>待收货</span>
            </a>
        </li>
        <li class="receipt">
            <a href="${ctx}/m/orderList?index=0" class="">
                <i class="complete"></i>
                <span>已完成</span>
            </a>
        </li>
    </ul>
</div>
</body>
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));

    // 指定图表的配置项和数据
    var option = {
        title: {
            text: ''
        },
        tooltip: {},
        legend: {
            data: ['收益']
        },
        xAxis: {
            data: ["第一周", "第二周", "第三周", "第四周", "第五周"]
        },
        yAxis: {},
        series: [{
            name: '收益',
            type: 'bar',
            data: ['${week1}', '${week2}', '${week3}', '${week4}', '${week5}']
        }]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
    //每周的数据
    var userId = '${param.userId}';//用户Id
    //查看本月的细节
    $(".month-detail").on("click", function () {
        $(this).html('<i class="am-icon-spinner am-icon-spin"></i>加载中....')
        //查看本月收益详情
        $.post("${ctx}/m/monthProfitDetail?userId=" + userId, function (ret) {
            if (ret.code == 0) {
                var str = "";
                for (var i = 0; i < ret.data.length; i++) {
                    var week = ret.data[i];
                    str += '<li class="am-panel"><a> 第' + (i + 1) + '周 <i class="am-icon-angle-right am-fr am-margin-right"></i></a><ul class="am-list am-collapse admin-sidebar-sub">';
                    for (var j = 0; j < week.length; j++) {
                        str += '<li><a><span>' + fomaterDate(week[j].profitDate) + '</span><span>' + week[j].profitMoney + '</span><span>' + week[j].incomeProportion + '</span></a></li>';
                    }
                    if (week.length < 1) {
                        str += '<li><a><span>本周无收益</span></a></li>';
                    }
                    str += " </ul></li>";
                }
                $(".admin-sidebar-list").append(str).show();
                $(".month-detail").hide();
                $(".am-panel a").on("click", function () {
                    $(this).next().collapse('toggle');
                })
            } else {
                $(".admin-sidebar-list").html(ret.msg);
            }
        })

    })
    //日期格式化
    function fomaterDate(dateNumber) {
        var date = new Date(dateNumber);
        var seperator1 = "-";
        var seperator2 = ":";
        var month = date.getMonth() + 1;//月
        var strDate = date.getDate();//日
        var hours = date.getHours();//时
        var minutes = date.getMinutes()//分
        var seconds = date.getSeconds();//秒
        var currentdate = date.getFullYear() + seperator1 + plusZero(month) + seperator1 + plusZero(strDate)
                + " " + plusZero(hours) + seperator2 + plusZero(minutes) + seperator2 + plusZero(seconds);
        return currentdate;
    }
    //如果小于10加前面加0
    function plusZero(parameter) {
        if (parameter >= 0 && parameter <= 9) {
            parameter = "0" + parameter;
        }
        return parameter;
    }
</script>
</html>
