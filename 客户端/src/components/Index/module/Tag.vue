<template>
  <el-row :gutter="20">
    <el-col :span="6">
      <el-card class="tag">
        <div class="image1" @click='To("new")'>
        </div>
      </el-card>
    </el-col>
    <el-col :span="6">
      <el-card class="tag">
        <div class="image2" @click='To("hot")'>
        </div>
      </el-card>
    </el-col>
    <el-col :span="6">
      <el-card class="tag">
        <div class="image3" @click='Tui'>
        </div>
      </el-card>
    </el-col>
    <el-col :span="6">
      <el-card class="tag">
        <div class="image4" @click='Go'>
        </div>
      </el-card>
    </el-col>
  </el-row>
</template>
<script>
import $ from "jquery";
export default {
  name: "Tag",
  mounted() {},
  data() {
    return {};
  },
  methods: {
    To: function(where) {
      $("html,body").animate(
        { scrollTop: $("#" + where).offset().top - 65 },
        800
      );
    },
    Go: function() {
      this.$router.push({ name: "Kiss Cake-口味" });
    },
    Tui: function() {
      this.$router.push({ name: "Kiss Cake-商品详情", params: { id: '2' } });
    }
  }
};
</script>
<style lang="less">
@height: 100px;
@image1: data-uri("../../../assets/images/tag/01.jpg");
@image2: data-uri("../../../assets/images/tag/02.jpg");
@image3: data-uri("../../../assets/images/tag/03.jpg");
@image4: data-uri("../../../assets/images/tag/04.jpg");
.tag {
  margin-top: 20px;
  height: @height;
  border: none;
  z-index: 999;
  cursor: pointer;
  .el-card__body {
    padding: 0px;
    height: @height;
    [class^="image"] {
      height: @height;
    }
    .image1 {
      background-image: @image1;
    }
    .image2 {
      background-image: @image2;
    }
    .image3 {
      background-image: @image3;
    }
    .image4 {
      background-image: @image4;
    }
  }
}
</style>
