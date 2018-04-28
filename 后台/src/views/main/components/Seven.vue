<template>
  <el-card class="seven-card" :body-style = "{ padding: '0px 20px 0 20px' }">
    <div slot="header">
      <span>七日销量</span>
    </div>
      <ve-line :data="chartData" :legend-visible="false" :settings="chartSettings" height="37vh"></ve-line>
  </el-card>
</template>
<script>
import { getServer } from "@/assets/js/server.js";
export default {
  name: "Seven",
  data() {
    return {
      server: "",
      chartData: {
        columns: ["day", "num"],
        rows: []
      }
    };
  },
  created: function() {
    let server = getServer();
    this.server = server;
    this.$http
      .post(
        this.server + "select.php",
        { action: "getSeven", region: localStorage.getItem("region")},
        { emulateJSON: true }
      )
      .then(
        response => {
          var seven = response.body.info;
          for (let i = 0; i < seven.length; i++) {
            this.chartData.rows.push(seven[i]);
          }
        },
        response => {}
      );
    this.chartSettings = {
      area: true,
      areaStyle: {
        normal: {}
      },
      labelMap: {
        day: "日期",
        num: "销量"
      }
    };
  }
};
</script>

<style lang="less" scoped>
.seven-card {
  margin-top: 20px;
}
</style>

