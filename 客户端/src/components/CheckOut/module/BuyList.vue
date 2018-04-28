<template>
    <div>
        <div v-for="(item,index) in buyList" :key="item.key" :class="'buy-list-' + index" class="buy-list">
            <el-row>
                <el-col :span="7">
                    <el-row>
                        <el-col :span="9">
                            <div class="list-image">
                                <img :src="server + item.img">
                            </div>
                        </el-col>
                        <el-col :span="15">
                            <div class="list-title">
                                {{item.name}}
                            </div>
                        </el-col>
                    </el-row>
                </el-col>
                <el-col :span="3">
                    <div class="list-price">
                        {{Explain[item.spec].cutlery_content}}
                    </div>
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
                <el-col :span="3">
                    <div class="list-num">
                        x {{item.num}}份
                    </div>
                </el-col>

                <el-col :span="4">
                    <div class="list-total">
                        ￥{{item.price * item.num}}.00
                    </div>
                </el-col>
            </el-row>
        </div>
    </div>
</template>
<script>
import { getServer } from "@/assets/js/server.js";
export default {
  name: "BuyList",
  data() {
    return {
      buyList: "",
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
  beforeMount() {
    this.server = getServer();
  },
  mounted() {
    this.buyList = JSON.parse(localStorage.getItem("buyList"));
  }
};
</script>
<style lang="less">
.buy-list {
  border-top: 2px dashed #f1f1f1;
  .list-image {
    height: 100px;
    img {
      height: 100%;
      border-radius: 5px;
    }
  }
  .list-title {
    font-weight: 600;
  }
  .list-parts {
    font-size: 14px;
    margin-top: 10px;
  }
  .list-title,
  .list-num,
  .list-price,
  .list-total,
  .list-delete {
    height: 100px;
    line-height: 100px;
  }
}
.buy-list-0 {
  border: none;
}
</style>
