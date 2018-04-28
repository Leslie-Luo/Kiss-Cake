<template>
  <div id="MyOrder">
    <div style="float:right;margin-bottom:10px;">
      <el-pagination background layout="prev, pager, next" :page-size="20" :total="this.Allorder" :current-page="this.current" @current-change="changePage">
      </el-pagination>
    </div>
    <template>
      <el-table :data="viewlist" border style="width: 100%" :max-height="this.tableHeight">
        <el-table-column type="index" :index="indexMethod" align="center">
        </el-table-column>
        <el-table-column prop="createtime" label="日期" width="180" sortable>
        </el-table-column>
        <el-table-column prop="foodsname" label="所购商品">
          <template slot-scope="scope">
            <el-tag style="margin:5px;" close-transition v-for="(item,index) in scope.row.foodsname" :key="index" :itemid="item">{{item.name}}·{{item.spec}}磅 x {{item.num}}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="address" label="收货地址">
          <template slot-scope="scope">
            {{scope.row.address.city}}-{{scope.row.address.district}}-{{scope.row.address.address}}
          </template>
        </el-table-column>
        <el-table-column prop="state" label="状态" width="100" align="center" sortable>
          <template slot-scope="scope">
            <el-tag v-if="scope.row.state=='0'" type="danger" close-transition>未发货</el-tag>
            <el-tag v-if="scope.row.state=='1'" type="success" close-transition>已发货</el-tag>
            <el-tag v-if="scope.row.state=='2'" type="info" close-transition>已结单</el-tag>
          </template>
        </el-table-column>
      </el-table>
    </template>
  </div>
</template>
<script>
import { getServer } from "@/assets/js/server.js";
export default {
  name: "MyOrder",
  data() {
    return {
      tableHeight: "",
      server: "",
      orderList: [],
      viewlist: [],
      Allorder: 0,
      current: 1
    };
  },
  mounted() {
    this.tableHeight = document.body.clientHeight - 270;
    this.server = getServer();
    this.getList();
  },
  methods: {
    getList() {
      this.$http
        .post(
          this.server + "select.php",
          { action: "getMemberInfo", id: localStorage.getItem("id") },
          { emulateJSON: true }
        )
        .then(
          response => {
            let data = response.body;
            if (data.code == "0") {
              let info = data.data;
              this.orderList = info.orderlist;
              if (info.orderlist == null) {
                this.Allorder = 0;
              } else {
                this.Allorder = info.orderlist.length;
                this.changePage(1);
              }
            }
          },
          response => {}
        );
      return true;
    },
    indexMethod(index) {
      let start = (this.current - 1) * 20;
      return start + index + 1;
    },
    changePage(page) {
      this.current = page;
      let val = this.orderList;
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
