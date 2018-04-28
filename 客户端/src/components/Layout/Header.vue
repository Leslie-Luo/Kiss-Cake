<template>
  <div class="header">
    <div class="logo" @click="ToHome()"><img src="../../assets/images/logo/Kiss Cake.png" alt=""></div>
    <el-menu :router="true" :default-active="activeIndex" text-color="#684029" active-text-color="#684029" class="menubar" mode="horizontal" @select="handleSelect">
      <el-menu-item index="/">首页</el-menu-item>
      <el-menu-item index="/Flavor">分类</el-menu-item>
    </el-menu>
    <div class="usermenubar">
      <div v-show="!this.$store.state.user.show" class="Sign">
        <p>
          <a href="javascript:void(0);" @click="Sign('signIn')">登录</a>/
          <a href="javascript:void(0);" @click="Sign('signUp')">注册</a>
        </p>
      </div>
      <div v-show="this.$store.state.user.show" class="User">
        <el-dropdown @command="header">
          <span class="el-dropdown-link">
            <img src="./../../assets/images/icon/user-img.png" alt="Kiss Cake user icon">
          </span>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item command="User">用户中心</el-dropdown-item>
            <el-dropdown-item command="Order">订单管理</el-dropdown-item>
            <el-dropdown-item command="SignOut">退出登录</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </div>
      <div class="Shop">
        <a @click="ShopCard()" href="#" class="cart">
          <span v-if="this.numshow()">{{this.$store.state.user.buynum}}</span>
        </a>
      </div>
    </div>
  </div>
</template>
<script>
import { user } from "vuex";
import router from "@/router";
export default {
  name: "Header",
  data() {
    return {
      user: "",
      activeIndex: "1",
      activeIndex2: "1"
    };
  },
  beforeMount() {
    this.user = localStorage.getItem("username");
    if (this.user == null) {
      this.$store.state.user.show = false;
    } else {
      this.$store.state.user.show = true;
    }
  },
  mounted() {},
  methods: {
    numshow() {
      if (this.$store.state.user.buynum) {
        if (this.$store.state.user.buynum == "0") {
          if (localStorage.getItem("shoplist")) {
            this.$store.state.user.buynum = JSON.parse(
              localStorage.getItem("shoplist")
            ).length;
            return true;
          } else {
            return false;
          }
        } else {
          return true;
        }
      } else {
        if (localStorage.getItem("shoplist")) {
          if (JSON.parse(localStorage.getItem("shoplist")).length) {
            this.$store.state.user.buynum = JSON.parse(
              localStorage.getItem("shoplist")
            ).length;
            return true;
          }
          return false;
        }
        return false;
      }
    },
    show() {
      let user = localStorage.getItem("username");
      if (user == null) {
        return false;
      } else {
        return true;
      }
    },
    handleSelect(key, keyPath) {},
    Sign: function(type) {
      this.$router.push({ name: "登录/注册", params: { type: type } });
    },
    ShopCard: function() {
      this.$router.push({ name: "购物车" });
    },
    header(command) {
      if (command == "SignOut") {
        this.SignOut();
      }
      if (command == "User") {
        this.User();
      }
      if (command == "Order") {
        this.$router.push({ name: "用户中心", params: { type: 'Order' } });
      }
    },
    SignOut() {
      localStorage.clear();
      this.$store.state.user.show = false;
      this.$router.push({ name: "Kiss-Cake" });
    },
    User() {
      this.$router.push({ name: "用户中心" });
    },
    ToHome(){
      this.$router.push({ name: "Kiss-Cake" });
    }
  }
};
</script>
<style lang="less">
.header {
  margin: 0 auto;
  max-width: 1200px;
  min-width: 760px;
  height: 80px;
  .logo {
    width: 120px;
    height: 80px;
    float: left;
    margin-right: 20px;
    cursor: pointer;
    img {
      width: 100%;
      margin: 18px 0 0 0;
      vertical-align: middle;
    }
  }
  .menubar {
    margin-top: 10px;
    border-bottom: none;
    float: left;
    .el-menu-item {
      padding: 0 15px;
      border-bottom: none !important;
      li {
        font-size: 15px;
      }
    }
    .is-active {
      border-bottom: none !important;
    }
  }
  .usermenubar {
    height: 80px;
    float: right;
    font-size: 14px;
    line-height: 80px;
    white-space: nowrap;
    span {
      color: #684029;
    }
    .Sign {
      float: left;
      a {
        text-decoration: none;
        color: #684029;
      }
    }
    .Shop {
      float: right;
      margin-left: 10px;
      .cart {
        position: relative;
        padding-right: 6px;
        padding-left: 15px;
        background: url("../../assets/images/icon/icon.png") no-repeat;
        background-position: -286px -76px;
        background-size: 310px 120px;
        height: 18px;
        margin-top: 9px;
        position: relative;
        span {
          position: absolute;
          display: block;
          height: 12px;
          padding: 0 1px;
          min-width: 10px;
          top: 21px;
          left: 5px;
          background: #ba9978;
          text-align: center;
          line-height: 12px;
          color: #fff;
          margin-left: 6px;
          margin-top: -25px;
          font-size: 10px;
          border-radius: 10px;
        }
      }
    }
    .User {
      float: left;
      margin: 4px 10px 0px 10px;
    }
  }
}
</style>

