<template>
  <div id="Details">
    <el-row>
      <el-col :span="21">
        <el-carousel ref="carousel" :interval="5000" arrow="never" :height="this.carouselHeight()" class="carousel" @change="carouselChange">
          <el-carousel-item v-for="item in this.bannerList" :key="item.key" :style="{backgroundImage: 'url('+ server + item.url + ')'}">
          </el-carousel-item>
        </el-carousel>
      </el-col>
      <el-col :span="3">
        <div class="banner-right" :style="{height: this.carouselHeight()}">
          <el-row class="bannerImgList">
            <el-col class="ImgList" :span="24" v-for="item in this.bannerList" :key="item.key" :class="item.id == '0' ? 'banner-active' : ''">
              <img :src="server + item.url" alt="Kiss Cake" :id="item.id" v-on:mouseenter="hiddenDetail(item.id)">
            </el-col>
          </el-row>
        </div>
      </el-col>
    </el-row>
    <Buy :CakeInfo="cakeInfo"></Buy>
    <div class="infodata">
      <img v-for="item in infodataList" :key="item.key" :src="server + item" width="100%" alt="">
    </div>
  </div>
</template>
<script>
import $ from "jquery";
import Buy from "./module/Buy";
import { getServer } from "@/assets/js/server.js";
export default {
  name: "Details",
  components: {
    Buy
  },
  data() {
    return {
      server: "",
      cakeInfo: {
        name: "",
        type: "",
        taste: [],
        spec: [],
        tag: [],
        default_price: "",
        articleid: "",
        catalog: ""
      },
      bannerList: [],
      infodataList: []
    };
  },
  beforeMount() {
    $("html,body").animate({ scrollTop: 0 }, 0);
  },
  mounted() {
    let id = "";
    if (this.$route.params.id == null) {
      id = localStorage.getItem("showID");
    } else {
      id = this.$route.params.id;
      localStorage.setItem("showID", id);
    }
    this.server = getServer();
    let server = getServer() + "BuyCake.php";
    this.$http
      .post(server, { action: "GetCakeInfo", id: id }, { emulateJSON: true })
      .then(
        response => {
          if (response.body.code == "0") {
            let data = response.body.data;
            this.cakeInfo = data;
            this.bannerList = data.banner;
            this.infodataList = data.infodata;
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
  methods: {
    carouselHeight() {
      if ($(document).width() > 1600) {
        return "610px";
      } else {
        return "520px";
      }
    },
    carouselChange(val) {
      $(".banner-active").removeClass("banner-active");
      $("#" + val)
        .parent()
        .addClass("banner-active");
    },
    hiddenDetail(val) {
      this.$refs.carousel.setActiveItem(val);
      $(".active").removeClass("banner-active");
      $("#" + val)
        .parent()
        .addClass("banner-active");
    }
  }
};
</script>
<style lang="less">
#Details{
  margin-bottom: 50px;
.carousel {
  margin-top: 10px;
}
@media (max-width: 1600px) {
  .carousel {
    width: 1050px;
  }
}
.el-carousel__item:nth-child(2n) {
  background-color: #99a9bf;
}

.el-carousel__item:nth-child(2n + 1) {
  background-color: #d3dce6;
}
.banner-right {
  position: relative;
  .bannerImgList {
    position: absolute;
    width: 90px;
    bottom: 0;
    left: 50%;
    margin-left: -45px;
    .ImgList {
      height: 50px;
      width: 90px;
      margin-top: 20px;
      margin-bottom: 2px;
      cursor: pointer;
      background-size: auto 100%;
      img {
        height: 48px;
        width: 88px;
      }
    }
    .banner-active {
      border: 1px solid #c69c6d;
    }
  }
}
.infodata {
  img {
    padding: 0px;
    margin: 0px;
    display: block;
  }
}
}
</style>

