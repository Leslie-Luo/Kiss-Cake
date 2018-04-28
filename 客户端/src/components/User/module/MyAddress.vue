<template>
  <div id="MyAddress">
    <div class="card-title">
      <el-row :gutter="20" class="title-list">
        <el-col :span="4">
          <div>收货人</div>
        </el-col>
        <el-col :span="8">
          <div>地址</div>
        </el-col>
        <el-col :span="4">
          <div>联系电话</div>
        </el-col>
        <el-col :span="8">
          <div>操作</div>
        </el-col>
      </el-row>
    </div>
    <div class="address-list">
      <el-row :gutter="20" v-for="(item,index) in this.AddressList" :key="item.key" class="list" :class="'list'+index">
        <el-col :span="4">
          {{item.username}}
        </el-col>
        <el-col :span="8" class="list-address">
          {{item.city.text + "-" + item.district.text + "-" + item.address}}
        </el-col>
        <el-col :span="4">
          {{item.phone}}
        </el-col>
        <el-col :span="8" class="list-button">
          <span @click="modify(item)">编辑</span>
          <span style="color: #ff3c3c;" @click="deletes(item.id)">删除</span>
        </el-col>
      </el-row>
      <div class="add">
        <el-button @click="AddAddress()">添加地址</el-button>
      </div>
      <AddAddress ref="AddAddress"></AddAddress>
    </div>
  </div>
</template>
<script>
import $ from "jquery";
import AddAddress from "./../../CheckOut/module/AddAddress";
import { getServer } from "@/assets/js/server.js";
export default {
  name: "MyAddress",
  components: {
    AddAddress
  },
  data() {
    return {
      AddressList: "",
      AddressNum: 0
    };
  },
  mounted() {
    this.getData();
  },
  methods: {
    getData() {
      var formData = new FormData();
      formData.append("action", "GetAddressList");
      formData.append("userid", localStorage.getItem("id"));
      let server = getServer() + "BuyCake.php";
      this.$http.post(server, formData, { emulateJSON: true }).then(
        response => {
          if (response.body.code == "0") {
            if (response.body.data == null) {
              this.AddressList = [];
              return false
            } else {
              this.AddressList = response.body.data;
              this.AddressNum = this.AddressList.length;
            }
          } else {
            this.$message.error(response.body.msg);
          }
        },
        response => {}
      );
    },
    modify(val) {
      var _this = this;
      setTimeout(() => {
        _this.$refs.AddAddress.Adddialog = true;
      }, 0);
      setTimeout(() => {
        _this.$refs.AddAddress.ruleForm.username = val.username;
        _this.$refs.AddAddress.modifyid = val.id;
        _this.$refs.AddAddress.ruleForm.phone = val.phone;
        _this.$refs.AddAddress.ruleForm.address = val.address;
        _this.$refs.AddAddress.ruleForm.city = val.city.id;
        _this.$refs.AddAddress.ruleForm.selectcity = val.city.id - 0;
      }, 100);
      setTimeout(() => {
        _this.$refs.AddAddress.ruleForm.district = parseInt(val.district.id);
      }, 150);
    },
    deletes(id) {
      this.$confirm("操作后无法进行修改, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(() => {
          this.Todeletes(id);
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消操作"
          });
        });
    },
    Todeletes(id) {
      let server = getServer() + "BuyCake.php";
      this.$http
        .post(
          server,
          {
            action: "DeleteAddress",
            id: id
          },
          { emulateJSON: true }
        )
        .then(
          response => {
            let data = response.body;
            if (data.code == "0") {
              this.getData();
              this.$message({
                message: data.msg,
                type: "success"
              });
            } else {
              this.$message.error(data.msg);
            }
          },
          response => {}
        );
    },
    AddAddress() {
      if (this.AddressNum >= 7) {
        this.$message.error("最多添加 7 条收货地址");
        return false;
      }
      var _this = this;
      setTimeout(() => {
        _this.$refs.AddAddress.Adddialog = true;
      }, 100);
    },
    CloseAdd() {
      this.getData();
    }
  }
};
</script>
<style lang="less">
#MyAddress {
  .card-title {
    text-align: center;
    font-size: 15px;
    width: calc(~"100% - 4px");
    overflow: hidden;
    line-height: 44px;
    border: 2px dashed #f1f1f1;
    margin: 0px 0 10px 0;
    border-radius: 5px;
    .title-list {
      height: 44px;
    }
  }
  .address-list {
    text-align: center;
    .list {
      height: 55px;
      line-height: 55px;
      border-top: 2px dashed #f1f1f1;
      .list-address {
        display: inline-block;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        vertical-align: middle;
      }
      .list-button {
        span {
          cursor: pointer;
        }
      }
    }
    .list0 {
      border: none;
    }
    .add {
      text-align: center;
      margin-top: 25px;
    }
  }
}
</style>
