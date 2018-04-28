<template>
  <div class="manage" v-loading="loading">
    <el-form :model="cakeInfo" label-width="100px" ref="AddForm" :rules="rules">
      <el-card class="box-card">
        <div slot="header" class="clearfix">
          <span>基本参数</span>
          <el-button style="float: right; padding: 3px 0" type="text" @click="resetCakeInfo">重置</el-button>
        </div>
        <el-row>
          <el-col :span="5" class="left">
            <el-upload class="avatar-uploader" ref="header" accept="image/jpeg" action="#" id="upHeader" :auto-upload="false" :show-file-list="false" :on-change="handleAvatarSuccess">
              <img v-if="imageUrl" :src="imageUrl" class="avatar">
              <i v-else class="el-icon-plus avatar-uploader-icon"></i>
            </el-upload>
          </el-col>
          <el-col :span="19">
            <el-row>
              <el-col :span="12">
                <el-form-item label="名称:" prop="name">
                  <el-input v-model="cakeInfo.name" auto-complete="off"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="12" v-show="false">
                <el-form-item label="种类:" prop="type">
                  <el-select v-model="cakeInfo.type" placeholder="请选择商品种类">
                    <el-option v-for="item in cakeType.type" :label="item.type" :key="item.id" :value="item.id"></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
            </el-row>
            <el-form-item label="口味:" prop="taste">
              <el-checkbox-group v-model="cakeInfo.taste" :min="1" :max="5">
                <el-checkbox v-for="item in cakeType.taste" :label="item.id" :key="item.id">{{item.taste}}</el-checkbox>
              </el-checkbox-group>
            </el-form-item>
            <el-form-item label="标签:" prop="tag">
              <el-checkbox-group v-model="cakeInfo.tag" :min="1" :max="5">
                <el-checkbox v-for="item in cakeType.tag" :label="item.id" :key="item.id">{{item.tag}}</el-checkbox>
              </el-checkbox-group>
            </el-form-item>
            <el-row>
              <el-col :span="8">
                <el-form-item label="默认:" prop="default_spec">
                  <el-select v-model="cakeInfo.default_spec" placeholder="请先添加规格数据">
                    <el-option v-for="item in spec_value" :key="item.id" :label="item.text" :value="item.id">
                    </el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="16">
                <el-form-item label="规格:">
                  <el-tag :key="item.id" v-for="item in spec_value" closable :disable-transitions="false" @close="handleClose(item)" style="margin-right:5px;">
                    {{item.text}}
                  </el-tag>
                  <el-button type="info" size="small" @click="dialogFormVisible = true">添加</el-button>
                </el-form-item>
              </el-col>
            </el-row>
          </el-col>
        </el-row>
      </el-card>
      <el-card class="box-card" style="margin-top:20px">
        <div slot="header" class="clearfix">
          <span>展示数据·轮播图片</span>
          <el-button style="float: right; padding: 3px 0" type="text" @click="resetCarousel">重置</el-button>
        </div>
        <div>
          <el-upload action="#" ref="Carousel" accept="image/jpeg" class="Carousel" :file-list="bannerList" list-type="picture-card" :on-preview="handlePictureCardPreview" :on-remove="handleRemove" :auto-upload="false" :limit="4" :on-exceed="handleExceed" :on-change="CarouselChange">
            <i class="el-icon-plus" style="font-size:17px;"></i>
          </el-upload>
          <el-dialog :visible.sync="dialogVisible" class="text-center" center>
            <img width="100%" :src="dialogImageUrl" alt="">
            <span slot="footer">
              <el-upload v-show="! confirm" class="upload-demo" action="#" multiple :on-change="modifyIamges" :show-file-list="false" :auto-upload="false" style="margin-bottom:10px;">
                <el-button type="primary">修改图片</el-button>
              </el-upload>
              <el-collapse-transition>
                <div v-show="confirm">
                  <el-button type="info" icon="el-icon-close" @click="stopModify">重置</el-button>
                  <el-button type="success" icon="el-icon-check" @click="sureModify">确定</el-button>
                </div>
              </el-collapse-transition>
            </span>
          </el-dialog>
        </div>
      </el-card>
      <el-card class="box-card" style="margin-top:20px">
        <div slot="header" class="clearfix">
          <span>展示数据·详情图片</span>
          <el-button style="float: right; padding: 3px 0" type="text" @click="resetCakeInfoData">重置</el-button>
        </div>
        <div>
          <el-upload action="#" ref="CakeInfoData" accept="image/jpeg" class="CakeInfo" :file-list="infodataList" list-type="picture-card" :on-preview="handlePictureCardPreview" :on-remove="handleRemove" :auto-upload="false">
            <i class="el-icon-plus" style="font-size:17px;"></i>
          </el-upload>
        </div>
      </el-card>
      <el-form-item class="AddForm">
        <el-button type="primary" @click="submitAddForm('AddForm')">修改</el-button>
        <el-button @click="resetAddForm('AddForm')">重置</el-button>
      </el-form-item>
    </el-form>
    <el-dialog title="添加规格" :visible.sync="dialogFormVisible" width="500px" center>
      <el-dialog width="30%" title="添加价格" :visible.sync="innerVisible" append-to-body center>
        <el-form :model="ruleForm" :rules="rules" ref="AddPrice">
          <el-form-item prop="addprice" :rules="[{ required: true, message: '商品价格不能为空'},{ type: 'number', message: '商品价格必须为数字值'}]">
            <el-input v-model.number="ruleForm.addprice" auto-complete="off" placeholder="请输入新的商品价格"></el-input>
          </el-form-item>
          <el-form-item style="text-align:center;">
            <el-button type="primary" @click="submitAddPrice('AddPrice')">添加</el-button>
            <el-button @click="resetAddPrice('AddPrice')">取消</el-button>
          </el-form-item>
        </el-form>
      </el-dialog>
      <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="addspec">
        <el-form-item label="尺寸:" prop="size">
          <el-select v-model="ruleForm.size" placeholder="请选择尺寸" class="size">
            <el-option v-for="item in cakeType.size" :label="item.size + '磅'" :key="item.id" :value="item.id">
              {{item.size}}磅
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="价格:" prop="price">
          <el-select v-model="ruleForm.price" filterable placeholder="请选择价格">
            <el-option v-for="item in cakeType.price" :label="item.price + '￥'" :key="item.id" :value="item.id">
              {{item.price}}￥
            </el-option>
          </el-select>
          <el-button @click="innerVisible = true">新建价格</el-button>
        </el-form-item>
        <el-form-item>
          <el-form-item>
            <el-button type="primary" @click="submitForm('ruleForm')">提交修改</el-button>
            <el-button @click="resetForm('ruleForm')">取消</el-button>
          </el-form-item>
        </el-form-item>
      </el-form>
    </el-dialog>
  </div>
</template>
<script>
import { typelist } from "vuex";
import router from "@/router";
import { getServer } from "@/assets/js/server.js";
export default {
  name: "Modify",
  data() {
    return {
      server: "",
      loading: true,
      cakeType: {
        type: [],
        tag: [],
        taste: [],
        size: [],
        price: []
      },
      type_value: "",
      taste_value: [],
      tag_value: [],
      dialogFormVisible: false,
      innerVisible: false,
      ruleForm: {
        size: "",
        price: "",
        addprice: ""
      },
      cakeInfo: {
        name: "",
        type: "",
        taste: [],
        spec: [],
        tag: [],
        default_spec: "",
        articleid: "",
        catalog: ""
      },
      imglist: {
        banner: "",
        infodata: ""
      },
      default_spec: "",
      spec_value: [],
      imageUrl: "",
      rules: {
        name: [{ required: true, message: "请输入名称", trigger: "blur" }],
        type: [{ required: true, message: "请选择种类", trigger: "change" }],
        default_spec: [
          { required: true, message: "请选择默认规格", trigger: "change" }
        ],
        size: [{ required: true, message: "请选择尺寸", trigger: "change" }],
        price: [{ required: true, message: "请选择价格", trigger: "change" }],
        taste: [
          {
            required: true,
            message: "请至少选择一种口味",
            trigger: "change"
          }
        ],
        tag: [
          {
            required: true,
            message: "请至少选择一个标签",
            trigger: "change"
          }
        ],
        addprice: [
          { required: true, message: "请输入名称", trigger: "blur" },
          { min: 3, max: 5, message: "长度在 3 到 5 个字符", trigger: "blur" }
        ]
      },
      //展示数据
      dialogImageUrl: "",
      dialogVisible: false,
      // 图片数据
      bannerList: [],
      infodataList: [],
      // 修改图片
      modifyimg: [],
      confirm: false,
      ImageModify: [],
      // 删除图片
      removeList: {
        banner: [],
        infodata: [],
        removebanner: [],
        removeinfodata: [],
        newbanner: [],
        newinfodata: []
      }
    };
  },
  created: function() {
    let server = getServer();
    this.server = server;
    if (this.$route.params.cakeId == "null") {
      this.$message({
        message: "请先在商品列表选择要修改的对应商品",
        type: "warning"
      });
      router.push({ path: "/home/cakelist" });
      return false;
    } else {
      this.loading = false;
      this.getCakeInfo(this.$route.params.cakeId);
    }
    if (this.$store.state.typelist.typelist == "") {
      this.getType();
      this.$store.state.typelist.typelist = this.cakeType;
    } else {
      this.cakeType = this.$store.state.typelist.typelist;
    }
  },
  methods: {
    getCakeInfo(id) {
      this.$http
        .post(
          this.server + "select.php",
          { action: "getCakeInfo", cakeId: id },
          { emulateJSON: true, dataType: "JSONP" }
        )
        .then(
          response => {
            let data = response.body.data["0"];
            this.cakeInfo.name = data.name;
            this.cakeInfo.type = data.type;
            var list = ["taste", "tag", "spec"];
            for (let z = 0; z < list.length; z++) {
              var strs = new Array();
              strs = data[list[z]].split(",");
              for (let x = 0; x < strs.length; x++) {
                this.cakeInfo[list[z]].push(strs[x]);
              }
            }
            var banner = data.banner.split(",");
            this.imglist.banner = banner;
            this.removeList.newbanner = banner;
            for (let x = 0; x < banner.length; x++) {
              var bannerList = new Object();
              bannerList["name"] = x;
              bannerList["url"] =
                data.server + banner[x] + "?" + new Date().getTime();
              this.bannerList.push(bannerList);
              if (x >= 3) {
                document.getElementsByClassName("Carousel")["0"].children[1].style.display="none";
              }
            }
            var infodata = data.infodata.split(",");
            this.imglist.infodata = infodata;
            this.removeList.newinfodata = infodata;
            for (let x = 0; x < infodata.length; x++) {
              var infodataList = new Object();
              infodataList["name"] = x;
              infodataList["url"] =
                data.server + infodata[x] + "?" + new Date().getTime();
              this.infodataList.push(infodataList);
            }
            this.default_spec = data.default_price;
            this.cakeInfo.articleid = data.articleid;
            this.cakeInfo.catalog = data.catalog;
            this.imageUrl =
              data.server + data.iconimg + "?" + new Date().getTime();
          },
          response => {}
        );
    },
    // 获取Type类型
    getType() {
      this.$http
        .post(
          this.server + "select.php",
          { action: "getType" },
          { emulateJSON: true }
        )
        .then(
          response => {
            let data = response.body.data;
            this.cakeType.type = data.type;
            this.cakeType.tag = data.tag;
            this.cakeType.taste = data.taste;
            this.cakeType.size = data.size;
            this.cakeType.price = data.price;
          },
          response => {}
        );
    },
    // 添加新尺寸
    submitForm(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          for (let x = 0; x < this.cakeInfo.spec.length; x++) {
            var strs = new Array();
            strs = this.cakeInfo.spec[x].split("-");
            if (this.ruleForm.size == strs["1"]) {
              this.$notify({
                title: "警告",
                duration: 2500,
                message: "该尺寸已存在",
                type: "warning"
              });
              return false;
            }
          }
          let id = this.ruleForm.price + "-" + this.ruleForm.size;
          this.cakeInfo.spec.push(id);
          this.$refs[formName].resetFields();
          this.dialogFormVisible = false;
        } else {
          return false;
        }
      });
    },
    resetForm(formName) {
      this.$refs[formName].resetFields();
      this.dialogFormVisible = false;
    },
    submitAddForm(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          this.Upload();
        } else {
          return false;
        }
      });
    },
    resetAddForm(formName) {
      this.Reset();
      this.getCakeInfo(this.$route.params.cakeId);
    },
    submitAddPrice(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          this.$http
            .post(
              this.server + "insert.php",
              { action: "addprice", newprice: this.ruleForm.addprice },
              { emulateJSON: true }
            )
            .then(
              response => {
                let data = response.body;
                if (data.code == "1") {
                  this.$refs[formName].resetFields();
                  this.$notify.error({
                    title: "错误",
                    duration: 2500,
                    message: data.msg
                  });
                }
                if (data.code == "2") {
                  for (let x = 0; x < this.cakeType.price.length; x++) {
                    if (
                      this.cakeType.price[x].price == this.ruleForm.addprice
                    ) {
                      this.ruleForm.price = this.cakeType.price[x].id;
                    }
                  }
                  this.$notify({
                    title: "警告",
                    duration: 2500,
                    message: data.msg,
                    type: "warning"
                  });
                  this.innerVisible = false;
                  this.$refs[formName].resetFields();
                } else {
                  this.innerVisible = false;
                  this.cakeType.price = data.data;
                  this.$store.state.typelist.typelist.price = data.data;
                  for (let x = 0; x < this.cakeType.price.length; x++) {
                    if (
                      this.cakeType.price[x].price == this.ruleForm.addprice
                    ) {
                      this.ruleForm.price = this.cakeType.price[x].id;
                    }
                  }
                  this.$refs[formName].resetFields();
                  this.$notify({
                    title: "成功",
                    duration: 2500,
                    message: data.msg,
                    type: "success"
                  });
                }
              },
              response => {}
            );
        } else {
          return false;
        }
      });
    },
    resetAddPrice(formName) {
      this.$refs[formName].resetFields();
      this.innerVisible = false;
    },
    handleAvatarSuccess(res, file) {
      this.imageUrl = res.url;
    },
    handleClose(item) {
      this.spec_value.splice(this.spec_value.indexOf(item), 1);
      this.cakeInfo.spec.splice(this.cakeInfo.spec.indexOf(item.id), 1);
      if (this.cakeInfo.default_spec == item.id) {
        this.cakeInfo.default_spec = "";
        this.default_spec = "";
      }
    },
    // 上传
    Upload() {
      var formData = new FormData();
      formData.append("id", this.$route.params.cakeId);
      formData.append("action", "modify");
      if (this.$refs.header.uploadFiles["0"]) {
        formData.append("iconimg0", this.$refs.header.uploadFiles["0"].raw);
      } else {
        formData.append("iconimg0", "");
      }
      var removelist = ["banner", "infodata"];
      for (let z = 0; z < removelist.length; z++) {
        var newname = "new" + removelist[z];
        for (var i = 0; i < this.removeList[newname].length; i++) {
          if (this.removeList[newname][i] == "") {
            this.removeList[newname].splice(i, 1);
            i = i - 1;
          }
        }
      }
      formData.append("bannernum", this.removeList.banner);
      formData.append("infodatanum", this.removeList.infodata);
      formData.append("removebanner", this.removeList.removebanner);
      formData.append("removeinfodata", this.removeList.removeinfodata);
      formData.append("bannerlist", this.removeList.newbanner);
      formData.append("infodatalist", this.removeList.newinfodata);
      var arr = Object.keys(this.cakeInfo);
      for (let x = 0; x < arr.length; x++) {
        formData.append(arr[x], this.cakeInfo[arr[x]]);
      }
      if (this.$refs.Carousel.uploadFiles.length == "0") {
        this.$notify.error({
          title: "错误",
          duration: 2500,
          message: "请添加展示数据·轮播图片"
        });
        return false;
      }
      for (let x = 0; x < this.$refs.Carousel.uploadFiles.length; x++) {
        formData.append("banner" + [x], this.$refs.Carousel.uploadFiles[x].raw);
      }
      if (this.$refs.CakeInfoData.uploadFiles.length == "0") {
        this.$notify.error({
          title: "错误",
          duration: 2500,
          message: "请添加展示数据·详情图片"
        });
        return false;
      }
      for (let x = 0; x < this.$refs.CakeInfoData.uploadFiles.length; x++) {
        formData.append(
          "CakeInfoData" + [x],
          this.$refs.CakeInfoData.uploadFiles[x].raw
        );
      }
      this.$http
        .post(this.server + "insert.php", formData, {
          emulateJSON: true
        })
        .then(
          response => {
            let data = response.body;
            if (data.code == "0") {
              this.Reset();
              this.getCakeInfo(this.$route.params.cakeId);
              this.$notify({
                title: "成功",
                duration: 2500,
                message: data.msg,
                type: "success"
              });
            } else {
              this.$notify.error({
                title: "错误",
                duration: 2500,
                message: data.msg
              });
            }
          },
          response => {}
        );
    },
    // 删除图片
    handleRemove(file, fileList) {
      var removelist = ["banner", "infodata"];
      for (let z = 0; z < removelist.length; z++) {
        var name = removelist[z] + "List";
        var removename = "remove" + removelist[z];
        var newname = "new" + removelist[z];
        for (let x = 0; x < this[name].length; x++) {
          if (file == this[name][x]) {
            if (file.status == "success") {
              this.removeList[removelist[z]].push(x);
              this.removeList[removename].push(this.removeList[newname][x]);
              this.removeList[newname][x] = "";
            }
          }
        }
      }
      document.getElementsByClassName("Carousel")["0"].children[1].style.display="inline-block";
    },
    // 展示数据
    handlePictureCardPreview(file) {
      this.dialogImageUrl = file.url;
      this.dialogVisible = true;
      this.modifyimg = file;
    },
    handleExceed(files, fileList) {
      this.$message.warning(`最多选择4个文件`);
    },
    CarouselChange(files, fileList) {
      if (fileList.length >= 4) {
        document.getElementsByClassName("Carousel")["0"].children[1].style.display="none";
      }
    },
    // 选择修改图片
    modifyIamges(res, file) {
      this.dialogImageUrl = res.url;
      this.ImageModify = res;
      this.confirm = true;
    },
    // 修改图片
    sureModify() {
      this.confirm = false;
      for (let x = 0; x < this.$refs.Carousel.uploadFiles.length; x++) {
        if (this.modifyimg == this.$refs.Carousel.uploadFiles[x]) {
          this.$refs.Carousel.uploadFiles[x] = this.ImageModify;
          this.dialogVisible = false;
          this.ImageModify = [];
          this.modifyimg = [];
          return false;
        }
      }
      for (let x = 0; x < this.$refs.CakeInfoData.uploadFiles.length; x++) {
        if (this.modifyimg == this.$refs.CakeInfoData.uploadFiles[x]) {
          this.$refs.CakeInfoData.uploadFiles[x] = this.ImageModify;
          this.dialogVisible = false;
          this.ImageModify = [];
          this.modifyimg = [];
          return false;
        }
      }
    },
    // 取消修改
    stopModify() {
      this.dialogImageUrl = this.modifyimg.url;
      this.confirm = false;
      this.ImageModify = [];
    },
    // 重置
    resetCakeInfo() {
      this.cakeInfo = this.$options.data().cakeInfo;
      this.imageUrl = "";
      this.spec_value = [];
      this.$refs.AddForm.resetFields();
    },
    resetCarousel() {
      this.$refs.Carousel.clearFiles();
    },
    resetCakeInfoData() {
      this.$refs.CakeInfoData.clearFiles();
    },
    // 重置所有
    Reset() {
      this.imageUrl = "";
      this.spec_value = [];
      this.cakeInfo = this.$options.data().cakeInfo;
      this.bannerList = this.$options.data().bannerList;
      this.infodataList = this.$options.data().infodataList;
      this.removeList = this.$options.data().removeList;
      this.$refs.Carousel.clearFiles();
      this.$refs.CakeInfoData.clearFiles();
      this.$refs.AddForm.resetFields();
    },
    watch(val) {
      this.spec_value = [];
      for (let x = 0; x < val.length; x++) {
        let spec_value = new Object();
        var strs = new Array();
        strs = val[x].split("-");
        let price = "";
        let size = "";
        for (let x = 0; x < this.cakeType.price.length; x++) {
          if (this.cakeType.price[x].id == strs["0"]) {
            price = this.cakeType.price[x].price;
          }
        }
        for (let x = 0; x < this.cakeType.size.length; x++) {
          if (this.cakeType.size[x].id == strs["1"]) {
            size = this.cakeType.size[x].size;
          }
        }
        let text = price + "￥" + "/" + size + "磅";
        spec_value["id"] = val[x];
        spec_value["text"] = text;
        this.spec_value.push(spec_value);
      }
      this.cakeInfo.default_spec = this.default_spec;
    }
  },
  watch: {
    "cakeInfo.spec": function(val) {
      setTimeout(() => {
        this.watch(val);
      }, 500);
    }
  }
};
</script>
<style>
.manage {
  max-width: 1200px;
  margin: 0 auto;
}
.addspec .size {
  width: calc(100% - 50px);
}
.left {
  text-align: center;
}
.avatar-uploader .el-upload {
  margin-top: 20px;
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
  width: 198px;
  height: 198px;
  line-height: 198px;
  text-align: center;
}
.avatar {
  width: 198px;
  height: 198px;
  display: block;
}
.Carousel-text {
  margin: 5px 0;
}
.Carousel .el-upload-list__item {
  width: calc(25% - 8px);
}
.Carousel .el-upload {
  width: calc(25% - 8px);
}
.CakeInfo .el-upload-list__item {
  width: calc(25% - 8px);
}
.CakeInfo .el-upload {
  width: calc(25% - 8px);
}
.AddForm {
  text-align: center;
}
.AddForm .el-form-item__content {
  margin: 30px 0 0 0;
  margin-left: 0px !important;
}
.text-center {
  text-align: center;
}
</style>
