<template>
  <div>
    <el-table :data="viewlist" border v-bind:max-height="this.Height()">
      <el-table-column type="index" :index="indexMethod" align="center">
      </el-table-column>
      <el-table-column prop="createtime" label="交易日期" width="150" sortable align="center">
      </el-table-column>
      <el-table-column prop="username" label="姓名" width="100" align="center">
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
      <el-table-column prop="state" label="状态" width="100" align="center">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.state=='0'" type="danger" close-transition>未发货</el-tag>
          <el-tag v-if="scope.row.state=='1'" type="success" close-transition>已发货</el-tag>
          <el-tag v-if="scope.row.state=='2'" type="info" close-transition>已结单</el-tag>
        </template>
      </el-table-column>
      <el-table-column fixed="right" label="操作" width="100" align="center">
        <template slot-scope="scope">
          <el-button v-if="scope.row.state=='0'" type="danger" size="mini" @click="Msg(scope.row.id)">发货</el-button>
          <el-button v-if="scope.row.state=='1'" type="success" size="mini" @click="End(scope.row.id)">结单</el-button>
          <el-button v-if="scope.row.state=='2'" type="info" size="mini" @click="End(scope.row.id)" disabled>完结</el-button>
        </template>
      </el-table-column>
    </el-table>
    <div style="text-align: right;margin-top:20px;">
      <el-pagination background layout="prev, pager, next" :page-size="20" :total="this.AllNum" :current-page="this.current" @current-change="changePage">
      </el-pagination>
    </div>
  </div>
</template>

<script>
import { linkage } from "vuex";
import { getServer } from "@/assets/js/server.js";
export default {
  name: "OrderTable",
  props: {
    orderType: String
  },
  data() {
    return {
      orderlist: [],
      viewlist: [],
      AllNum: 1,
      current: 1,
      getHeight: true,
      show: false,
      region: ""
    };
  },
  created: function() {
    let server = getServer();
    this.server = server;
    this.region = localStorage.getItem("region");
    if (this.orderType == "Delivery") {
      this.getOrderList();
      this.show = true;
    }
    setTimeout(() => {
      this.changePage(this.current);
      this.Height();
    }, 500);
  },
  methods: {
    getOrderList() {
      this.$http
        .post(
          this.server + "select.php",
          { action: "getOrderlist" },
          { emulateJSON: true }
        )
        .then(
          response => {
            let info = response.body;
            this.$store.state.orderlist.orderlist = [];
            if (this.region == "0") {
              if (info.code == "4") {
                return false;
              } else {
                this.$store.state.orderlist.orderlist = info;
              }
            } else {
              for (let z = 0; z < info.length; z++) {
                if (info[z]["city"] == this.region - 1) {
                  this.$store.state.orderlist.orderlist.push(info[z]);
                }
              }
            }
            this.getData(this.$store.state.orderlist.orderlist);
          },
          response => {}
        );
      return true;
    },
    getData(val) {
      let orderType = ["Delivery", "Shipped"];
      for (let x = 0; x < orderType.length; x++) {
        this.$store.state.orderlist[orderType[x]] = [];
        for (let z = 0; z < val.length; z++) {
          if (val[z].state == x) {
            this.$store.state.orderlist[orderType[x]].push(val[z]);
          }
        }
      }
      this.$store.state.orderlist.All = [];
      this.$store.state.orderlist.All = val;
    },
    indexMethod(index) {
      let start = (this.current - 1) * 20;
      return start + index + 1;
    },
    Height() {
      let height = document.body.clientHeight - 235;
      return height;
    },
    Msg(id) {
      this.$confirm("操作后无法进行修改, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(() => {
          this.DeliverGoods(id, "1");
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消操作"
          });
        });
    },
    End(id) {
      this.$confirm("操作后无法进行修改, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(() => {
          this.DeliverGoods(id, "2");
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消操作"
          });
        });
    },
    DeliverGoods(id, state) {
      this.$http
        .post(
          this.server + "insert.php",
          { action: "delivergoods", id: id, state: state },
          { emulateJSON: true }
        )
        .then(
          response => {
            let data = response.body;
            if (data.code == "0") {
              this.$notify({
                title: "成功",
                message: data.msg,
                type: "success"
              });
              if (state == '1') {
                this.$store.commit('indexchange');
              }
              this.getOrderList();
              setTimeout(() => {
                this.current = 1;
                this.changePage(1);
              }, 500);
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
    changePage(page) {
      this.current = page;
      let val = this.$store.state.orderlist[this.orderType];
      this.AllNum = val.length;
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