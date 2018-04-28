<template>
  <div class="header">
    <el-breadcrumb separator="/">
      <el-breadcrumb-item v-for="item in this.$route.meta" :key="item.path" :to="{ path: item.path }">{{item.title}}</el-breadcrumb-item>
    </el-breadcrumb>
    <div class="user-info">
      <el-dropdown @command="handleCommand">
        <span class="user-info-name el-dropdown-link">
          {{this.username}}
          <i class="el-icon-arrow-down el-icon--right"></i>
        </span>
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item command="changePW">修改密码</el-dropdown-item>
          <el-dropdown-item command="loginOut">退出登录</el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
    </div>
  </div>
</template>
<script>
export default {
  name: "Header",
  data() {
    return {
      username: ""
    };
  },
  mounted() {
    this.username = localStorage.getItem("Adminname");
  },
  methods: {
    handleCommand(command) {
      if (command == "loginOut") {
        this.loginOut();
      }
      if (command == "changePW") {
       this.$emit("ShowModify");
      }
    },
    loginOut() {
      localStorage.clear();
      this.$router.push("/login");
    }
  }
};
</script>

<style lang="less">
@left: left;
@line-height: 60px;
@margin: 0 5px;
.header {
  .el-breadcrumb {
    line-height: @line-height;
    width: 50%;
    float: left;
    font-weight: 400;
  }
  .user-info {
    float: right;
    height: @line-height;
    .user-info-name {
      font-size: 20px;
      line-height: @line-height;
      float: @left;
      margin: @margin;
    }
    .loginout {
      line-height: @line-height;
      float: @left;
      margin: @margin;
    }
  }
}
</style>

