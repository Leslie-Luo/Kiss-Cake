<template>
  <div id="main">
    <el-row type="flex" id="login-box" justify="center">
      <el-col :span="9" class="box">
        <el-card class="box-card">
          <div slot="header" class="box-header">
            <span>Kiss Cake</span>
          </div>
          <el-form ref="loginForm" :model="login" :rules="rules" class="box-body">
            <el-form-item prop="name">
              <el-input v-model="login.name" placeholder="用户名"></el-input>
            </el-form-item>
            <el-form-item prop="password">
              <el-input v-model="login.password" placeholder="密码" type="password"></el-input>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="submitForm('loginForm')">登录</el-button>
            </el-form-item>
          </el-form>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { getServer } from "@/assets/js/server.js";
export default {
  name: "Login",
  data() {
    return {
      server: "",
      login: {
        name: "",
        password: ""
      },
      rules: {
        name: [
          { required: true, message: "请输入用户名", trigger: "blur" },
          { min: 4, max: 12, message: "长度在 4 到 12 个字符", trigger: "blur" }
        ],
        password: [
          { required: true, message: "请输入密码", trigger: "blur" },
          { min: 6, max: 12, message: "长度在 6 到 12 个字符", trigger: "blur" }
        ]
      }
    };
  },
  mounted() {
    let server = getServer();
    this.server = server;
  },
  methods: {
    submitForm(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          var formData = new FormData();
          formData.append("action", "adminlogin");
          var arr = Object.keys(this.login);
          for (let x = 0; x < arr.length; x++) {
            formData.append(arr[x], this.login[arr[x]]);
          }
          this.$http
            .post(this.server + "user.php", formData, {
              emulateJSON: true
            })
            .then(
              response => {
                let data = response.body;
                if (data.code == "0") {
                  localStorage.setItem("Adminid", data.info.id);
                  localStorage.setItem("Adminname", data.info.username);
                  localStorage.setItem("admintype", data.info.type);
                  localStorage.setItem("region", data.info.region);
                  this.$router.push("/");
                } else {
                  this.$notify.error({
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

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="less" scoped>
#main {
  height: 100vh;
  width: 100vw;
  min-width: 960px;
  min-height: 600px;
  background-color: #ffffff;
  background-image: url("../../assets/AdminLogin.png");
  background-size: 50%;
  background-repeat: no-repeat;
  background-position: left bottom;
  #login-box {
    height: 100%;
    width: 100%;
    .box {
      position: relative;
      .box-card {
        width: 100%;
        max-width: 400px;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        .box-header {
          text-align: center;
        }
        .box-body {
          text-align: center;
          width: 90%;
          margin-left: 5%;
        }
      }
    }
  }
}
</style>
