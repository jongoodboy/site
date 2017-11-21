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

    .header {
        padding-top: 20%;
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
            <span>${team + shop + toDateProfit}</span>
        </li>
    </ul>
</div>
<div class="am-list-news-bd">
    <span class="the-month-title span">月收益</span>
    <span class="the-month-money span">0.00</span>
    <div id="main" style="width: 100%;height:50%;"></div>
    <span class="span">查看更多></span>
</div>
<div class="am-list-news-bd">
    <span>订单中心</span>
    <ul class="am-navbar-nav am-cf am-avg-sm-4">
        <li class="all">
            <a href="javascript:findData('')" class="">
                <span>全部订单</span>
            </a>
        </li>
        <li>
            <a href="javascript:findData(1)" class="">
                <span>待发货</span>
            </a>
        </li>
        <li class="shipment">
            <a href="javascript:findData(2)" class="">
                <span>待发货</span>
            </a>
        </li>
        <li class="receipt">
            <a href="javascript:findData(3)" class="">
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
            data: ['销量']
        },
        xAxis: {
            data: ["第一周", "第二周", "第三周", "第四周", "第五周"]
        },
        yAxis: {},
        series: [{
            name: '销量',
            type: 'bar',
            data: ['${week1}', '${week2}', '${week3}', '${week4}', '${week5}']
        }]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
</script>
</html>
