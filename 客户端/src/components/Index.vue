<template>
    <el-container>
        <el-header>
            <Header></Header>
        </el-header>
        <el-main>
            <router-view></router-view>
        </el-main>
        <el-footer>
            <Footer></Footer>
        </el-footer>
    </el-container>
</template>
<script>
import Header from "./Layout/Header.vue";
import Footer from "./Layout/Footer.vue";
export default {
  name: "index",
  components: {
    Header,
    Footer
  },
  mounted() {
    document.title = this.$route.name;
  },
  data() {
    return {
      activeIndex: "1",
      activeIndex2: "1"
    };
  },
  methods: {
    handleSelect(key, keyPath) {}
  }
};
</script>
<style>
.el-header {
  padding: 0px;
  height: 80px !important;
  width: 100%;
  background: #fff;
  box-shadow: 0px 2px 2px 0px rgba(195, 195, 195, 0.5);
  position: fixed;
  left: 0;
  top: 0;
  z-index: 1500;
}
.el-main {
  padding: 0 !important;
  min-height: calc(100vh - 80px);
  margin: 0 auto;
  width: 1200px;
  margin-top: 80px;
  overflow: hidden;
}
</style>
