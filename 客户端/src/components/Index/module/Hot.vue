<template>
    <el-row id="hot">
        <el-col :span="24">
            <h4 class="title">人气
                <span>/</span>
                <span>专区</span>
            </h4>
        </el-col>
        <el-col :span="24">
            <div class="hot-banner">
            </div>
        </el-col>
        <el-col :span="24">
            <el-row :gutter="13">
             <el-col v-for="item in hotList" :key="item.key" :span="6">
                    <Cake :CakeInfo="item"></Cake>
                </el-col>
            </el-row>
        </el-col>
    </el-row>
</template>
<script>
import Cake from "./Cake";
export default {
  name: "Hot",
    props: {
    hotList: Array
  },
  components: {
    Cake
  },
  mounted() {},
  data() {
    return {};
  },
  methods: {}
};
</script>
<style lang="less">
.title {
  text-align: left;
  font-size: 26px;
  color: #724228;
  line-height: 36px;
  width: 1100px;
  margin: 0 auto;
  margin-top: 40px;
  span {
    font-size: 14px;
    color: #8e5d43;
    display: inline-block;
    margin-left: 6px;
  }
}
.hot-banner {
  height: 345px;
  width: 100%;
  background-image: data-uri("../../../assets/images/tag/hot-banner.jpg");
}
</style>
