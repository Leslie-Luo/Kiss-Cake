<template>
  <el-menu :default-active="this.$route.name" :unique-opened="true" @select="SelectMenu" ref="menu" class="el-menu-vertical-demo" background-color="#FFFFFF" text-color="#909399" active-text-color="#bb9772" router>
    <div class="logo">
      <div class="logo-img">
        <img src="../../../assets/KissCake.png" alt="KissCake" height="100%">
      </div>
    </div>
    <el-menu-item index="/home">
      <i class="fa fa-home" aria-hidden="true"></i>
      <span slot="title">首页</span>
    </el-menu-item>
    <el-submenu index="cake" v-if="this.admin=='Surper'">
      <template slot="title">
        <i class="fa fa-list" aria-hidden="true"></i>
        <span>商品管理</span>
      </template>
      <el-menu-item-group>
        <el-menu-item index="/home/cakelist">商品列表</el-menu-item>
        <el-menu-item index="/home/addcake">添加商品</el-menu-item>
        <el-menu-item index="/home/modify/null">修改商品</el-menu-item>
        <el-menu-item index="/home/carousel">轮播管理</el-menu-item>
      </el-menu-item-group>
    </el-submenu>
    <el-menu-item index="/home/order/">
      <i class="el-icon-menu"></i>
      <span slot="title">订单管理</span>
    </el-menu-item>
    <el-menu-item index="/home/member/">
      <i class="el-icon-setting"></i>
      <span slot="title">会员列表</span>
    </el-menu-item>
    <el-menu-item v-if="this.admin=='Surper'" index="/home/adminlist/">
      <i class="fa fa-superpowers" aria-hidden="true"></i>
      <span slot="title">管理员列表</span>
    </el-menu-item>
  </el-menu>
</template>

<script>
export default {
  name: "Menu",
  data() {
    return {
      admin: ""
    };
  },
  created: function() {
    this.admin = localStorage.getItem("admintype");
  },
  methods: {
    SelectMenu(index, indexPath) {
      if (indexPath.length < 2) {
        this.$refs.menu.close("cake");
      }
    }
  }
};
</script>

<style lang="less" scoped>
.el-menu {
  border-right: none;
  .logo {
    height: 60px;
    .logo-img {
      width: 80%;
      height: 50px;
      margin: 5px 0 0 10%;
      text-align: center;
    }
  }
}
</style>

