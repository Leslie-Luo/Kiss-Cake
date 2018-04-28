<template>
  <div id="Index">
    <el-row>
      <el-col :span="24">
        <Carousel></Carousel>
      </el-col>
      <el-col :span="22" :offset="1">
        <el-col :span="24">
          <Tag></Tag>
        </el-col>
        <el-col :span="24">
          <New :newList="newList"></New>
        </el-col>
        <el-col :span="24">
          <Hot :hotList="hotList"></Hot>
        </el-col>
      </el-col>
    </el-row>
  </div>
</template>
<script>
import { getServer } from "@/assets/js/server.js";
import Carousel from "./module/Carousel";
import Tag from "./module/Tag";
import New from "./module/New";
import Hot from "./module/Hot";
export default {
  name: "Index",
  components: {
    Carousel,
    Tag,
    New,
    Hot
  },
  data() {
    return {
      newList: [],
      hotList: []
    };
  },
  mounted() {
    let server = getServer() + "BuyCake.php";
    this.$http
      .post(server, { action: "GetIndexList"}, { emulateJSON: true })
      .then(
        response => {
          if (response.body.code == "0") {
            let data = response.body;
            this.newList = data.new;
            this.hotList = data.hot;
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
  methods: {}
};
</script>
<style lang="less">
#Index{
  margin-bottom: 50px;
}
</style>
