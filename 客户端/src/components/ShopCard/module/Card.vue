<template>
  <div id="ShopCard">
    <div v-if="!cardshow">
      <div class="cardnull">
        <div class="null-img">
          <img src="../../../assets/images/card/cartempty.png" alt="">
        </div>
        <p>
          <span>您的购物车里还没有商品</span>
        </p>
        <p class="gotoShop" @click="gotoShop()">去购物 &gt;&gt;</p>
      </div>
    </div>
    <div v-if="cardshow">
      <div class="card-title">
        <el-row :gutter="20" class="title-list">
          <el-col :span="7" :offset="1">
            <div>商品</div>
          </el-col>
          <el-col :span="3">
            <div>规格</div>
          </el-col>
          <el-col :span="3">
            <div>单价</div>
          </el-col>
          <el-col :span="4">
            <div>数量</div>
          </el-col>
          <el-col :span="4">
            <div>金额</div>
          </el-col>
        </el-row>
      </div>
      <div class="shop-card">
        <div v-for="(item,index) in shopList" :key="item.key" :class="'shop-list-' + index" class="shop-list">
          <el-row>
            <el-col :span="1" style="text-align: center;heigth:100px;padding: 39px 0px;">
              <el-checkbox :checked="check(item.buy)" @change="select(index)"></el-checkbox>
            </el-col>
            <el-col :span="7">
              <el-row>
                <el-col :span="9">
                  <div class="list-image">
                    <img :src="server + item.img">
                  </div>
                </el-col>
                <el-col :span="15">
                  <div class="list-title" @click="Details(item.id)">
                    {{item.name}}
                  </div>
                </el-col>
                <el-col :span="15">
                  <div class="list-parts">
                    {{Explain[item.spec].cutlery_content}}
                  </div>
                </el-col>
              </el-row>
            </el-col>
            <el-col :span="3">
              <div class="list-price">
                {{item.spec}}.0磅
              </div>
            </el-col>
            <el-col :span="3">
              <div class="list-price">
                ￥{{item.price}}.00
              </div>
            </el-col>
            <el-col :span="4">
              <div class="list-num">
                <div class="number">
                  <input type="button" v-if="item.num == '1'" value="-" class="minus" disabled>
                  <input type="button" v-if="item.num != '1'" value="-" class="minus" @click="change(index,'minus')">
                  <input type="text" v-model="item.num" disabled>
                  <input type="button" value="+" class="plus" @click="change(index,'plus')">
                </div>
              </div>
            </el-col>
            <el-col :span="4">
              <div class="list-total">
                ￥{{item.price * item.num}}.00
              </div>
            </el-col>
            <el-col :span="2">
              <div class="list-delete">
                <p>
                  <i class="el-icon-close" @click="remove(index)" style="font-weight:600;cursor: pointer;"></i>
                </p>
              </div>
            </el-col>
          </el-row>
        </div>
        <el-row :gutter="20">
          <el-col :span="22" :offset="1">
            <div class="shop-buy">
              <el-row :gutter="20">
                <el-col :span="3">
                  <a class="cleanall" @click="CleanAll()">
                    <i class="el-icon-delete"></i>清空购物车</a>
                </el-col>
                <el-col :span="7" :offset="11">
                  <div class="all">己选1件商品，商品合计：￥{{all()}}.00</div>
                </el-col>
                <el-col :span="3">
                  <div type="text" class="card" @click="Checkout()">结算</div>
                </el-col>
              </el-row>
            </div>
          </el-col>
        </el-row>
      </div>
    </div>
  </div>
</template>
<script>
import $ from "jquery";
import { getServer } from "@/assets/js/server.js";
export default {
  name: "Card",
  data() {
    return {
      shopList: [],
      buyList: "",
      cardshow: false,
      Explain: {
        "1": {
          cutlery_content: "含5套餐具"
        },
        "2": {
          cutlery_content: "含10套餐具"
        },
        "3": {
          cutlery_content: "含15套餐具"
        },
        "5": {
          cutlery_content: "含20套餐具"
        }
      }
    };
  },
  mounted() {
    $("html,body").animate({ scrollTop: 0 }, 0);
    if (localStorage.getItem("shoplist")) {
      this.shopList = JSON.parse(localStorage.getItem("shoplist"));
      if (this.shopList) {
        if (this.shopList.length == 0) {
          this.cardshow = false;
          return true;
        }
      } else {
        this.cardshow = false;
        return true;
      }
      if (this.shopList != null) {
        this.cardshow = true;
        return true;
      }
    } else {
      this.cardshow = false;
      return true;
    }
  },
  beforeMount() {
    this.server = getServer();
  },
  methods: {
    gotoShop() {
      this.$router.push({ name: "Kiss-Cake" });
    },
    all() {
      let allprice = 0;
      let buyList = new Array();
      for (let x = 0; x < this.shopList.length; x++) {
        if (this.shopList[x].buy == "1") {
          let num = Number(this.shopList[x].num);
          let price = Number(this.shopList[x].price);
          allprice = allprice + num * price;
          buyList.push(this.shopList[x]);
        }
      }
      this.buyList = buyList;
      return allprice;
    },
    check(val) {
      if (val == "1") {
        return true;
      } else {
        return false;
      }
    },
    select(val) {
      if (this.shopList[val].buy == "1") {
        this.shopList[val].buy = "0";
      } else {
        this.shopList[val].buy = "1";
      }
    },
    change(index, type) {
      if (type == "plus") {
        for (let x = 0; x < this.shopList.length; x++) {
          if (index == x) {
            let num = Number(this.shopList[x].num);
            this.shopList[x].num = num + 1;
          }
        }
      } else {
        for (let x = 0; x < this.shopList.length; x++) {
          if (index == x) {
            let num = Number(this.shopList[x].num);
            this.shopList[x].num = num - 1;
          }
        }
      }
      localStorage.setItem("shoplist", JSON.stringify(this.shopList));
    },
    remove(val) {
      this.shopList.splice(val, 1);
      this.$store.state.user.buynum = this.shopList.length;
      localStorage.setItem("shoplist", JSON.stringify(this.shopList));
      if (this.shopList.length == 0) {
        this.cardshow = false;
      }
    },
    Details: function(id) {
      this.$router.push({ name: "Kiss Cake-商品详情", params: { id: id } });
    },
    CleanAll() {
      this.$store.state.user.buynum = 0;
      this.cardshow = false;
      this.shopList = [];
      localStorage.setItem("shoplist", JSON.stringify(this.shopList));
    },
    Checkout() {
      if (!localStorage.getItem("id")) {
        this.$message.error("您还没有登录，即将跳转登录页面");
        setTimeout(() => {
          this.$router.push({ name: "登录/注册", params: { type: "signIn" } });
        }, 1000);
      }
      if (localStorage.getItem("id") == null) {
        this.$message.error("您还没有登录，即将跳转登录页面");
        setTimeout(() => {
          this.$router.push({ name: "登录/注册", params: { type: "signIn" } });
        }, 1000);
      } else {
        localStorage.setItem("buyList", JSON.stringify(this.buyList));
        this.$router.push({ name: "结算" });
      }
    }
  }
};
</script>

<style lang="less">
#ShopCard {
  margin-bottom: 100px;
  .cardnull {
    text-align: center;
    .null-img {
      margin-top: 25vh;
      width: 100%;
      img {
        display: block;
        height: 116px;
        width: 204px;
        margin: 0 auto;
      }
    }
    .gotoShop {
      cursor: pointer;
      font-weight: 700;
    }
  }
  .card-title {
    background: #fafafa;
    font-size: 13px;
    width: 1200px;
    overflow: hidden;
    line-height: 44px;
    -webkit-box-shadow: 0 2px 5px 0 rgba(146, 146, 146, 0.1);
    box-shadow: 0 2px 5px 0 rgba(146, 146, 146, 0.1);
    margin: 30px 0 20px 0;
    border-radius: 5px;
    .title-list {
      height: 44px;
    }
  }
  .shop-card {
    background-color: #ffffff;
    padding: 20px 0px;
    .shop-list {
      border-top: 2px dashed #f1f1f1;
      margin-bottom: 10px;
      padding-top: 10px;
      .list-image {
        height: 100px;
        img {
          height: 100%;
          border-radius: 5px;
        }
      }
      .list-title {
        cursor: pointer;
        font-weight: 600;
      }
      .list-parts {
        font-size: 14px;
        margin-top: 10px;
      }
      .list-num {
        padding: 38px 0px;
        .number {
          height: 22px;
          width: 94px;
          border: 1px solid #e7e7e7;
          input[type="button"] {
            width: 22px;
            border: none;
            font-size: 18px;
            line-height: 22px;
            cursor: pointer;
            outline-color: #ffffff;
          }
          input[type="text"] {
            width: 48px;
            border: solid #e7e7e7;
            border-width: 0 1px;
            height: 22px;
            display: block;
            float: left;
            background: #fff;
            outline: none;
            text-align: center;
          }
          .minus {
            float: left;
            height: 22px;
          }
          .plus {
            height: 22px;
          }
        }
      }
      .list-price,
      .list-total,
      .list-delete {
        height: 100%;
        line-height: 100px;
      }
    }
    .shop-list-0 {
      border: none;
    }
    .shop-buy {
      padding-top: 20px;
      border-top: 2px solid #e0e0e0;
      .all {
        line-height: 30px;
      }
      .cleanall {
        cursor: pointer;
      }
      .card {
        float: right;
        width: 114px;
        height: 30px;
        line-height: 30px;
        text-align: center;
        cursor: pointer;
        background: #684029;
        color: #fff;
      }
    }
  }
}
</style>