<template>
    <el-row id="new">
        <el-col :span="24">
            <h4 class="title">新品
                <span>/</span>
                <span>专区</span>
            </h4>
        </el-col>
        <el-col :span="24">
            <div class="new-banner">
            </div>
        </el-col>
        <el-col :span="24">
            <el-row :gutter="13">
                <el-col v-for="item in newList" :key="item.key" :span="6">
                    <Cake :CakeInfo="item"></Cake>
                </el-col>
            </el-row>
        </el-col>
    </el-row>
</template>
<script>
import Cake from "./Cake";
export default {
  name: "New",
  props: {
    newList: Array
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
.new-banner {
  height: 345px;
  width: 100%;
  background-image: data-uri("../../../assets/images/tag/new-banner.jpg");
}
</style>
