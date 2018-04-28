<template>
  <div>
    <el-row>
      <el-col :span="24">
        <el-card class="cake" :body-style="{ padding: '0px',margin: 'auto',  width: '228px'}">
          <img :src="server + CakeInfo.iconimg" @click="Details(CakeInfo.id)" class="image" width="228px" height="246px">
          <div>
            <span @click="Details(CakeInfo.id)" style="font-size: 16px;font-weight: 600;cursor:pointer;color:#684029;">{{CakeInfo.name}}</span>
            <div>
              <el-tag v-for="item in this.CakeInfo.tag" :key="item.key" v-on:click.native="ToTagPage(item)" size="small">{{item.text}} &gt;</el-tag>
            </div>
          </div>
          <div class="bottom clearfix">
            <span class="spec" v-for="item in this.CakeInfo.spec" :key="item.key" v-if="item.size == default_price">{{item.price}}</span>
            <div id="shop" type="text" class="card" @click="show = !show">加入购物车</div>
          </div>
          <el-collapse-transition>
            <div id="shop" class="spec-detail" v-show="this.show">
              <div class="choice" v-show="!this.successshow">
                <div class="spec-title" v-for="item in this.CakeInfo.spec" :key="item.key" v-if="item.size == buySpec">{{item.price}}</div>
                <div class="spec-info">
                  <el-row>
                    <el-col :span="6" v-for="item in this.CakeInfo.spec" :key="item.key" size="small">
                      <a href="javascript:void(0);" :class="item.size == buySpec ? 'active' : ''" @click="changeBuySpec(item.size)">{{item.size}}磅
                        <i></i>
                      </a>
                    </el-col>
                  </el-row>
                </div>
                <div class="buttons">
                  <div class="button left buy-now" @click="addcard('gotoCard')">立即购买</div>
                  <div class="button coffee right" @click="addcard('')">加入购物车</div>
                </div>
              </div>
              <div class="success" v-show="this.successshow">
                <p>加入购物车成功!</p>
                <div class="button" @click="gotoCard()">前往购物车</div>
              </div>
            </div>
          </el-collapse-transition>
        </el-card>
      </el-col>
    </el-row>
    <div>
      <div class="layer-shade" v-show="this.show"></div>
    </div>
  </div>
</template>
<script>
import $ from "jquery";
import { getServer } from "@/assets/js/server.js";
export default {
  name: "Cake",
  props: {
    CakeInfo: Object
  },
  data() {
    return {
      buySpec: "",
      show: false,
      successshow: false
    };
  },
  beforeMount() {
    this.server = getServer();
    this.default_price = this.CakeInfo.default_price;
  },
  mounted() {
    this.buySpec = this.CakeInfo.default_price;
    let _this = this;
    $("body").click(function(e) {
      var e = e || window.event;
      var elem = e.target || e.srcElement;
      while (elem) {
        if (elem.id && elem.id == "shop") {
          return;
        }
        elem = elem.parentNode;
      }
      _this.show = false;
    });
    $(".spec-info a").click(function() {
      $(this)
        .parent()
        .siblings()
        .children(".active")
        .removeClass("active");
      $(this).addClass("active");
    });
  },
  methods: {
    changeBuySpec(val) {
      this.buySpec = val;
    },
    Details: function(id) {
      this.$router.push({ name: "Kiss Cake-商品详情", params: { id: id } });
    },
    addcard(val) {
      let buy = {};
      buy["id"] = this.CakeInfo.id;
      buy["buy"] = "1";
      buy["spec"] = this.buySpec;
      buy["name"] = this.CakeInfo.name;
      buy["img"] = this.CakeInfo.iconimg;
      buy["num"] = "1";
      for (let x = 0; x < this.CakeInfo.spec.length; x++) {
        const element = this.CakeInfo.spec[x];
        if (element.size == this.buySpec) {
          buy["price"] = element.price.split("￥")["0"];
        }
      }
      if (localStorage.getItem("shoplist") == null) {
        let list = new Array();
        list.push(buy);
        this.$store.state.user.buynum = "1";
        localStorage.setItem("shoplist", JSON.stringify(list));
      } else {
        let shopList = JSON.parse(localStorage.getItem("shoplist"));
        for (let x = 0; x < shopList.length; x++) {
          if (this.CakeInfo.id == shopList[x].id) {
            if (this.buySpec == shopList[x].spec) {
              let num = parseInt(shopList[x].num) + 1;
              shopList[x].num = num;
              localStorage.setItem("shoplist", JSON.stringify(shopList));
              if (val == "gotoCard") {
                this.$router.push({ name: "购物车" });
                return true;
              }
              setTimeout(() => {
                this.successshow = true;
              }, 100);
              setTimeout(() => {
                this.successshow = false;
                this.show = false;
              }, 1800);
              return true;
            }
          }
        }
        let list = JSON.parse(localStorage.getItem("shoplist"));
        list.push(buy);
        this.$store.state.user.buynum = list.length;
        localStorage.setItem("shoplist", JSON.stringify(list));
      }
      if (val == "gotoCard") {
        this.$router.push({ name: "购物车" });
        return true;
      }
      setTimeout(() => {
        this.successshow = true;
      }, 100);
      setTimeout(() => {
        this.successshow = false;
        this.show = false;
      }, 1800);
    },
    gotoCard() {
      this.$router.push({ name: "购物车" });
    },
    ToTagPage(val){
      this.$router.push({ path: `./../Tag/${val.text}` });
    }
  }
};
</script>
<style lang="less">
.cake {
  border: none;
  box-shadow: none;
  margin-top: 20px;
  box-shadow: 0 2px 5px 0 rgba(146, 146, 146, 0.1);
  .image {
    cursor: pointer;
  }
  .el-tag {
    color: #684029;
    padding: 0 10px;
    margin: 5px 0;
    margin-right: 5px;
    height: 26px;
    border-color: #684029;
    border-width: 1.5px;
    font-weight: 600;
    background-color: rgba(255, 255, 255, 0);
    border-radius: 100px;
    z-index: 999;
    cursor: pointer;
  }
  .bottom {
    border-top: 1px dashed #d5bfa7;
    height: 37px;
    color: #b0986f;
    margin-top: 6px;
    padding-top: 6px;
    -webkit-font-smoothing: antialiased;
    .spec {
      display: inline-block;
      line-height: 30px;
      color: #824a11;
      font-size: 16px;
      font-weight: 700;
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
  .spec-detail {
    position: absolute;
    box-sizing: border-box;
    padding: 12px;
    background: #f8f8f8;
    width: 100%;
    bottom: 0;
    left: 0;
    z-index: 1001;
    -webkit-box-shadow: 0px 2px 2px 0px rgba(195,195,195,0.50);
    box-shadow: 0px 2px 2px 0px rgba(195,195,195,0.50);
    .choice {
      .spec-title {
        font-size: 16px;
        color: #684029;
      }
      .spec-info {
        padding: 10px 0;
        a {
          display: inline-block;
          box-sizing: border-box;
          font-size: 12px;
          color: #7a5844;
          border: 2px solid #d0c3bb;
          padding: 6px 12px;
          margin: 2px;
          position: relative;
          text-decoration: none;
          outline: none;
          font-weight: 500;
          cursor: pointer;
          -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
          -webkit-tap-highlight-color: transparent;
        }
        a.active {
          border: 2px solid #684029;
          color: #684029;
        }
      }
      .buttons {
        color: #684029;
        .left {
          float: left;
        }
        .buy-now {
          color: #7a5844;
        }
        .button {
          width: 114px;
          height: 30px;
          line-height: 30px;
          text-align: center;
          background: #fff;
          color: #7a5844;
          cursor: pointer;
          margin: 8px 0;
          border: 1px solid #684029;
        }
        .right {
          float: right;
        }
        .coffee {
          background: #684029;
          color: #fff;
        }
      }
    }
    .success {
      margin: 40px 0;
      text-align: center;
      .button {
        width: 114px;
        height: 30px;
        line-height: 30px;
        text-align: center;
        background: #7a5844;
        color: #ffffff;
        cursor: pointer;
        margin: 8px auto;
        border: 1px solid #684029;
      }
    }
  }
}
.layer-shade {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: transparent;
  z-index: 999;
}
</style>
