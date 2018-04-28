<template>
  <div id="UserSign">
    <div id="login_bg"></div>
    <el-card class="sign-box">
      <el-tabs v-model="activeName">
        <el-tab-pane label="登录" name="signIn">
          <el-form ref="signInForm" :model="signIn" :rules="rules" class="signIn">
            <el-form-item prop="phone">
              <el-input v-model="signIn.phone" placeholder="手机号码"></el-input>
            </el-form-item>
            <el-form-item prop="password">
              <el-input v-model="signIn.password" placeholder="密码" type="password"></el-input>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" class="button" @click="submitForm('signInForm','signIn')">登录</el-button>
            </el-form-item>
          </el-form>
        </el-tab-pane>
        <el-tab-pane label="注册" name="signUp">
          <el-form ref="signUpForm" :model="signUp" :rules="rules" class="signUp">
            <el-form-item prop="name">
              <el-input v-model="signUp.name" placeholder="昵称" type="text"></el-input>
            </el-form-item>
            <el-form-item prop="phone">
              <el-input v-model="signUp.phone" placeholder="手机号码" type="text"></el-input>
            </el-form-item>
            <el-form-item prop="email">
              <el-input v-model="signUp.email" placeholder="邮箱"></el-input>
            </el-form-item>
            <el-form-item prop="password">
              <el-input v-model="signUp.password" placeholder="密码 6~12 位" type="password"></el-input>
            </el-form-item>
            <el-form-item prop="checkPass">
              <el-input type="password" v-model="signUp.checkPass" placeholder="确认密码"></el-input>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" class="button" @click="submitForm('signUpForm','signUp')">注册</el-button>
            </el-form-item>
          </el-form>
        </el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>
<script>
import $ from "jquery";
import { getServer } from "@/assets/js/server.js";
import Background_1 from "@/assets/images/sign/Background_1.jpg";
export default {
  name: "UserSign",
  data() {
    var validatePass = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请再次输入密码"));
      } else if (value !== this.signUp.password) {
        callback(new Error("两次输入密码不一致!"));
      } else {
        callback();
      }
    };
    return {
      activeName: "signIn",
      signIn: {
        phone: "",
        password: ""
      },
      signUp: {
        name: "",
        phone: "",
        email: "",
        password: "",
        checkPass: ""
      },
      rules: {
        name: [
          { required: true, message: "请输入昵称", trigger: "blur" },
          { min: 2, max: 8, message: "长度为 2-8个字符", trigger: "blur" }
        ],
        phone: [
          { required: true, message: "请输入手机号码", trigger: "blur" },
          { min: 11, max: 11, message: "长度为 11 个字符", trigger: "blur" }
        ],
        email: [
          { required: true, message: "请输入邮箱地址", trigger: "blur" },
          {
            type: "email",
            message: "请输入正确的邮箱地址",
            trigger: "blur,change"
          }
        ],
        password: [
          { required: true, message: "请输入密码", trigger: "blur" },
          { min: 6, max: 12, message: "长度在 6 到 12 个字符", trigger: "blur" }
        ],
        checkPass: [{ validator: validatePass, trigger: "blur" }]
      }
    };
  },
  beforeMount(){
  $('html,body').animate({scrollTop: 0}, 800);
  },
  mounted() {
    let type = this.$route.params.type;
    if (type == null) {
      this.activeName = "signIn";
    } else {
      this.activeName = type;
    }
    $("#login_bg").css("background-image", "url(" + Background_1 + ")");
  },
  methods: {
    submitForm(formName, type) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          let server = getServer() + "user.php";
          var formData = new FormData();
          formData.append("action", type);
          var arr = Object.keys(this[type]);
          for (let x = 0; x < arr.length; x++) {
            formData.append(arr[x], this[type][arr[x]]);
          }
          this.$http
            .post(server, formData, {
              emulateJSON: true
            })
            .then(
              response => {
                let data = response.body;
                if (data.code == "0") {
                  if (type == "signIn") {
                    localStorage.setItem("id", data.info.id);
                    localStorage.setItem("username", data.info.username);
                    localStorage.setItem("header", data.info.header);
                    localStorage.setItem("phone", data.info.phone);
                    localStorage.setItem("email", data.info.email);
                    this.$store.state.user.show = true;
                    this.$message({
                      message: "登录成功,即将返回上一个页面",
                      type: "success"
                    });
                    this.$refs[formName].resetFields();
                    setTimeout(() => {
                      history.go(-1);
                    }, 500);
                  } else {
                    this.$message({
                      message: data.msg,
                      type: "success"
                    });
                    this.signIn.phone = this.signUp.phone;
                    this.$refs[formName].resetFields();
                    this.activeName = "signIn";
                  }
                } else {
                  this.$message.error({
                    title: "错误",
                    message: data.msg
                  });
                }
              },
              response => {}
            );
        } else {
          return false;
        }
      });
    }
  }
};
</script>
<style lang="less">
#UserSign {
  height: calc(~"100vh - 80px");
  position: relative;
  #login_bg{
    width: 100vw;
    height: 100vh;
    position: fixed;
    top: 0;
    left: 0;
    z-index: 0;
  }
  .sign-box {
    width: 320px;
    position: absolute;
    top: 15%;
    right: 8%;
    border-width: 1px;
    border-style: solid;
    border-color: rgb(233, 233, 233);
    border-image: initial;
    background: rgb(255, 255, 255);
    box-shadow: 0 2px 4px -1px rgba(0, 0, 0, 0.2),
      0 4px 5px 0 rgba(0, 0, 0, 0.14), 0 1px 10px 0 rgba(0, 0, 0, 0.12);
    .el-tabs__nav {
      width: 100%;
      .el-tabs__active-bar {
        background-color: #684029;
      }
      .el-tabs__item {
        text-align: center;
        width: 50%;
      }
      .el-tabs__item:hover {
        color: #684029;
        cursor: pointer;
      }
      .is-active {
        color: #684029;
      }
    }
    .signIn,
    .signUp {
      .button {
        width: 100%;
        display: block;
        background: #442818;
        border-radius: 2px;
        font-size: 18px;
        border: none;
        span {
          color: #ffffff;
        }
      }
    }
  }
}
</style>
