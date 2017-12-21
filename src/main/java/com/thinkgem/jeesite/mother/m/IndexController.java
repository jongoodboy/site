package com.thinkgem.jeesite.mother.m;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.mother.admin.entity.Commodity;
import com.thinkgem.jeesite.mother.admin.entity.Express;
import com.thinkgem.jeesite.mother.admin.service.CommodityService;
import com.thinkgem.jeesite.mother.admin.service.ExpressService;
import com.thinkgem.jeesite.mother.m.entity.*;
import com.thinkgem.jeesite.mother.m.service.*;
import com.thinkgem.jeesite.mother.m.weixin.*;
import com.thinkgem.jeesite.mother.m.weixin.utlis.Sign;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 商城列表
 */
@Controller
@RequestMapping(value = "${frontPath}/m")
public class IndexController {
    //商品
    @Resource
    private CommodityService commodityService;
    //购物车
    @Resource
    private ShoppingCatService shoppingCatService;
    //订单
    @Resource
    private OrderService orderService;
    //手机用户
    @Resource
    private MuserService mUserSerivce;
    //收货地址
    @Resource
    private ReceiptAddressService addressService;
    //退款
    @Resource
    private ApplyRefundService applyRefundService;
    //收益
    @Resource
    private ProfitService profitService;
    //快递
    @Resource
    private ExpressService expressService;

    //每次请求都会先进这里
    @ModelAttribute
    public void getMuser(HttpServletRequest request, HttpServletResponse response, String personalStores) throws IOException {
        String openId = (String) request.getSession().getAttribute("openid");//微信openId
        if (openId == null) {
            String strBackUrl = "http://" + request.getServerName() //服务器地址
                    + ":"
                    + request.getServerPort()           //端口号
                    + request.getContextPath()      //项目名称
                    + request.getServletPath();     //请求页面或其他地址
            String QueryString = request.getQueryString();//参数
            if (QueryString != null) {
                strBackUrl += "?" + QueryString;
            }
            request.getSession().setAttribute("strBackUrl", strBackUrl);//为了从哪个页面来。授权之后返回哪页面去。
            if (personalStores != null) {
                request.getSession().setAttribute("personalStores", personalStores);//我要创业
            }
            response.sendRedirect(ConfigUtil.GET_CODE);//微信取code
        }
        Map<String, Object> paramMap = new HashedMap();
        paramMap.put("openId", openId);
        Muser m = mUserSerivce.findUser(paramMap);
        if (m != null && m.getPhone() != null) {
            request.getSession().setAttribute("mUser", m);//存起来
        } else {
            request.getSession().removeAttribute("mUser");//清空
        }
    }

    //手机端商城首页

    /**
     * @param request
     * @param code    分享的code
     * @return
     */
    @RequestMapping
    public String appIndex(HttpServletRequest request, String code) {
        if (code != null) {//把个人分享的code存起来方便订单支付之后把钱分成
            request.getSession().setAttribute("code", code);
        }
        return "/mqds/m/index";//首页
    }

    /**
     * //首页加载数据
     *
     * @param pageNo        当前页娄
     * @param pageSize      每页条数
     * @param type          1推荐 2热门
     * @param commodityName 商品名称(模糊查询)
     * @return
     */
    @RequestMapping("/indexData")
    @ResponseBody
    public Map<String, Object> indexData(@RequestParam(required = false, defaultValue = "0") Integer pageNo,
                                         @RequestParam(required = false, defaultValue = "10") Integer pageSize,
                                         Integer type, String commodityName) {
        Map<String, Object> returnMap = new HashedMap();
        try {
            Map<String, Object> paramMapIndex = new HashedMap();
            paramMapIndex.put("pageNo", (pageNo * pageSize));
            paramMapIndex.put("pageSize", pageSize);
            paramMapIndex.put("type", type == 1 ? "" : type);//如果是1就查所有
            paramMapIndex.put("commodityName", commodityName);
            List<Commodity> listCommodity = commodityService.findPageCommodity(paramMapIndex);//页面商品列表数据
            returnMap.put("listCommodity", listCommodity);
            if (pageNo == 0 && type == 1 && commodityName == "") {//如果是第一次加载
                Map<String, Object> paramMap = new HashedMap();
                paramMap.put("pageNo", 0);
                paramMap.put("pageSize", 4);//顶部banner
                paramMap.put("commodityState", 3);//(1.精选商品2.热门商品4.其他状态商品3.必卖商品5.菜单商品' -->)
                List<Commodity> listBanner = commodityService.findAdvertising(paramMap);
                returnMap.put("banner", listBanner);//顶部banner
                paramMap.put("pageSize", 5);//推荐精品
                paramMap.put("commodityState", 1);//(1.精选商品2.热门商品4.其他状态商品3.必卖商品5.菜单商品' -->)
                List<Commodity> listProducts = commodityService.findAdvertising(paramMap);
                returnMap.put("products", listProducts);//推荐精品
                paramMap.put("pageSize", 6);//首页6个菜单
                paramMap.put("commodityState", 5);//(1.精选商品2.热门商品4.其他状态商品3.必卖商品5.菜单商品' -->)
                List<Commodity> listIndexMenuSix = commodityService.findAdvertising(paramMap);
                returnMap.put("listIndexMenuSix", listIndexMenuSix);//首首页6个菜单
            }
            returnMap.put("msg", "数据查询成功");
            returnMap.put("code", "0");
        } catch (Exception e) {
            e.printStackTrace();
            returnMap.put("msg", "数据查询失败");
            returnMap.put("code", "-1");
        }
        return returnMap;
    }

    /**
     * 手机端商品详情页面
     *
     * @param commodityId 商品id
     * @return
     */
    @RequestMapping("/commodityDetail")
    public String commodityDetail(String commodityId, Model model) {
        //商品详情页面
        Commodity commodity = commodityService.get(commodityId);
        Express express = expressService.get(commodity.getDefaultExpress());//快递
        model.addAttribute("commodity", commodity);
        model.addAttribute("express", express);
        //商品推荐
        Commodity commodity1 = new Commodity();
        Page<Commodity> page = new Page<Commodity>(1, 6);//分页查询
        page = commodityService.findPage(page, commodity1);
        model.addAttribute("commodityList", page.getList());
        return "mqds/m/commodityDetail";
    }

    /**
     * 手机端商品详情页面AJAX
     *
     * @param commodityId 商品id
     * @return
     */
    @RequestMapping("/commodityById")
    @ResponseBody
    public Map<String, Object> commodityById(String commodityId) {
        Map<String, Object> returnMap = new HashedMap();
        //商品详情页面
        try {
            Commodity commodity = commodityService.get(commodityId);
            Express express = expressService.get(commodity.getDefaultExpress());//快递
            returnMap.put("data", commodity);
            returnMap.put("msg", "查询数据成功");
            returnMap.put("code", "0");
            returnMap.put("express", express);
        } catch (Exception e) {
            e.printStackTrace();
            returnMap.put("msg", "查询数据失败");
            returnMap.put("code", "-1");
        }
        return returnMap;
    }

    /**
     * 添加到购物车
     *
     * @return
     */
    @RequestMapping("/addShoppingCat")
    @ResponseBody
    public Map<String, Object> addShoppingCat(ShoppingCat shoppingCat) {
        Map<String, Object> returnMap = new HashedMap();
        try {
            shoppingCatService.save(shoppingCat);
            returnMap.put("code", "0");
            returnMap.put("msg", "加入购物车成功");
        } catch (Exception e) {
            returnMap.put("code", "-1");
            returnMap.put("msg", "加入购物车失败");
            e.printStackTrace();
        }
        return returnMap;
    }

    /**
     * 手机端购物车
     *
     * @param userId 个人id
     * @return
     */
    @RequestMapping("/shoppingCat")
    public String shoppingCat(Model model, String userId) {
        List<Map<String, Object>> listMap = shoppingCatService.findShoppingCatByUserId(userId);//个人购物车列表
        for (int i = 0; i < listMap.size(); i++) {
            BigDecimal expressProvinceFirst = (BigDecimal) listMap.get(i).get("expressProvinceFirst");//默认省内首重
            BigDecimal expressProvinceIncreasing = (BigDecimal) listMap.get(i).get("expressProvinceIncreasing");//默认省内递增
            BigDecimal weight = (BigDecimal) listMap.get(i).get("weight");//商品重量
            Integer shoppingNumber = (Integer) listMap.get(i).get("shoppingNumber");//购买的个数
            double d = weight.doubleValue() * shoppingNumber;//总重量
            if (d <= 1.0) {//1gk以内
                listMap.get(i).put("freight", expressProvinceFirst);
            } else if (d > 1) {//大于1gk
                int y = (int) d;
                listMap.get(i).put("freight", expressProvinceFirst.add(BigDecimal.valueOf(y * expressProvinceIncreasing.intValue())));//首重加上超出的部份每超出1gk+递增
            }
        }
        model.addAttribute("listMap", listMap);
        //商品推荐
        Commodity commodity = new Commodity();
        Page<Commodity> page = new Page<Commodity>(1, 6);//分页查询
        page = commodityService.findPage(page, commodity);
        model.addAttribute("commodityList", page.getList());
        return "mqds/m/shoppingCat";
    }

    /**
     * 手机端订单生成页面
     *
     * @param userId 个人id
     * @return
     */
    @RequestMapping("/orderPage")
    public String orderPage(Model model, String userId) {
        try {
            ReceiptAddress address = addressService.findAddressByUserId(userId);//个人默认收货地址
            //List<Express> list = expressService.findList(new Express());//快递列表
            model.addAttribute("address", address);
            //model.addAttribute("expressList",list);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "mqds/m/orderPage";
    }

    /**
     * 手机端订单详情页面
     *
     * @return
     */
    @RequestMapping("/orderDetail")
    public String orderDetail(String orderNumber, Model model) {
        try {
            Map<String, Object> listMap = orderService.findOrderDetailByOrderNumber(orderNumber);
            model.addAttribute("listMap", listMap);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "mqds/m/orderDetail";
    }

    /**
     * 手机端所有订单页面
     *
     * @return
     */
    @RequestMapping("/orderList")
    public String orderList() {
        return "mqds/m/orderList";
    }

    /**
     * 手机端所有订单页面数据请求
     *
     * @param orderState 订单状态
     * @param pageNo     当前页数
     * @param pageSize   每页显示条数
     * @param userId     用户id
     * @return
     */
    @RequestMapping("/orderListDate")
    @ResponseBody
    public Map<String, Object> orderListData(Integer orderState,
                                             @RequestParam(required = false, defaultValue = "0") Integer pageNo,
                                             @RequestParam(required = false, defaultValue = "10") Integer pageSize, String userId) {
        Map<String, Object> returnMap = new HashedMap();
        Map<String, Object> paramMap = new HashedMap();
        paramMap.put("pageNo", pageNo);
        paramMap.put("pageSize", pageSize);
        paramMap.put("userId", userId);
        paramMap.put("orderState", orderState);// (0已完成,1待付款,2.待发货,3已发货,4退款中,5已退款)
        try {
            List<Map<String, Object>> list = orderService.findOrderList(paramMap);
            returnMap.put("msg", "订单查询成功");
            returnMap.put("code", "0");
            returnMap.put("data", list);
        } catch (Exception e) {
            returnMap.put("msg", "订单查询失败");
            returnMap.put("code", "-1");
            e.printStackTrace();
        }
        return returnMap;
    }

    /**
     * 手机端成生订单方法
     *
     * @param commodityId    商品id 多个用","分割
     * @param buyNumber      每个商品购买的数量多个用","分割
     * @param commodityPrice 每个商品单价多个用","分割
     * @param address        收货地址
     * @param userId         个人Id
     * @return
     */
    @RequestMapping("/saveOrder")
    @ResponseBody
    public Map<String, Object> saveOrder(HttpServletRequest request, String commodityId, String buyNumber,
                                         String commodityPrice, String address,
                                         String consignee, String consigneePhone, String userId, String expressName) {
        List<Order> list = new ArrayList<Order>();
        Map<String, Object> returnMap = new HashedMap();
        Map<String, Object> map = new HashedMap();
        Date d = new Date();
        String shareCode = (String) request.getSession().getAttribute("code");//分享人的分享码
        SimpleDateFormat foramt = new SimpleDateFormat("yyyMMddHHmmss");
        String orderNumber = new Date().getTime() + "";//生成订单号
        String[] commodityIdList = commodityId.split(",");//截取每一个商品id
        String[] buyNumberList = buyNumber.split(",");//截取每一个商品id对应购买的数量
        String[] commodityPriceList = commodityPrice.split(",");//截取每一个商品id对应购买的数量
        String[] expressNameList = expressName.split(",");//截取每一家快递
        List<Object> listt = new ArrayList<Object>();
        for (int i = 1; i < commodityIdList.length; i++) {//购物车购买
            Order order = new Order();
            order.setUserId(userId);
            order.setId(IdGen.uuid());//设置id
            order.setCommodityId(commodityIdList[i]);//设置商品id
            listt.add(commodityIdList[i]);//用于清空购物车
            order.setCommodityNumber(Integer.parseInt(buyNumberList[i]));//设置商品购买的数量
            BigDecimal price = new BigDecimal(commodityPriceList[i]);
            order.setCommodityPrice(price);//设置商品购买的单价
            order.setOrderState("1");//待付款
            order.setAddress(address);
            order.setConsignee(consignee);
            order.setConsigneePhone(consigneePhone);
            order.setOrderNumber(orderNumber);
            order.setExpress(expressNameList[i]);
            order.setCreateDate(d);
            order.setShareCode(shareCode);
            list.add(order);//用于生成订单
        }
        try {
            if (list.size() < 1) {//商品详情立即购买
                Order order = new Order();
                order.setUserId(userId);
                order.setId(IdGen.uuid());//设置id
                order.setCommodityId(commodityId);//设置商品id
                order.setCommodityNumber(Integer.parseInt(buyNumber));//设置商品购买的数量
                BigDecimal price = new BigDecimal(commodityPrice);
                order.setCommodityPrice(price);//设置商品购买的单价
                order.setOrderState("1");//待付款
                order.setAddress(address);
                order.setExpress(expressName);
                order.setConsignee(consignee);
                order.setConsigneePhone(consigneePhone);
                order.setOrderNumber(orderNumber);
                order.setShareCode(shareCode);
                order.setCreateDate(d);
                list.add(order);//用于生成订单
            } else {
                map.put("commodityList", listt);
                map.put("userId", userId);
                map.put("update", d);
                shoppingCatService.delShoppingCatByCommodityId(map);//标记删除购物车
            }
            orderService.addList(list);//生成订单
            returnMap.put("msg", "生成订单成功");
            returnMap.put("code", "0");
            returnMap.put("orderNumber", orderNumber);//订单号
        } catch (Exception e) {
            returnMap.put("msg", "生成订单失败");
            returnMap.put("code", "-1");
            e.printStackTrace();
        }
        return returnMap;
    }

    /**
     * 支付页面
     *
     * @param orderNumber 订单号
     * @param orderBody   订单描述或商品名称
     * @param payMoney    支付金额
     * @return
     */
    @RequestMapping("/payPage")
    public String payPage(Model m, String orderBody, String payMoney, String orderNumber, HttpServletRequest request) {
      /*  String openid = (String) request.getSession().getAttribute("openid");//微信用户openId*/
        Muser muser = (Muser) request.getSession().getAttribute("mUser");//微信用户openId
        String openid = muser.getOpenId();
        m.addAttribute("openid", openid);
        m.addAttribute("orderNo", orderNumber);
        String timeStamp = PayCommonUtil.create_timestamp();
        String nonceStr = PayCommonUtil.create_nonce_str();
        m.addAttribute("appid", ConfigUtil.APPID);
        m.addAttribute("timestamp", timeStamp);
        m.addAttribute("nonceStr", nonceStr);
        m.addAttribute("openid", openid);
        //微信支付的金额单位为分。所以这里要*100
        int price = (int) (Float.parseFloat(payMoney) * 100);
        String prepayId = WxPayUtil.unifiedorder(orderBody, orderNumber, openid, price);
        SortedMap<Object, Object> signParams = new TreeMap<Object, Object>();
        signParams.put("appId", ConfigUtil.APPID);
        signParams.put("nonceStr", nonceStr);
        signParams.put("package", "prepay_id=" + prepayId);
        signParams.put("timeStamp", timeStamp);
        signParams.put("signType", "MD5");
        // 生成支付签名，要采用URLENCODER的原始值进行SHA1算法！
        String sign = PayCommonUtil.createSign(signParams);
        m.addAttribute("paySign", sign);
        m.addAttribute("packageValue", "prepay_id=" + prepayId);
        return "mqds/m/payPage";
    }

    /**
     * 支付回调收到后,告诉微信不要再发起支付了
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/payCallBack")
    public void payCallBack(HttpServletRequest request,
                            HttpServletResponse response) throws IOException {
        String retInfo = PayCommonUtil.setXML("SUCCESS", "OK");
        response.getWriter().write(retInfo);
    }

    /**
     * 支付成功后改订单回已支付 如果是必卖商品购买的人变成会员
     *
     * @param orderNumber
     * @return
     */
    @RequestMapping("updateOrderState")
    @ResponseBody
    public Map<String, Object> updateOrderState(String orderNumber, String state, String isVIP, HttpServletRequest request) {
        Map<String, Object> returnMap = new HashedMap();

        try {
            Map<String, Object> paramMap = new HashedMap();
            paramMap.put("orderNumber", orderNumber);
            paramMap.put("orderState", state);
            paramMap.put("updateDate", new Date());
            paramMap.put("code", request.getSession().getAttribute("code"));//分享码
            paramMap.put("isVIP", isVIP);//会员状态0是1不是
            orderService.updateOrderState(paramMap);//(0已完成,1待付款,2.待发货,3已发货,4退款中,5已退款)
            returnMap.put("code", "0");
            returnMap.put("msg", "修改订单成功");
        } catch (Exception e) {
            returnMap.put("code", "-1");
            returnMap.put("msg", "修改订单失败");
            e.printStackTrace();
        }
        return returnMap;
    }

    /**
     * 确认收货
     *
     * @return
     */
    @RequestMapping("confirmReceipt")
    @ResponseBody
    public Map<String, Object> confirmReceipt(String orderId) {
        Map<String, Object> returnMap = new HashedMap();

        try {
            Map<String, Object> paramMap = new HashedMap();
            paramMap.put("orderId", orderId);
            paramMap.put("orderState", "0");//订单对应的商品已完成交易
            paramMap.put("updateDate", new Date());
            orderService.confirmReceipt(paramMap);//(0已完成,1待付款,2.待发货,3已发货,4退款中,5已退款)
            returnMap.put("code", "0");
            returnMap.put("msg", "确认收货成功!");
        } catch (Exception e) {
            returnMap.put("code", "-1");
            returnMap.put("msg", "确认收货失败!");
            e.printStackTrace();
        }
        return returnMap;
    }

    /**
     * 手机端个人中心
     *
     * @return
     */
    @RequestMapping("/personalCenter")
    public String personalCenter() {
        return "mqds/m/personalCenter";
    }

    /**
     * 手机端个人收货地址列表
     *
     * @param userId 个人id
     * @return
     */
    @RequestMapping("/addressList")
    public String addressList(String userId, Model model) {
        try {
            List<ReceiptAddress> list = addressService.findListfByUserId(userId);
            model.addAttribute("list", list);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "mqds/m/addressList";
    }

    /**
     * 手机端修改个人默认收货地址
     *
     * @param userId 个人id
     * @return
     */
    @RequestMapping("/checkedDefault")
    @ResponseBody
    public Map<String, Object> checkedDefault(String userId, String adddressId) {
        Map<String, Object> returnMap = new HashedMap();
        Map<String, Object> prarmMap = new HashedMap();
        try {
            prarmMap.put("userId", userId);//用户Id
            prarmMap.put("id", adddressId);//地址Id
            prarmMap.put("updateDate", new Date());
            addressService.updateDefault(prarmMap);
            returnMap.put("msg", "修改默认地址成功");
            returnMap.put("code", "0");
        } catch (Exception e) {
            returnMap.put("msg", "修改默认地址失败");
            returnMap.put("code", "-1");
            e.printStackTrace();
        }
        return returnMap;
    }

    /**
     * 手机端删除收货地址
     *
     * @return
     */
    @RequestMapping("/delAddress")
    @ResponseBody
    public Map<String, Object> delAddress(String adddressId) {
        Map<String, Object> returnMap = new HashedMap();
        try {
            addressService.delDelAddress(adddressId);
            returnMap.put("msg", "删除地址成功");
            returnMap.put("code", "0");
        } catch (Exception e) {
            returnMap.put("msg", "删除地址失败");
            returnMap.put("code", "-1");
            e.printStackTrace();
        }
        return returnMap;
    }

    /**
     * 手机端修改收货地址详情
     *
     * @return
     */
    @RequestMapping("/addressDetail")
    @ResponseBody
    public Map<String, Object> addressDetail(String adddressId) {
        Map<String, Object> returnMap = new HashedMap();
        try {
            ReceiptAddress receiptAddress = addressService.findListfById(adddressId);
            returnMap.put("msg", "查询成功");
            returnMap.put("code", "0");
            returnMap.put("data", receiptAddress);
        } catch (Exception e) {
            returnMap.put("msg", "查询失败");
            returnMap.put("code", "-1");
            e.printStackTrace();
        }
        return returnMap;
    }

    /**
     * 手机端添加收货地址
     *
     * @param userId 个人id
     * @return
     */
    @RequestMapping("/saveAddress")
    @ResponseBody
    public Map<String, Object> saveAddress(ReceiptAddress receiptAddress, String userId) {
        Map<String, Object> returnMap = new HashedMap();
        receiptAddress.setUserId(userId);
        try {
            addressService.save(receiptAddress);
            returnMap.put("msg", "添加地址成功");
            returnMap.put("code", "0");
        } catch (Exception e) {
            returnMap.put("msg", "添加地址失败");
            returnMap.put("code", "-1");
            e.printStackTrace();
        }
        return returnMap;
    }

    /**
     * 申请退款
     *
     * @return
     */
    @RequestMapping("/applyFund")
    @ResponseBody
    public Map<String, Object> applyFund(ApplyRefund applyRefund) {
        Map<String, Object> returnMap = new HashedMap();
        try {
            applyRefundService.save(applyRefund);
            Map<String, Object> paramMap = new HashedMap();
            paramMap.put("id", applyRefund.getApplyOrderId());//订单ID
            paramMap.put("orderState", "4");//(0已完成,1待付款,2.待发货,3已发货,4退款中,5已退款)
            orderService.updateRefund(paramMap);//
            returnMap.put("msg", "申请成功");
            returnMap.put("code", "0");
        } catch (Exception e) {
            e.printStackTrace();
            returnMap.put("msg", "申请失败");
            returnMap.put("code", "-1");
        }
        return returnMap;
    }

    /**
     * 手机端银行卡列表
     *
     * @return
     */
    @RequestMapping("/bindBankCard")
    public String bindBankCard() {
        return "mqds/m/bindBankCard";
    }

    /**
     * 手机端系统设置
     *
     * @return
     */
    @RequestMapping("/systemSettings")
    public String systemSettings() {
        return "mqds/m/systemSettings";
    }

    //登录页面
    @RequestMapping("/loginPage")
    public String login() {
        return "mqds/m/login";
    }

    //绑定手机号页面
    @RequestMapping("/bindPhone")
    public String bindPhone() {
        return "mqds/m/bindPhone";
    }

    /**
     * 绑定手机号
     *
     * @param phoneCode 验证码
     * @return
     */
    @RequestMapping("/bind")
    @ResponseBody
    public Map<String, Object> bindPhone(String phone, String phoneCode, HttpServletRequest request) {
        Map<String, Object> returnMap = new HashedMap();
        try {
            Muser muser = new Muser();
            String code = "MQY" + new Date().getTime();//生成个人分享码
            String openId = (String) request.getSession().getAttribute("openid");//微信openId
            muser.setOpenId(openId);
            muser.setCode(code);
            muser.setPhone(phone);//绑定的手机号
            muser.setIsVip("1");//默认不是会员
            mUserSerivce.save(muser);//保存用户信息
            returnMap.put("code", "0");
            returnMap.put("msg", "绑定成功");
        } catch (Exception e) {
            e.printStackTrace();
            returnMap.put("code", "-1");
            returnMap.put("msg", "绑定失败");
        }
        return returnMap;
    }

    /**
     * 验证手机号是否已经被绑定过
     *
     * @param phone 手机号
     * @return
     */
    @RequestMapping("/verification")
    @ResponseBody
    public Map<String, Object> verification(String phone) {
        Map<String, Object> returnMap = new HashedMap();
        try {
            Muser m = mUserSerivce.verification(phone);//验证手机号是否已经被绑定过
            if (m != null) {
                returnMap.put("code", "0");
                returnMap.put("msg", "该号码已经被绑定过");
            } else {
                returnMap.put("code", "1");
                returnMap.put("msg", "该号码可用");
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnMap.put("code", "-1");
            returnMap.put("msg", "验证出错");
        }
        return returnMap;
    }

    /**
     * 手机端注销
     *
     * @return
     */
    @RequestMapping("/loginOut")
    @ResponseBody
    public Map<String, Object> loginOut(String userId) {
        Map<String, Object> returnMap = new HashedMap();
        Map<String, Object> paramMap = new HashedMap();
        paramMap.put("userId", userId);
        paramMap.put("login", "no");
        try {
            mUserSerivce.loginOutOrLogin(paramMap);
            returnMap.put("code", "0");
            returnMap.put("msg", "注销成功");
        } catch (Exception e) {
            e.printStackTrace();
            returnMap.put("code", "-1");
            returnMap.put("msg", "注销失败");
        }
        return returnMap;
    }

    /**
     * 手机端登录 手机获取验证码或微信登录
     *
     * @return
     */
    @RequestMapping("/login")
    @ResponseBody
    public Map<String, Object> login(String userId) {
        Map<String, Object> returnMap = new HashedMap();
        Map<String, Object> paramMap = new HashedMap();
        paramMap.put("userId", userId);
        paramMap.put("login", "yes");
        mUserSerivce.loginOutOrLogin(paramMap);
        returnMap.put("code", "0");
        returnMap.put("msg", "登录成功");
        return returnMap;
    }

    /**
     * 获取微信分享配置
     *
     * @param url
     * @return
     */
    @RequestMapping("/getWxConfig")
    @ResponseBody
    public Map<String, String> getWXConfig(String url) {
        return Sign.sign(url);
    }

    /**
     * 我的店铺收益/我要创业
     *
     * @return
     */
    @RequestMapping("/personalStores")
    public String personalStores(Model model, HttpServletRequest request) {
        Muser m = (Muser) request.getSession().getAttribute("mUser");
        if (m == null || m.getLogin().equals("no")) {
            model.addAttribute("url", "personalStores");
            return "mqds/m/login";
        } else {
            if (m == null || m.getIsVip().equals("1")) {
                Map<String, Object> listBannerparamMap = new HashedMap();
                listBannerparamMap.put("pageNo", 0);
                listBannerparamMap.put("pageSize", 4);//顶部banner
                listBannerparamMap.put("commodityState", 3);//(1.精选商品2.热门商品4.其他状态商品3.必卖商品' -->)
                List<Commodity> listBanner = commodityService.findAdvertising(listBannerparamMap);
                model.addAttribute("listBanner", listBanner);
                return "mqds/m/personalStoresVIP";
            } else {
                Date dateProfit = new Date();
                SimpleDateFormat toDateFormat = new SimpleDateFormat("yyyy-MM-dd");//今日收益
                String toDateProfit = toDateFormat.format(dateProfit);
                SimpleDateFormat toMonthFormat = new SimpleDateFormat("yyyy-MM");//当月收益
                String toMonthProfit = toMonthFormat.format(dateProfit);
                Map<String, Object> paramMap = new HashedMap();
                paramMap.put("toDateProfit", toDateProfit);
                paramMap.put("toMonthFormat", toMonthProfit);
                paramMap.put("userId", m.getId());//当前用户Id
                List<Map<String, Object>> listMap = profitService.findProfit(paramMap);
                model.addAttribute("toDateProfit", listMap.get(0) == null ? "0.00" : listMap.get(0).get("money"));//今日收益
                model.addAttribute("team", listMap.get(1) == null ? "0.00" : listMap.get(1).get("money"));//团队收益
                model.addAttribute("shop", listMap.get(2) == null ? "0.00" : listMap.get(2).get("money"));//开店收益
                model.addAttribute("week1", listMap.get(3) == null ? "0.00" : listMap.get(3).get("money"));//第一周的收益
                model.addAttribute("week2", listMap.get(4) == null ? "0.00" : listMap.get(4).get("money"));//第二周的收益
                model.addAttribute("week3", listMap.get(5) == null ? "0.00" : listMap.get(5).get("money"));//第三周的收益
                model.addAttribute("week4", listMap.get(6) == null ? "0.00" : listMap.get(6).get("money"));//第四周的收益
                model.addAttribute("week5", listMap.get(7) == null ? "0.00" : listMap.get(7).get("money"));//第五周的收益
                return "mqds/m/personalStores";
            }
        }
    }

    /**
     * 我要创业 如果不是会员指一个会员商品
     *
     * @return
     */
    @RequestMapping("/personalStoresVIP")
    public String personalStoresVIP(Model model) {
        Map<String, Object> paramMap = new HashedMap();
        paramMap.put("pageNo", 0);
        paramMap.put("pageSize", 4);//顶部banner
        paramMap.put("commodityState", 3);//(1.精选商品2.热门商品4.其他状态商品3.必卖商品' -->)
        List<Commodity> listBanner = commodityService.findAdvertising(paramMap);
        model.addAttribute("listBanner", listBanner);
        return "mqds/m/personalStoresVIP";
    }

    /**
     * 我的店铺
     *
     * @return
     */
    @RequestMapping("/userShop")
    public String userShop(HttpServletRequest request, String code, String shopName, String shopImgUrl) {
        if (code != null) {//把个人分享的code存起来方便订单支付之后把钱分成
            request.getSession().setAttribute("code", code);
            request.getSession().setAttribute("shopName", shopName);
            request.getSession().setAttribute("shopImgUrl", shopImgUrl);
        }
        return "mqds/m/userShop";
    }

    /**
     * 我的店铺本月收益详情
     *
     * @param userId 当前用户Id
     * @return
     */
    @RequestMapping("/monthProfitDetail")
    @ResponseBody
    public Map<String, Object> monthProfitDetail(String userId) {
        Map<String, Object> retMap = new HashedMap();
        try {
            retMap.put("data", profitService.monthProfitDetail(userId));
            retMap.put("code", "0");
            retMap.put("msg", "查询成功");
        } catch (Exception e) {
            e.printStackTrace();
            retMap.put("code", "-1");
            retMap.put("msg", "查询失败");
        }
        return retMap;
    }
}
