<template>
  <div id="addresslist">
    <el-row :gutter="20">
      <el-col :span="6" v-for="(item,index) in this.AddressList" v-show="index < shownum" :key="item.key">
        <div class="AddressList" :id="'Address-'+item.city.id+'-'+item.district.id">
          <p class="Address-title">{{item.city.text + "-" + item.district.text}}
            <span>{{item.username}}</span>
          </p>
          <p class="Address-address">{{item.address}}</p>
          <p class="Address-phone">{{item.phone}}</p>
        </div>
      </el-col>
      <el-col :span="6">
        <div class="add_address" @click="AddAddress()">
          <span class="add_txt">添加新地址</span>
        </div>
      </el-col>
    </el-row>
    <div class="bottom-button">
      <div class="showAll-box" v-show="showAllBox">
        <p class="showAll" v-show="!showAll">
          <span @click="shownum = AddressList.length, showAll = !showAll">显示全部
            <i class="el-icon-arrow-down"></i>
          </span>
        </p>
        <p class="showAll" v-show="showAll">
          <span @click="shownum = Allnum; showAll = !showAll">收起
            <i class="el-icon-arrow-up"></i>
          </span>
        </p>
      </div>
      <div class="AddAddress">
        <p>
          <span @click="ManageAddress()">
            <i class="el-icon-menu"></i>
            管理地址
          </span>
        </p>
      </div>
    </div>
    <AddAddress ref="AddAddress"></AddAddress>
  </div>
</template>
<script>
import $ from "jquery";
import AddAddress from "./AddAddress";
import { getServer } from "@/assets/js/server.js";
export default {
  name: "addresslist",
  components: {
    AddAddress
  },
  data() {
    return {
      AddressList: "",
      AddressNum: "",
      shownum: "4",
      Allnum: "4",
      showAllBox: false,
      showAll: false
    };
  },
  mounted() {
    this.getData();
    setTimeout(() => {
      $(".AddressList").click(function() {
        localStorage.setItem("Address", $(this)["0"].children[1].innerHTML);
        localStorage.setItem(
          "AddressId",
          $(this)
            ["0"].id.substring(8)
            .split("-")
        );
        $(this)
          .parent()
          .siblings()
          .children(".active")
          .removeClass("active");
        $(this).addClass("active");
      });
    }, 300);
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
              this.$emit("ChangeShow");
            } else {
              this.AddressList = response.body.data;
              this.AddressNum = this.AddressList.length;
              if (this.AddressNum >= 4) {
                this.showAllBox = true;
              }
            }
          } else {
            this.$message.error(response.body.msg);
          }
        },
        response => {}
      );
      localStorage.removeItem("Address");
      localStorage.removeItem("AddressId");
    },
    ManageAddress() {
      this.$router.push({ name: "用户中心", params: { type: "Address" } });
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
#addresslist {
  .AddressList {
    border: 5px solid #cacaca;
    cursor: pointer;
    padding: 10px;
    overflow: hidden;
    margin: 10px 0px;
    .Address-title {
      width: 100%;
      height: 29px;
      line-height: 29px;
      border-bottom: 1px solid #aaaaaa;
      overflow: hidden;
      span {
        float: right;
        padding-right: 5px;
        overflow: hidden;
      }
    }
    .Address-address {
      height: 25px;
      line-height: 25px;
      font-size: 15px;
      overflow: hidden;
    }
  }
  .add_address {
    height: 75px;
    border: 5px solid #cacaca;
    cursor: pointer;
    padding: 10px;
    overflow: hidden;
    margin: 10px 0px;
    text-align: center;
    .add_txt {
      line-height: 75px;
    }
  }
  .bottom-button {
    margin-bottom: 15px;
    .showAll-box {
      float: left;
      .showAll {
        span {
          cursor: pointer;
        }
      }
    }
    .AddAddress {
      float: right;
      span {
        cursor: pointer;
      }
    }
  }
  .active {
    border: 5px solid #794d4d;
  }
}
</style>
