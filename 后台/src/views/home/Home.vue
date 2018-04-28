<template>
  <el-container v-if="this.loading">
    <el-aside width="200px">
      <Menu></Menu>
    </el-aside>
    <el-container>
      <el-header>
        <Header @ShowModify="ShowModify"></Header>
      </el-header>
      <el-main>
        <keep-alive include='OrderList,CakeList,Main,Member'>
          <router-view></router-view>
        </keep-alive>
        <Modify ref="ShowModify"></Modify>
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
import Menu from "./components/Menu.vue";
import Header from "./components/Header.vue";
import Modify from "./components/Modify.vue";
export default {
  name: "Home",
  components: {
    Menu,
    Header,
    Modify
  },
  data() {
    return {
      loading: false
    };
  },
  mounted() {
    let username = localStorage.getItem("Adminname");
    if (!username || username == "" || username == null) {
      this.$router.push("/login");
    } else {
      this.loading = true;
    }
  },
  methods: {
    ShowModify() {
      this.$refs.ShowModify.ShowModify();
    }
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="less" scoped>
.el-container {
  height: 100vh;
  .el-aside {
    border-right: 2px solid #eee;
    background-color: #ffffff;
  }
  .el-header {
    background-color: #ffffff;
  }
  .el-main {
    background-color: #eee;
  }
}
</style>
