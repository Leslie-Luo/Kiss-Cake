<template>
  <div>
    <keep-alive>
      <el-card class="box-card">
        <div slot="header">
          <span>商品列表</span>
          <div style="float:right">
            <el-pagination background layout="prev, pager, next" :page-size="20" :total="this.AllNum" :current-page="this.current" @current-change="changePage">
            </el-pagination>
          </div>
        </div>
        <el-table :data="tableData" border style="width=100%" v-bind:max-height="this.Height()">
          <el-table-column type="index" :index="indexMethod" align="center">
          </el-table-column>
          <el-table-column prop="name" label="名称">
          </el-table-column>
          <el-table-column prop="type" label="种类" width="80" align="center" v-if="false">
            <template slot-scope="scope">
              <el-tag success close-transition :class="scope.row.type.color">{{scope.row.type['type']}}</el-tag>
            </template>
          </el-table-column>
          <el-table-column prop="taste" label="口味">
            <template slot-scope="scope">
              <el-tag close-transition v-for="(item,index) in scope.row.taste" :key="index" :itemid="item" :class="item.color">{{item.name}}
              </el-tag>
            </template>
          </el-table-column>
          <el-table-column prop="tag" label="标签">
            <template slot-scope="scope">
              <el-tag close-transition v-for="(item,index) in scope.row.tag" :key="index" :itemid="item" :class="item.color">{{item.name}}
              </el-tag>
            </template>
          </el-table-column>
          <el-table-column prop="default_price" label="默认规格" width="120" align="center">
          </el-table-column>
          <el-table-column prop="spec" label="规格">
          </el-table-column>
          <el-table-column prop="online" label="状态" width="100" sortable align="center">
            <template slot-scope="scope">
              <el-tag v-if="scope.row.online=='0'" type="success" close-transition>已上架</el-tag>
              <el-tag v-if="scope.row.online=='1'" type="danger" close-transition>已下架</el-tag>
            </template>
          </el-table-column>
          <el-table-column fixed="right" label="操作" width="150" align="center">
            <template slot-scope="scope">
              <el-button size="mini" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
              <el-button v-if="scope.row.online=='0'" size="mini" type="danger" @click="Online(scope.row.id,scope.row.online)">下架</el-button>
              <el-button v-if="scope.row.online=='1'" size="mini" type="success" @click="Online(scope.row.id,scope.row.online)">上架</el-button>
            </template>
          </el-table-column>
        </el-table>
      </el-card>
    </keep-alive>
  </div>
</template>
<script>
import { cakelist } from "vuex";
import router from "@/router";
import { getServer } from "@/assets/js/server.js";
export default {
  name: "CakeList",
  data() {
    return {
      server: "",
      tableData: [],
      formLabelWidth: "120px",
      AllNum: 0,
      current: 1
    };
  },
  created: function() {
    let server = getServer();
    this.server = server;
    if (this.$store.state.cakelist.Refresh == true) {
      this.getdata();
      this.$store.state.cakelist.Refresh = false;
    } else if (this.$store.state.cakelist.cakelist == "") {
      this.getdata();
    } else {
      this.AllNum = Number(this.$store.state.cakelist.cakelist.length);
      this.current = Number(this.$store.state.cakelist.nowPage);
      let nowPage = this.$store.state.cakelist.nowPage;
      this.changePage(nowPage);
    }
  },
  methods: {
    getdata: function() {
      this.$http
        .post(
          this.server + "select.php",
          { action: "cakeList" },
          { emulateJSON: true }
        )
        .then(
          response => {
            let cakeList = response.body.data;
            this.AllNum = Number(cakeList.length);
            for (let i = 0; i < cakeList.length; i++) {
              let cakeItem = new Object();
              let listItem = cakeList[i];
              cakeItem.id = listItem["id"];
              cakeItem.name = listItem["name"];
              let type = new Object();
              let types = listItem["type"]["type_id"].split("");
              let typecolor = types[types.length - 1];
              type["color"] = "color" + typecolor;
              type["type"] = listItem["type"]["type"];
              cakeItem.type = type;
              let taste = [];
              for (let t = 0; t < listItem.taste.length; t++) {
                let tastes = new Object();
                let spstr = listItem["taste"][t]["taste_id"].split("");
                let color = spstr[spstr.length - 1];
                tastes["color"] = "color" + color;
                tastes["id"] = "taste" + listItem["taste"][t]["taste_id"];
                tastes["name"] = listItem["taste"][t]["taste"];
                taste[t] = tastes;
              }
              cakeItem.taste = taste;
              let tag = [];
              for (let t = 0; t < listItem.tag.length; t++) {
                let tags = new Object();
                let spstr = listItem["tag"][t]["tag_id"].split("");
                let color = spstr[spstr.length - 1];
                tags["color"] = "color" + color;
                tags["id"] = "tag" + listItem["tag"][t]["tag_id"];
                tags["name"] = listItem["tag"][t]["tag"];
                tag[t] = tags;
              }
              cakeItem.tag = tag;
              cakeItem.default_price =
                listItem["default_price"]["price"] +
                "￥" +
                "/" +
                listItem["default_price"]["size"] +
                "磅";
              let spec = "";
              for (let t = 0; t < listItem.spec.length; t++) {
                if (t < listItem.spec.length - 1) {
                  spec +=
                    listItem["spec"][t]["price"] +
                    "￥" +
                    "/" +
                    listItem["spec"][t]["size"] +
                    "磅" +
                    ",";
                } else {
                  spec +=
                    listItem["spec"][t]["price"] +
                    "￥" +
                    "/" +
                    listItem["spec"][t]["size"] +
                    "磅";
                }
              }
              cakeItem.spec = spec;
              cakeItem.online = listItem["online"];
              this.$store.state.cakelist.cakelist[i] = cakeItem;
            }
            this.changePage(1);
          },
          response => {}
        );
    },
    formatter(row, column) {
      return row.address;
    },
    me: function(data) {
      alert("000");
    },
    handleEdit(index, row) {
      router.push({ path: `modify/${row.id}` });
    },
    handleClose(tag) {
      this.dynamicTags.splice(this.dynamicTags.indexOf(tag), 1);
    },
    Online(id, online) {
      if (online == "0") {
        online = 1;
      } else {
        online = 0;
      }
      this.$http
        .post(
          this.server + "insert.php",
          { action: "online", id: id, online: online },
          { emulateJSON: true }
        )
        .then(
          response => {
            let data = response.body;
            if (data.code == "0") {
              for (let x = 0; x < this.tableData.length; x++) {
                if (this.tableData[x].id == id) {
                  this.tableData[x].online = online;
                }
              }
              this.$notify({
                title: "成功",
                message: data.msg,
                type: "success"
              });
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
    changePage(val) {
      this.$store.state.cakelist.nowPage = val;
      let start = (val - 1) * 20;
      let end = val * 20;
      let NewTableData = new Array();
      for (let x = 0; x < this.$store.state.cakelist.cakelist.length; x++) {
        if (start <= x && x < end) {
          NewTableData.push(this.$store.state.cakelist.cakelist[x]);
        }
      }
      this.tableData = NewTableData;
    },
    Height() {
      let height = document.body.clientHeight - 210;
      return height;
    },
    indexMethod(index) {
      let start = (this.current - 1) * 20;
      return start + index + 1;
    }
  },
  watch: {
    "$store.state.cakelist.Refresh": function() {
      this.getdata();
    }
  }
};
</script>
<style lang="less" scoped>
@c0: #4a2c2c;
@c1: #00bbf0;
@c2: #50595c;
@c3: #0881a3;
@c4: #90a4ae;
@c5: #78bbe6;
@c6: #ee712b;
@c7: #3f6699;
@c8: #ef7e56;
@c9: #4756ca;
.text-center {
  text-align: center;
  .color0 {
    color: @c0;
  }
  .color1 {
    color: @c1;
  }
  .color2 {
    color: @c2;
  }
  .color3 {
    color: @c3;
  }
  .color4 {
    color: @c4;
  }
  .color5 {
    color: @c5;
  }
  .color6 {
    color: @c6;
  }
  .color7 {
    color: @c7;
  }
  .color8 {
    color: @c8;
  }
  .color9 {
    color: @c9;
  }
}
.el-tag {
  margin: 2px;
}
</style>
