<template>
  <div id="CheckOut">
    <div v-if="!success" class="Tocheckout">
      <div class="title">
        <p>配送信息</p>
      </div>
      <div class="address">
        <el-card class="address-box">
          <div class="add-address" v-if="showAdd" @click="AddAddress()">
            <i class="el-icon-circle-plus-outline"></i>添加地址
          </div>
          <div class="address-list" v-if="!showAdd">
            <AddressList @ChangeShow="ChangeShow"></AddressList>
          </div>
        </el-card>
        <AddAddress v-if="Adddialog" ref="AddAddress" @CloseAdd="CloseAdd"></AddAddress>
      </div>
      <div class="buy-list-box">
        <el-card>
          <BuyList></BuyList>
        </el-card>
      </div>
      <div class="ToPay">
        <el-card>
          <el-row>
            <el-col :span="3" :offset="19">
              <span class="total" v-once>总价：￥{{total()}}.00</span>
            </el-col>
            <el-col :span="2">
              <div class="pay" @click="Pay">去支付</div>
            </el-col>
          </el-row>
        </el-card>
      </div>
    </div>
    <div v-if="success" class="Sucheckout">
      <el-card>
        <p class="su">
          <i class="el-icon-success"></i>
          支付成功
        </p>
        <p class="order">
          <span @click="Tohome()">返回首页</span>
          <span @click="ToOrder()">查看订单</span>
        </p>
      </el-card>
    </div>
  </div>
</template>
<script>
import $ from "jquery";
import AddressList from "./module/AddressList";
import AddAddress from "./module/AddAddress";
import BuyList from "./module/BuyList";
import { getServer } from "@/assets/js/server.js";
export default {
  name: "CheckOut",
  components: {
    AddressList,
    AddAddress,
    BuyList
  },
  data() {
    return {
      showAdd: false,
      Adddialog: false,
      formdata: {
        allfoods: [],
        allspec: [],
        allnum: [],
        total: ""
      },
      success: false
    };
  },
  mounted() {
    $("html,body").animate({ scrollTop: 0 }, 300);
    let buyList = JSON.parse(localStorage.getItem("buyList"));
    let allfoods = new Array();
    let allspec = new Array();
    let allnum = new Array();
    let allprice = "";
    for (let x = 0; x < buyList.length; x++) {
      let num = Number(buyList[x].num);
      let spec = Number(buyList[x].spec);
      let price = Number(buyList[x].price);
      allfoods.push(buyList[x].id);
      allspec.push(buyList[x].spec);
      allnum.push(buyList[x].num);
    }
    this.formdata.allfoods = allfoods;
    this.formdata.allnum = allnum;
    this.formdata.allspec = allspec;
  },
  methods: {
    change(){
      this.showAdd = true;
    },
    ChangeShow() {
      this.showAdd = !this.showAdd;
    },
    total() {
      let buyList = JSON.parse(localStorage.getItem("buyList"));
      let all = 0;
      for (let x = 0; x < buyList.length; x++) {
        all =
          parseInt(all) + parseInt(buyList[x].price) * parseInt(buyList[x].num);
      }
      this.formdata.total = all;
      return all;
    },
    AddAddress() {
      this.Adddialog = true;
      var _this = this;
      setTimeout(() => {
        _this.$refs.AddAddress.Adddialog = true;
      }, 100);
    },
    CloseAdd() {
      this.ChangeShow();
      this.Adddialog = false;
    },
    Pay() {
      if (localStorage.getItem("AddressId")) {
        var formData = new FormData();
        formData.append("action", "Pay");
        formData.append("userid", localStorage.getItem("id"));
        formData.append("address", localStorage.getItem("Address"));
        formData.append(
          "city",
          localStorage.getItem("AddressId").split(",")["0"]
        );
        formData.append(
          "district",
          localStorage.getItem("AddressId").split(",")["1"]
        );
        var arr = Object.keys(this.formdata);
        for (let x = 0; x < arr.length; x++) {
          formData.append(arr[x], this.formdata[arr[x]]);
        }
        let server = getServer() + "BuyCake.php";
        this.$http.post(server, formData, { emulateJSON: true }).then(
          response => {
            if (response.body.code == "0") {
              localStorage.removeItem("shoplist");
              localStorage.removeItem("buyList");
              localStorage.removeItem("Address");
              localStorage.removeItem("AddressId");
              this.$store.state.user.buynum = "";
              this.success = true;
              $("html,body").animate({ scrollTop: 0 }, 300);
            } else {
              this.$message.error(response.body.msg);
            }
          },
          response => {}
        );
      } else {
        this.$message.error("请先选择收货地址!");
        $("html,body").animate({ scrollTop: 0 }, 300);
      }
    },
    Tohome(){
      this.$router.push({ name: "Kiss-Cake" });
    },
    ToOrder(){
      this.$router.push({ name: "用户中心", params: { type: 'Order' } });
    }
  }
};
</script>
<style lang="less">
#CheckOut {
  .Tocheckout {
    .title {
      background: #fafafa;
      font-size: 13px;
      width: 1200px;
      overflow: hidden;
      line-height: 44px;
      -webkit-box-shadow: 0 2px 5px 0 rgba(146, 146, 146, 0.1);
      box-shadow: 0 2px 5px 0 rgba(146, 146, 146, 0.1);
      margin: 30px 0 20px 0;
      border-radius: 5px;
      p {
        margin-left: 20px;
      }
    }
    .address {
      .address-box {
        .add-address {
          border: 1px dashed #e4e4e4;
          height: 75px;
          line-height: 75px;
          color: #684029;
          font-size: 18px;
          text-align: center;
          cursor: pointer;
        }
      }
    }
    .buy-list-box {
      margin: 20px 0;
    }
    .ToPay {
      margin-bottom: 100px;
      .total {
        font-weight: 600;
        height: 30px;
        line-height: 30px;
      }
      .pay {
        height: 30px;
        line-height: 30px;
        text-align: center;
        cursor: pointer;
        background: #684029;
        color: #fff;
      }
    }
  }
  .Sucheckout {
    width: 50%;
    text-align: center;
    margin-top: 25vh;
    margin-left: 25%;
    .su{
      padding-bottom: 20px;
    }
    .order {
      text-align: center;
      span {
        cursor: pointer;
      }
    }
  }
}
</style>
