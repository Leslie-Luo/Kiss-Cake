<template>
  <el-row class="Buy-Box">
    <el-col :span="12">
      <h1 class="Buy-CakeName" v-html="this.CakeInfo.name"></h1>
      <div class="label">
        <el-tag v-for="item in this.CakeInfo.tag" :key="item.key" v-on:click.native="ToTagPage(item)" size="small">{{item.text}} &gt;</el-tag>
      </div>
      <p class="fresh" v-once>
        <icon name="snowflake-o" class="snowflake"></icon>保鲜条件：0－4℃保藏12小时，5℃食用为佳</p>
    </el-col>
    <el-col :span="12">
      <div class="spec-info">
        <div>
          <el-row>
            <el-col :span="4">
              <icon name="archive"></icon>{{ToExplain('size')}}
            </el-col>
            <el-col :span="6">
              <icon name="users"></icon>{{ToExplain('suite_amount')}}
            </el-col>
            <el-col :span="5">
              <icon name="cutlery"></icon>{{ToExplain('cutlery_content')}}
            </el-col>
          </el-row>
        </div>
      </div>
      <div class="buy-cake">
        <p class="buySpec" v-for="item in this.CakeInfo.spec" :key="item.key" v-if="item.size == buySpec">
          {{item.price}}
        </p>
        商品规格：
        <a href="javascript:void(0);" v-for="item in this.CakeInfo.spec" :key="item.key" size="small" :class="item.size == buySpec ? 'buy-active' : ''" @click="changeBuySpec(item.size)">{{item.size}}磅</a>
      </div>
      <div>
        <div class="details-button">
          <el-popover ref="popover" placement="top" width="160" v-model="visible">
            <p style="text-align: center;">
              <i class="el-icon-success"></i>添加购物车成功</p>
            <div style="text-align: center; margin: 10px 0">
              <el-button size="mini" @click="gotoCard()">查看购物车</el-button>
            </div>
          </el-popover>
          <div href="javascript:void(0);" class="details-but details-but-buy" @click="addcard('gotoCard')">立即购买</div>
          <div v-popover:popover href="javascript:void(0);" class="details-but details-but-cart" @click="addcard('')">加入购物车
          </div>
        </div>
      </div>
    </el-col>
  </el-row>
</template>
<script>
import "vue-awesome/icons";
import Icon from "vue-awesome/components/Icon";
export default {
  name: "Buy",
  components: {
    Icon
  },
  props: {
    CakeInfo: Object
  },
  data() {
    return {
      Explain: {
        "1": {
          size: "13x13cm",
          cutlery_content: "含5套餐具",
          suite_amount: "适合3-4人分享"
        },
        "2": {
          size: "18x18cm",
          cutlery_content: "含10套餐具",
          suite_amount: "适合7-8人分享"
        },
        "3": {
          size: "23x23cm",
          cutlery_content: "含15套餐具",
          suite_amount: "适合11-12人分享"
        },
        "5": {
          size: "29x29cm",
          cutlery_content: "含20套餐具",
          suite_amount: "适合15-20人分享"
        }
      },
      buySpec: "",
      visible: false
    };
  },
  mounted() {
    this.buySpec = this.CakeInfo.default_price;
  },
  methods: {
    changeBuySpec(val) {
      this.buySpec = val;
    },
    ToExplain(type) {
      let val = this.Explain;
      if (this.buySpec == "") {
        this.buySpec = this.CakeInfo.default_price;
      }
      for (let item in val) {
        if (item == this.buySpec) {
          return val[item][type];
        }
      }
    },
    AddToCard(id, spec) {},
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
                this.visible = true;
              }, 100);
              setTimeout(() => {
                this.visible = false;
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
        this.visible = true;
      }, 100);
      setTimeout(() => {
        this.visible = false;
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
.Buy-Box {
  padding-bottom: 10px;
  border-bottom: #d8d8d8 solid 1px;
  margin: 20px 0;
  .Buy-CakeName {
    color: #684029;
    margin-bottom: 5px;
  }
  .label {
    margin: 15px 0;
    .el-tag {
      color: #684029;
      padding: 0 10px;
      margin-right: 5px;
      height: 26px;
      border-color: #684029;
      border-width: 2px;
      font-weight: 600;
      background-color: rgba(255, 255, 255, 0);
      border-radius: 100px;
      cursor: pointer;
    }
  }
  .fresh {
    font-size: 14px;
    margin-top: 5px;
    .snowflake {
      margin-right: 5px;
      path {
        color: #b4e4f5;
      }
    }
  }
  .spec-info {
    color: #684029;
    .fa-icon {
      margin-right: 5px;
    }
  }
  .buy-cake {
    color: #684029;
    .buySpec {
      color: #c69c6d;
      font-size: 24px;
      font-weight: 500;
    }
    a {
      display: inline-block;
      box-sizing: border-box;
      font-size: 12px;
      color: #7a5844;
      border: 1px solid #d0c3bb;
      padding: 6px 12px;
      margin: 2px;
      position: relative;
      text-decoration: none;
      outline: none;
      cursor: pointer;
      -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
      -webkit-tap-highlight-color: transparent;
    }
    a.buy-active {
      border: 1px solid #684029;
      color: #684029;
    }
  }
  .details-button {
    margin-top: 10px;
    width: 344px;
    height: 40px;
    font-size: 13px;
    .details-but {
      text-align: center;
      width: 167px;
      height: 30px;
      line-height: 30px;
      border: none;
      cursor: pointer;
    }
    .details-but-buy {
      float: left;
      background: #ffffff;
      color: #7a5844;
      border: 1px solid #684029;
    }
    .details-but-cart {
      float: right;
      background: #684029;
      color: #fff;
    }
  }
}
</style>