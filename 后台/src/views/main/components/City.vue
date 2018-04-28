<template>
  <el-card class="city-card" :body-style="{ padding: '10px 20px 10px 20px' }">
    <div slot="header">
      <span>今日各地销量</span>
    </div>
    <el-row :gutter="20">
      <el-col :span="8" style="height:10px;">
        <el-table :data="tableData" style="width: auto;" :max-height="this.Mh" border :default-sort="{prop: 'date', order: 'descending'}">
          <el-table-column prop="name" label="城市" align="center">
          </el-table-column>
          <el-table-column prop="value" label="销量" sortable align="center">
          </el-table-column>
        </el-table>
      </el-col>
      <el-col :span="16">
        <ve-pie :data="chartData" :legend-visible="false" :settings="chartSettings" height="calc(42vh - 20px)"></ve-pie>
      </el-col>
    </el-row>
  </el-card>
</template>
<script>
import { getServer } from "@/assets/js/server.js";
export default {
  name: "City",
  data() {
    return {
      server: "",
      chartData: {
        columns: ["name", "value"],
        rows: []
      },
      tableData: [],
      Mh: 0
    };
  },
  created: function() {
    let maxHeight = document.documentElement.clientHeight;
    this.Mh = maxHeight * 0.42 - 20;
    let server = getServer();
    this.server = server;
    this.$http
      .post(
        this.server + "select.php",
        { action: "getCity" },
        { emulateJSON: true }
      )
      .then(
        response => {
          var city = response.body;
          for (let i = 0; i < city.data.length; i++) {
            this.tableData.push(city.data[i]);
            this.chartData.rows.push(city.data[i]);
          }
        },
        response => {}
      );
    this.chartSettings = {
      radius: this.Mh * 0.4,
      offsetY: this.Mh * 0.5,
      selectedMode: "single",
      hoverAnimation: false
    };
  },
  methods: {
    
  }
};
</script>

<style lang="less" scoped>
.city-card {
  margin-top: 20px;
}
</style>

