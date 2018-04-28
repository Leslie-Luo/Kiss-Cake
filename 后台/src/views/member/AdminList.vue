<template>
  <div>
    <el-card>
      <div slot="header">
        <span>管理员列表</span>
        <div style="float:right">
          <el-pagination background layout="prev, pager, next" :page-size="20" :total="this.tableData.length" :current-page="this.current" @current-change="changePage">
          </el-pagination>
        </div>
        <span style="float:right">
          <el-button size="mini" icon="el-icon-plus" @click="AddAdmin">添加管理员</el-button>
        </span>
      </div>
      <el-table :data="viewlist" border style="width: 100%" v-bind:max-height="this.Height()">
        <el-table-column type="index" :index="indexMethod" align="center">
        </el-table-column>
        <el-table-column prop="username" label="用户名" width="180">
        </el-table-column>
        <el-table-column prop="city" label="区域">
        </el-table-column>
        <el-table-column prop="type" label="权限">
          <template slot-scope="scope">
            <p v-html="scope.row.type === 'Surper' ? '超级管理员' : '管理员'"></p>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="200" fixed="right" align="center">
          <template slot-scope="scope">
            <el-button size="mini" @click="ModifyInfo(scope.row.id)" :disabled="scope.row.type == 'Surper'">修改信息</el-button>
            <el-button size="mini" @click="Delete(scope.row.id)" type="danger" :disabled="scope.row.type == 'Surper'">删除账户</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
    <el-dialog :title="this.dialogTitle" :visible.sync="dialogVisible" width="350px" :before-close="handleClose">
      <el-form :model="ruleForm" :rules="rules" error="cuowu" ref="ruleForm" class="ruleForm">
        <el-form-item prop="username" :required="this.addAdmin">
          <el-input v-model="ruleForm.username" type="username" placeholder="用户名"></el-input>
        </el-form-item>
        <el-form-item prop="password" :required="this.addAdmin">
          <el-input v-model="ruleForm.password" type="password" placeholder="密码"></el-input>
        </el-form-item>
        <el-form-item prop="region" :required="this.addAdmin">
          <el-select style="width:100%" v-model="ruleForm.region" placeholder="区域">
            <el-option v-for="item in this.cityData" :key="item.id" :label="item.text" :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item style="text-align: center;">
          <el-button v-if="!this.addAdmin" type="primary" @click="submitForm()">{{this.dialogButton}}</el-button>
          <el-button v-if="this.addAdmin" type="primary" @click="ToAddAdmin()">{{this.dialogButton}}</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>
  </div>
</template>

<script>
import { adminlist } from "vuex";
import { getServer } from "@/assets/js/server.js";
export default {
  name: "AdminList",
  data() {
    return {
      tableData: [],
      cityData: [],
      viewlist: [],
      current: 1,
      dialogVisible: false,
      dialogTitle: "",
      dialogButton: "",
      addAdmin: false,
      ModifyID: "",
      ruleForm: {
        username: "",
        password: "",
        region: ""
      },
      rules: {
        username: [
          { min: 6, max: 12, message: "长度在 6 到 12 个字符", trigger: "blur" }
        ],
        password: [
          { min: 6, max: 12, message: "长度在 6 到 12 个字符", trigger: "blur" }
        ],
        region: []
      }
    };
  },
  created: function() {
    let server = getServer();
    this.server = server;
    this.getMember();
    this.tableHeight = document.body.clientHeight - 210;
  },
  methods: {
    getMember() {
      this.$http
        .post(
          this.server + "select.php",
          { action: "getAdminList" },
          { emulateJSON: true }
        )
        .then(
          response => {
            let data = response.body;
            if (data.code == "0") {
              this.tableData = data.data;
              this.cityData = data.city;
              this.changePage(this.current);
            }
          },
          response => {}
        );
      return true;
    },
    getInfo(id) {
      this.$emit("MemberInfo", id);
    },
    Height() {
      let height = document.body.clientHeight - 210;
      return height;
    },
    indexMethod(index) {
      let start = (this.current - 1) * 20;
      return start + index + 1;
    },
    changePage(page) {
      this.current = page;
      let val = this.tableData;
      let start = (page - 1) * 20;
      let end = page * 20;
      let NewTableData = new Array();
      NewTableData = [];
      for (let x = 0; x < val.length; x++) {
        if (start <= x && x < end) {
          NewTableData.push(val[x]);
        }
      }
      this.viewlist = NewTableData;
    },
    handleClose(done) {
      done();
      this.ruleForm.region = "";
      this.$refs.ruleForm.resetFields();
      this.ModifyID = "";
      this.addAdmin = false;
    },
    ModifyInfo(id) {
      this.dialogTitle = "修改信息";
      this.dialogButton = "修改";
      this.dialogVisible = true;
      this.ModifyID = id;
    },
    Delete(id) {
      this.$confirm("操作后无法进行修改, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(() => {
          this.ToDelete(id);
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消操作"
          });
        });
    },
    submitForm() {
      this.$refs.ruleForm.validate(valid => {
        if (valid) {
          let arr = Object.keys(this.ruleForm);
          let no = "0";
          let Postvalue = new Array();
          for (let x = 0; x < arr.length; x++) {
            if (this.ruleForm[arr[x]] != "") {
              no++;
              Postvalue.push(
                "`" + arr[x] + "`" + "=" + "'" + this.ruleForm[arr[x]] + "'"
              );
            }
          }
          if (no == "0") {
            this.$message({
              message: "无修改内容,请至少修改一项内容",
              type: "warning"
            });
          } else {
            Postvalue = Postvalue.join(",");
            this.$http
              .post(
                this.server + "insert.php",
                {
                  action: "ModifyAdmin",
                  id: this.ModifyID,
                  username: this.ruleForm.username,
                  password: this.ruleForm.password,
                  Postvalue: Postvalue
                },
                { emulateJSON: true }
              )
              .then(
                response => {
                  let data = response.body;
                  if (data.code == "0") {
                    this.getMember();
                    this.dialogVisible = false;
                    this.$message({
                      message: data.msg,
                      type: "success"
                    });
                    this.ruleForm.region = "";
                    this.$refs.ruleForm.resetFields();
                    this.ModifyID = "";
                  } else {
                    this.$message.error(data.msg);
                  }
                },
                response => {}
              );
          }
        } else {
          this.$message("请重新填写");
          return false;
        }
      });
    },
    ToDelete(id) {
      this.$http
        .post(
          this.server + "insert.php",
          {
            action: "DeleteAdmin",
            id: id
          },
          { emulateJSON: true }
        )
        .then(
          response => {
            let data = response.body;
            if (data.code == "0") {
              this.getMember();
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
    },
    AddAdmin() {
      this.addAdmin = true;
      this.dialogTitle = "添加管理员";
      this.dialogButton = "添加";
      this.dialogVisible = true;
    },
    ToAddAdmin() {
      this.$refs.ruleForm.validate(valid => {
        if (valid) {
          var formData = new FormData();
          formData.append("action", "AddAdmin");
          var arr = Object.keys(this.ruleForm);
          for (let x = 0; x < arr.length; x++) {
            formData.append(arr[x], this.ruleForm[arr[x]]);
          }
          this.$http
            .post(this.server + "insert.php", formData, {
              emulateJSON: true
            })
            .then(
              response => {
                let data = response.body;
                if (data.code == "0") {
                  this.getMember();
                  this.dialogVisible = false;
                  this.addAdmin = false;
                  this.$message({
                    message: data.msg,
                    type: "success"
                  });
                  this.ruleForm.region = "";
                  this.$refs.ruleForm.resetFields();
                  this.handleClose();
                } else {
                  this.$message.error(data.msg);
                }
              },
              response => {}
            );
        } else {
          this.$message({
            message: "请正确填写内容",
            type: "warning"
          });
          return false;
        }
      });
    }
  }
};
</script>

<style lang="less">

</style>

