<template>
  <el-carousel :interval="3800" arrow="never" height="500px">
    <el-carousel-item v-for="item in bannerList" :key="item.key">
      <img @click="Go(item.cakeID)" :src="server + item.image" :alt="item.name" style="width:100%; height；auto; cursor: pointer;">
    </el-carousel-item>
  </el-carousel>
</template>
<script>
import { getServer } from "@/assets/js/server.js";
export default {
  name: "Carousel",
  data() {
    return {
      bannerList: []
    };
  },
  created: function() {
    this.server = getServer();
    let server = getServer() + "select.php";
    this.$http
      .post(server, { action: "getBanner"}, { emulateJSON: true })
      .then(
        response => {
          if (response.body.code == "0") {
            let data = response.body;
            this.bannerList = data.bannerList;
          } else {
            this.$notify.error({
              title: "错误",
              message: data.msg
            });
          }
        },
        response => {}
      );
  },
  methods: {
    Go(id){
      this.$router.push({ name: "Kiss Cake-商品详情", params: { id: id } });
    }
  }
};
</script>

<style>
.el-carousel__item:nth-child(2n) {
  background-color: #99a9bf;
}

.el-carousel__item:nth-child(2n + 1) {
  background-color: #d3dce6;
}
</style>