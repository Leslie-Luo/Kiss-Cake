<template>
  <el-row :gutter="20">
    <el-col :span="8">
      <UserCard></UserCard>
      <Seven></Seven>
    </el-col>
    <el-col :span="16">
      <el-row :gutter="20">
        <NumCard v-for="item in itemArr" :key="item.key" :end-val="item.num" :iconType="item.icon" :color="item.color" :intro-text="item.title"></NumCard>
      </el-row>
      <City></City>
    </el-col>
    <el-col :span="24">
      <Notice></Notice>
    </el-col>
  </el-row>
</template>
<script>
import { linkage } from "vuex";
import UserCard from "./components/UserCard.vue";
import NumCard from "./components/NumCard.vue";
import Seven from "./components/Seven.vue";
import City from "./components/City.vue";
import Notice from "./components/Notice.vue";
import { getServer } from "@/assets/js/server.js";
export default {
  name: "Main",
  components: {
    UserCard,
    NumCard,
    Seven,
    City,
    Notice
  },
  data() {
    return {
      server: "",
      itemArr: [],
      server: "",
      change: this.$store.state.linkage.indexchange
    };
  },
  created: function() {
    let server = getServer();
    this.server = server;
    this.getNum();
  },
  methods: {
    getNum() {
      {
        this.$http
          .post(
            this.server + "select.php",
            { action: "getnum", region: localStorage.getItem("region") },
            { emulateJSON: true }
          )
          .then(
            response => {
              let num = response.body.data;
              let Arr = [];
              for (let i = 0; i < num.length; i++) {
                Arr.push(num[i]);
              }
              this.itemArr = Arr;
            },
            response => {}
          );
      }
    }
  },
  watch:{
    '$store.state.linkage.indexchange': function(){
      this.getNum();
    }
  }
};
</script>
<style lang="less" scoped>

</style>
