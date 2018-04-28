<template>
<div>
  <div class="tag-title">{{this.$route.params.TagText}}</div>
  <div class="flavor">
    <div style="width: 1100px;margin: 0 auto;">
      <el-row :gutter="20">
        <div v-for="item in CakeList" :key="item.key" v-show="ShowTag(item)">
            <el-col :span="6">
              <Cake :CakeInfo="item"></Cake>
            </el-col>
        </div>
      </el-row>
    </div>
    <ToTop></ToTop>
  </div>
  </div>
</template>
<script>
import $ from "jquery";
import Cake from "./../Index/module/Cake";
import ToTop from "./../Layout/ToTop";
import { getServer } from "@/assets/js/server.js";
export default {
  name: "Tag",
  components: {
    Cake,
    ToTop
  },
  data() {
    return {
      CakeList: [],
      GetFlavor: [],
      Action: "All",
      ActionTag: "All"
    };
  },
  beforeMount() {
    $("html,body").animate({ scrollTop: 0 }, 0);
  },
  mounted() {
    let server = getServer() + "BuyCake.php";
    this.$http
      .post(server, { action: "GetCakeList" }, { emulateJSON: true })
      .then(
        response => {
          let data = response.body;
          if (data.code == "0") {
            this.CakeList = response.body.data;
          }
        },
        response => {}
      );
  },
  methods: {
    ShowTag(val){
      for (let x = 0; x < val.tag.length; x++) {
        const element = val.tag[x].text;
        if(this.$route.params.TagText == element){
          return true;
        }
      }
    }
  }
};
</script>
<style lang="less">
.tag-title{
  font-size: 20px;
  font-weight: 700;
  text-align: center;
  margin: 20px 0;
}
.flavor {
  margin-bottom: 50px;
}
</style>
