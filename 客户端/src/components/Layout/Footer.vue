<template>
  <div class="footer">
    <img class="footer-logo" src="../../assets/images/logo/Footer-Logo.png" height="36" width="96" alt="">
    <div class="footer-text">
      <span>订购专线：400 650 2121（服务时间 08:00–22:00）</span>
      <span>客服电话：021-23099721（全国） | kefu@21cake.com（邮箱）</span>
      <span>杭州/广州：提前5小时预订；北京：提前6小时预订；上海：提前6-8小时预订；天津/苏州/无锡/深圳：提前8小时预订（当日22点以后订单，于次日8点开始审核） </span>
      <span>当日蛋糕配送截止下单时间：北京：16:50；上海：16:30；杭州/广州：13:50；天津：10:30；苏州/无锡/深圳：11:00</span>
      <span>网站注册公司名称: Kiss Cake食品有限公司</span>
    </div>
    <div class="footer-copyright">
        <span>Copyright© Kiss Cake蛋糕官网商城 2007-2018, 版权所有 京ICP备14106254号-1</span>
    </div>
  </div>
</template>
<script>
export default {
  name: "Footer",
  mounted() {},
  data() {
    return {};
  },
  methods: {}
};
</script>
<style lang="less">
.footer {
  width: 100vw;
  background: #333;
  padding: 25px 0 0 0;
  position: absolute;
  left: 0;
  text-align: center;
  .footer-text {
    text-align: center;
    margin-top: 25px;
    span {
      line-height: 18px;
      font-size: 10px;
      color: #9a9a9a;
      display: block;
    }
  }
  .footer-copyright {
    margin: 0 auto;
    border-top: 1px solid #616161;
    margin-top: 15px;
    text-align: center;
    padding-bottom: 15px;
    font-size: 10px;
    padding-top: 12px;
    span {
    color: #9a9a9a;
    line-height: 1.5em;
}
}
}
</style>
