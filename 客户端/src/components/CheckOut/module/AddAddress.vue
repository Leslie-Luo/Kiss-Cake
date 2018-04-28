<template>
  <el-dialog title="提示" :visible.sync="Adddialog" width="30%" :before-close="Close">
    <el-form :model="ruleForm" status-icon :rules="rules" ref="Addaddress" label-width="100px" class="Addaddress">
      <el-form-item label="收货人" prop="username">
        <el-input v-model="ruleForm.username"></el-input>
      </el-form-item>
      <el-form-item label="联系方式" prop="phone">
        <el-input v-model="ruleForm.phone"></el-input>
      </el-form-item>
      <el-form-item label="城市" prop="selectcity">
        <el-select v-model="ruleForm.selectcity" placeholder="请选择城市" style="width:100%">
          <el-option v-for="(item,index) in citydata" :key="item.key" :label="item.city" :value="index"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="位置" prop="district" ref="district">
        <el-select v-model="ruleForm.district" placeholder="请选择区域" style="width:100%">
          <el-option v-for="(item,index) in this.subdata" :key="item.key" :label="item.item_name" :value="index"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="街道" prop="address">
        <el-input v-model="ruleForm.address"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button v-if="modifyid != '-1'" @click="submitForm('Addaddress')">修改</el-button>
        <el-button v-if="modifyid == '-1'" @click="submitForm('Addaddress')">添加</el-button>
        <el-button @click="Close('cancel')">取消</el-button>
      </el-form-item>
    </el-form>
  </el-dialog>
</template>
<script>
import $ from "jquery";
import { getServer } from "@/assets/js/server.js";
export default {
  name: "Addaddress",
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
      Adddialog: false,
      citydata: [],
      subdata: [],
      modifyid: "-1",
      ruleForms: {
        selectcity: "",
        district: ""
      },
      ruleForm: {
        selectcity: "",
        username: "",
        phone: "",
        city: "",
        district: "",
        address: ""
      },
      rules: {
        username: [
          { required: true, message: "请输入收货人姓名", trigger: "blur" }
        ],
        phone: [{ validator: checkPhone, trigger: "blur" }],
        selectcity: [
          { required: true, message: "请选择省份", trigger: "change" }
        ],
        district: [
          { required: true, message: "请选择区域", trigger: "change" }
        ],
        address: [
          { required: true, message: "请输入具体地址", trigger: "blur" }
        ]
      }
    };
  },
  mounted() {
    let server = getServer() + "BuyCake.php";
    this.$http
      .post(server, { action: "GetAddress" }, { emulateJSON: true })
      .then(
        response => {
          if (response.body.code == "0") {
            let data = response.body.data;
            this.citydata = data;
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
    submitForm(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          this.ToAdd();
        } else {
          return false;
        }
      });
    },
    ToAdd() {
      let server = getServer() + "BuyCake.php";
      var formData = new FormData();
      if (this.modifyid != "-1") {
        formData.append("action", "ModifyAddress");
        formData.append("id", this.modifyid);
      } else {
        formData.append("action", "AddAddress");
      }
      formData.append("userid", localStorage.getItem("id"));
      formData.append("username", this.ruleForm.username);
      formData.append("phone", this.ruleForm.phone);
      formData.append("city", this.ruleForm.city);
      formData.append("district", this.ruleForm.district);
      formData.append("address", this.ruleForm.address);
      this.$http.post(server, formData, { emulateJSON: true }).then(
        response => {
          if (response.body.code == "0") {
            this.$message({
              message: response.body.msg,
              type: "success"
            });
            this.Close();
          } else {
            this.$message.error(response.body.msg);
          }
        },
        response => {}
      );
    },
    Close(val) {
      this.$refs.Addaddress.resetFields();
      this.modifyid = "-1";
      this.Adddialog = false;
      this.$parent.CloseAdd();
    }
  },
  watch: {
    "ruleForm.selectcity": function() {
      if (this.Adddialog == true) {
        this.$refs["district"].clearValidate();
        this.ruleForm.city = this.citydata[this.ruleForm.selectcity]["id"];
        this.subdata = this.citydata[this.ruleForm.selectcity]["sub"];
        this.ruleForm.district = "";
      }
    }
  }
};
</script>
<style lang="less">
.Addaddress {
  margin-right: 30px;
}
</style>
