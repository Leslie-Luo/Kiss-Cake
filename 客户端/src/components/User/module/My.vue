<template>
  <div id="My">
    <el-row :gutter="20">
      <el-col :span="24" class="info">
        <el-row :gutter="25">
          <el-col :span="24" class="info-header">
            <div class="header-image" @click="changImage()" v-on:mouseenter="show()" v-on:mouseleave="hide()">
              <i class="el-icon-edit edit_icon"></i>
              <img :src="header()" alt="点击修改头像">
              <input type="file" class="change_image" @change="imageChange()">
            </div>
          </el-col>
          <el-col :span="24" class="info-text">
            <div>
              {{username()}}
            </div>
            <div>
              {{phone()}}
              <i class="el-icon-edit" @click="modify('phone')"></i>
            </div>
          </el-col>
          <el-col :span="24">
            <p class="change_password" @click="modify('password')">修改密码</p>
          </el-col>
        </el-row>
      </el-col>
    </el-row>
    <el-dialog title="修改头像" :visible.sync="dialogChangImage" width="60%">
      <vueCropper style="height:400px;width:100%;" class="cropper" ref="cropper" :autoCrop="option.autoCrop" :img="this.option.img" :outputType="option.outputType" :fixed="option.fixed" :fixedNumber="option.fixedNumber"></vueCropper>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="finish('blob')">确 定</el-button>
      </span>
    </el-dialog>
    <el-dialog :title="modify_type === 'password' ? '修改密码' : '修改手机号码'" :visible.sync="dialogVisible" width="30%" :before-close="Close">
      <el-form ref="modifyPw" :model="Modify" :rules="rules">
        <el-form-item prop="password" v-if="modify_type === 'password'">
          <el-input v-model="Modify.password" placeholder="请输入新密码 6~12 位" type="password"></el-input>
        </el-form-item>
        <el-form-item prop="phone" v-if="modify_type === 'phone'">
          <el-input v-model="Modify.phone" placeholder="请输入新的手机号码" type="num"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="changePw()">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>
<script>
import { getServer } from "@/assets/js/server.js";
import VueCropper from "vue-cropper";
export default {
  name: "My",
  components: {
    VueCropper
  },
  data() {
    var checkPhone = (rule, value, callback) => {
      if (!value) {
        return callback(new Error("联系方式不能为空"));
      }
      if (!/^1[34578]\d{9}$/.test(value)) {
        callback(new Error("手机号码有误，请重填"));
      } else {
        callback();
      }
    };
    return {
      option: {
        img: "",
        outputType: "png",
        autoCrop: true,
        fixed: true,
        fixedNumber: [1, 1]
      },
      dialogChangImage: false,
      dialogVisible: false,
      modify_type: "",
      Modify: {
        phone: "",
        password: ""
      },
      rules: {
        phone: [{ validator: checkPhone, trigger: "blur" }],
        password: [
          { required: true, message: "请输入新密码", trigger: "blur" },
          { min: 6, max: 12, message: "长度在 6 到 12 个字符", trigger: "blur" }
        ]
      }
    };
  },
  methods: {
    header() {
      if (localStorage.getItem("header") == "1") {
        return getServer() + "image/header/header.png";
      } else {
        return getServer() + localStorage.getItem("header");
      }
    },
    username() {
      return localStorage.getItem("username");
    },
    phone() {
      return localStorage.getItem("phone");
    },
    email() {
      return localStorage.getItem("email");
    },
    modify(str) {
      this.modify_type = str;
      this.dialogVisible = true;
    },
    Close() {
      this.$refs.modifyPw.resetFields();
      this.dialogVisible = false;
    },
    show() {
      document.getElementsByClassName("edit_icon")["0"].style.display = "block";
    },
    hide() {
      document.getElementsByClassName("edit_icon")["0"].style.display = "none";
    },
    changImage() {
      document.getElementsByClassName("change_image")["0"].click();
    },
    imageChange() {
      var _this = this;
      var file = document.getElementsByClassName("change_image")["0"].files[
        "0"
      ];
      var reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onloadend = function() {
        _this.dialogChangImage = true;
        _this.option.img = reader.result;
      };
    },
    finish(type) {
      let server = getServer() + "user.php";
      this.$refs.cropper.getCropBlob(data => {
        var formData = new FormData();
        formData.append("action", "ChangeHeader");
        formData.append("userid", localStorage.getItem("id"));
        if (localStorage.getItem("header") == "1") {
          formData.append("type", "1");
        } else {
          formData.append("type", "2");
          formData.append("headerUrl", localStorage.getItem("header"));
        }
        formData.append("header", data);
        this.$http.post(server, formData, { emulateJSON: true }).then(
          response => {
            if (response.body.code == "0") {
              this.$notify({
                title: "成功",
                message: response.body.msg,
                type: "success"
              });
              localStorage.setItem("header", response.body.Url);
            } else {
              this.$notify.error({
                title: "错误",
                message: response.body.msg
              });
            }
            this.dialogChangImage = false;
          },
          response => {}
        );
      });
    },
    changePw() {
      let server = getServer() + "user.php";
      var formData = new FormData();
      if (this.modify_type === "password") {
        formData.append("action", "modifyPw");
        formData.append("id", localStorage.getItem("id"));
        formData.append("newPw", this.Modify.password);
      } else {
        formData.append("action", "modifyPhone");
        formData.append("id", localStorage.getItem("id"));
        formData.append("newPhone", this.Modify.phone);
      }
      this.$http.post(server, formData, { emulateJSON: true }).then(
        response => {
          if (response.body.code == "0") {
            this.$notify({
              title: "成功",
              message: response.body.msg,
              type: "success"
            });
            if (this.modify_type === "phone") {
              localStorage.setItem("phone", this.Modify.phone);
            }
          } else {
            this.$notify.error({
              title: "错误",
              message: response.body.msg
            });
          }
          this.$refs.modifyPw.resetFields();
          this.dialogVisible = false;
        },
        response => {}
      );
    }
  }
};
</script>
<style lang="less">
#My {
  .info {
    text-align: center;
    margin-top: 20px;
    .info-header {
      height: 150px;
      width: 100%;
      .header-image {
        position: relative;
        width: 150px;
        height: 150px;
        margin: 0 auto;
        border: 1px solid #ffffff;
        img {
          width: 100%;
        }
        .edit_icon {
          position: absolute;
          font-size: 30px;
          line-height: 150px;
          width: 150px;
          color: #ffffff;
          transition: opacity 0.3s;
          display: none;
          border-radius: 6px;
          background-color: rgba(0, 0, 0, 0.5);
          cursor: pointer;
        }
        .change_image {
          display: none;
        }
      }
    }
    .info-text {
      margin: 20px 0;
      font-size: 20px;
      line-height: 40px;
      font-weight: 600;
      .el-icon-edit {
        margin-left: 5px;
        font-size: 16px;
      }
      .el-icon-edit:hover {
        color: #f34c4c;
        cursor: pointer;
      }
    }
    .change_password {
      margin: 0 auto;
      width: 114px;
      height: 30px;
      line-height: 30px;
      cursor: pointer;
      background: #684029;
      color: #fff;
    }
  }
}
</style>
