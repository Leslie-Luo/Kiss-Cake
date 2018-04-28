<template>
  <el-dialog title="修改密码" :visible.sync="dialogVisible" width="300px" :before-close="handleClose">
    <el-form :model="ruleForm" :rules="rules" ref="ruleForm" class="ruleForm">
      <el-form-item prop="password">
        <el-input v-model="ruleForm.password" type="password" placeholder="请输入新密码"></el-input>
      </el-form-item>
      <el-form-item style="text-align: center;">
        <el-button type="primary" @click="submitForm('ruleForm')">修改</el-button>
      </el-form-item>
    </el-form>
  </el-dialog>
</template>
<script>
import { getServer } from "@/assets/js/server.js";
export default {
  name: "Modify",
  data() {
    return {
      server: "",
      dialogVisible: false,
      ruleForm: {
        password: ""
      },
      rules: {
        password: [
          { required: true, message: "请输入新密码", trigger: "blur" },
          { min: 6, max: 12, message: "长度在 6 到 12 个字符", trigger: "blur" }
        ]
      }
    };
  },
  created: function() {
    let server = getServer();
    this.server = server;
  },
  methods: {
    ShowModify() {
      this.dialogVisible = true;
    },
    handleClose(done) {
      done();
      this.$refs.ruleForm.resetFields();
    },
    submitForm(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          let arr = Object.keys(this.ruleForm);
          let Postvalue = new Array();
          for (let x = 0; x < arr.length; x++) {
            Postvalue =
              "`" + arr[x] + "`" + "=" + "'" + this.ruleForm[arr[x]] + "'";
          }
          this.$http
            .post(
              this.server + "insert.php",
              {
                action: "ModifyAdmin",
                id: localStorage.getItem("Adminid"),
                password: this.ruleForm.password,
                Postvalue: Postvalue
              },
              { emulateJSON: true }
            )
            .then(
              response => {
                let data = response.body;
                if (data.code == "0") {
                  this.$refs.ruleForm.resetFields();
                  this.dialogVisible = false;
                  this.$message({
                    message: data.msg,
                    type: "success"
                  });
                } else {
                  this.$message.error(data.msg);
                }
              },
              response => {}
            );
          console.log(Postvalue);
        } else {
          this.$message({
            message: "请按照错误提示正确填写",
            type: "warning"
          });
          return false;
        }
      });
    }
  }
};
</script>
<style>
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader .el-upload:hover {
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
.avatar-uploader {
  text-align: center;
}
.image {
  width: auto;
  max-width: 80%;
  height: auto;
  max-height: 180px;
}
.ruleForm {
  width: 66%;
  margin-top: 20px;
  margin-left: 17%;
}
</style>


