<template>
  <el-card>
    <div slot="header">
      <span>会员列表</span>
      <div style="float:right;">
        <el-pagination background layout="prev, pager, next" :page-size="20" :total="this.tableData.length" :current-page="this.current" @current-change="changePage">
        </el-pagination>
      </div>
    </div>
    <el-table :data="viewlist" border style="width: 100%" v-bind:max-height="this.Height()">
      <el-table-column type="index" :index="indexMethod" align="center">
      </el-table-column>
      <el-table-column prop="username" label="姓名" width="180">
      </el-table-column>
      <el-table-column prop="phone" label="电话" width="180">
      </el-table-column>
      <el-table-column prop="email" label="邮箱" width="180">
      </el-table-column>
      <el-table-column prop="regtime" label="注册时间" width="180">
      </el-table-column>
      <el-table-column prop="ordernum" label="订单数量" sortable>
      </el-table-column>
      <el-table-column label="操作" width="100" fixed="right" align="center">
        <template slot-scope="scope">
          <el-button size="mini" @click="getInfo(scope.row.id)">查看详情</el-button>
        </template>
      </el-table-column>
    </el-table>
  </el-card>
</template>

<script>
import { memberlist } from "vuex";
import { getServer } from "@/assets/js/server.js";
export default {
  name: "MemberList",
  data() {
    return {
      tableData: [],
      viewlist: [],
      current: 1
    };
  },
  created: function() {
    let server = getServer();
    this.server = server;
    this.getMember();
    this.tableHeight = document.body.clientHeight - 210;
  },
  methods: {
    getMember() {
      this.$http
        .post(
          this.server + "select.php",
          { action: "getMember" },
          { emulateJSON: true }
        )
        .then(
          response => {
            let data = response.body;
            if (data.code == "0") {
              this.tableData = data.data;
              this.changePage(this.current);
            }
          },
          response => {}
        );
      return true;
    },
    getInfo(id) {
      this.$emit("MemberInfo", id);
    },
    Height() {
      let height = document.body.clientHeight - 210;
      return height;
    },
    indexMethod(index) {
      let start = (this.current - 1) * 20;
      return start + index + 1;
    },
    changePage(page) {
      this.current = page;
      let val = this.tableData;
      let start = (page - 1) * 20;
      let end = page * 20;
      let NewTableData = new Array();
      NewTableData = [];
      for (let x = 0; x < val.length; x++) {
        if (start <= x && x < end) {
          NewTableData.push(val[x]);
        }
      }
      this.viewlist = NewTableData;
    }
  }
};
</script>

<style lang="less">

</style>

