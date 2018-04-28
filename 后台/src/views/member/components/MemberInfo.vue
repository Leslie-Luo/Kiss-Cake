<template>
  <el-row :gutter="20">
    <el-col :span="6">
      <el-card>
        <div slot="header" class="clearfix">
          <span>会员信息</span>
          <el-button style="float: right; padding: 3px 0" icon="el-icon-d-arrow-left" @click="Back" type="text">返回</el-button>
        </div>
        <div class="member">
          <el-row>
            <el-col :span="24">
              <div class="header-box"><img class="header" :src="this.header" alt="" width="auto"></div>
            </el-col>
            <el-col :span="24">
              <div class="info-box">
                <ul>
                  <p>姓名：
                    <span>{{this.username}}</span>
                  </p>
                  <p>电话：
                    <span>{{this.phone}}</span>
                  </p>
                  <p>邮箱：
                    <span>{{this.email}}</span>
                  </p>
                </ul>
              </div>
            </el-col>
          </el-row>
        </div>
      </el-card>
    </el-col>
    <el-col :span="18">
      <el-card>
        <div slot="header" class="clearfix">
          <span>用户订单·{{this.Allorder}}</span>
          <div style="float:right">
            <el-pagination background layout="prev, pager, next" :page-size="20" :total="this.Allorder" :current-page="this.current" @current-change="changePage">
            </el-pagination>
          </div>
        </div>
        <template>
          <el-table :data="viewlist" border style="width: 100%" :max-height="this.tableHeight">
            <el-table-column type="index" :index="indexMethod" align="center">
            </el-table-column>
            <el-table-column prop="createtime" label="日期" width="180" sortable>
            </el-table-column>
            <el-table-column prop="foodsname" label="所购商品">
              <template slot-scope="scope">
                <el-tag style="margin:5px;" close-transition v-for="(item,index) in scope.row.foodsname" :key="index" :itemid="item">{{item.name}} x {{item.num}}
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
      </el-card>
    </el-col>
  </el-row>
</template>

<script>
import { memberlist } from "vuex";
import { getServer } from "@/assets/js/server.js";
export default {
  name: "MemberInfo",
  data() {
    return {
      tableHeight: "",
      header: "",
      username: "",
      phone: "",
      email: "",
      orderList: [],
      viewlist: [],
      Allorder: 0,
      current: 1
    };
  },
  created: function() {
    let server = getServer();
    this.server = server;
    this.tableHeight = document.body.clientHeight - 210;
  },
  methods: {
    getMemberInfo(id) {
      this.$http
        .post(
          this.server + "select.php",
          { action: "getMemberInfo", id: id },
          { emulateJSON: true }
        )
        .then(
          response => {
            let data = response.body;
            if (data.code == "0") {
              let info = data.data;
              this.header = this.server + info.header;
              this.username = info.username;
              this.phone = info.phone;
              this.email = info.email;
              if (info.orderlist === null) {
                return false;1
              }
              this.orderList = info.orderlist;
              this.Allorder = info.orderlist.length;
              this.changePage(1);
            }
          },
          response => {}
        );
      return true;
    },
    Back() {
      this.$emit("MemberList", "xxx");
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
.member {
  .header-box {
    margin: 10px auto;
    text-align: center;
    .header {
      width: 100px;
      height: 100px;
    }
  }
  .info-box {
    margin: 10px auto;
    ul p {
      font-size: 1rem;
      font-weight: 500;
      line-height: 1.5rem;
    }
  }
}
</style>

