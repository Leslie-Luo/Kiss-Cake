<template>
    <div id="carousel">
        <div class="carousel-list">
            <div class="add-banner">
                <el-row :gutter="20">
                    <el-col v-for="item in bannerList" :key="item.key" :span="6">
                        <el-card class="banner-card">
                          <el-row :gutter="20">
                            <el-col :span="20">{{item.name}}</el-col>
                            <el-col :span="4"><i class="el-icon-delete" @click="DeleteBanner(item)"></i></el-col>
                          </el-row>
                        </el-card>
                    </el-col>
                    <el-col :span="6" v-if="AddBT">
                      <el-button @click="showAdd()" style="margin-top:12px;">添加轮播图</el-button>
                    </el-col>  
                </el-row>
            </div>
            <el-carousel v-if="ShowCarousel" :interval="4000" v-bind:height="this.Height()">
                <el-carousel-item v-for="item in bannerList" :key="item.key">
                    <img :src="server + item.image" alt="" style="width:100%; height；auto;">
                </el-carousel-item>
            </el-carousel>
        </div>
        <el-dialog center :show-close="false" title="添加轮播图" :visible.sync="dialogVisible" width="30%">
            <div>
                <el-upload class="avatar-uploader" ref="banner" :show-file-list="false" action="#" :on-change="beforeAvatarUpload" :auto-upload="false">
                    <img v-if="imageUrl" :src="imageUrl" style="width: 178px;height: 178px;display: block;">
                    <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                </el-upload>
            </div>
            <div style="text-align:center">
                <el-select v-model="selectCake" filterable placeholder="请选择对应商品">
                    <el-option v-for="item in cakeList" :key="item.id" :label="item.name" :value="item.id">
                    </el-option>
                </el-select>
            </div>
            <span slot="footer" class="dialog-footer">
                <el-button @click="Close()">取 消</el-button>
                <el-button type="primary" @click="AddBanner()">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>
<script>
import { getServer } from "@/assets/js/server.js";
export default {
  name: "Craousel",
  data() {
    return {
      bannerList: [],
      dialogVisible: false,
      ShowCarousel: true,
      AddBT: true,
      imageUrl: "",
      server: "",
      cakeList: [],
      selectCake: ""
    };
  },
  created: function() {
    let server = getServer();
    this.server = server;
    this.getBanner();
  },
  methods: {
    getBanner() {
      this.$http
        .post(
          this.server + "select.php",
          { action: "getBanner" },
          { emulateJSON: true }
        )
        .then(
          response => {
            let data = response.body;
            if (data.code == "0") {
              this.bannerList = data.bannerList;
              if(data.bannerList.length == 0){
                this.ShowCarousel = false;
              }
              if(data.bannerList.length == 4){
                this.AddBT = false;
              }
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
    Height() {
      let height = document.body.clientHeight - 180 + "px";
      return height;
    },
    showAdd() {
      this.dialogVisible = true;
      this.$http
        .post(
          this.server + "select.php",
          { action: "cakeList" },
          { emulateJSON: true }
        )
        .then(
          response => {
            let data = response.body;
            if (data.code == "0") {
              this.cakeList = data.data;
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
    beforeAvatarUpload(file) {
      this.imageUrl = URL.createObjectURL(file.raw);
    },
    AddBanner() {
      if (this.imageUrl == "") {
        this.$message({
          message: "请添加轮播图",
          type: "warning"
        });
        return false;
      } else if (this.selectCake == "") {
        this.$message({
          message: "请选择对应商品",
          type: "warning"
        });
        return false;
      }
      var formData = new FormData();
      formData.append("action", "AddBanner");
      formData.append("id", this.selectCake);
      formData.append("banner", this.$refs.banner.uploadFiles["0"].raw);
      this.$http
        .post(this.server + "insert.php", formData, { emulateJSON: true })
        .then(
          response => {
            let data = response.body;
            if (data.code == "0") {
              this.getBanner();
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
            this.Close();
          },
          response => {}
        );
    },
    Close() {
      this.dialogVisible = false;
      this.imageUrl = "";
      this.selectCake = "";
    },
    DeleteBanner(item){
      var formData = new FormData();
      formData.append("action", "DeleteBanner");
      formData.append("id", item.id);
      formData.append("banner", item.image);
      this.$http
        .post(this.server + "insert.php", formData, { emulateJSON: true })
        .then(
          response => {
            let data = response.body;
            if (data.code == "0") {
              this.getBanner();
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
            this.Close();
          },
          response => {}
        );
    }
  }
};
</script>
<style lang="less">
#carousel {
  .carousel-list {
    .add-banner {
      text-align: center;
      margin-bottom: 15px;
      overflow: hidden; /*超出部分隐藏*/
      white-space: nowrap; /*不换行*/
      text-overflow: ellipsis; /*超出部分文字以...显示*/
    }
    .banner-card {
      img {
        width: 100%;
        height: auto;
      }
      .el-icon-delete:hover{
        cursor: pointer;
        color: red;
      }
    }
    .el-upload {
      border: 1px dashed #d9d9d9;
      border-radius: 6px;
      cursor: pointer;
      position: relative;
      overflow: hidden;
    }
    .avatar-uploader {
      .el-upload:hover {
        border-color: #409eff;
      }
      .avatar-uploader-icon {
        font-size: 28px;
        color: #8c939d;
        width: 178px;
        height: 178px;
        line-height: 178px;
        text-align: center;
      }
    }
  }
}
</style>
