<template>
  <div id="UserModify">
    <el-row>
      <el-col :span="12">
        <el-upload class="avatar-uploader" action="#" :show-file-list="false" :on-change="beforeAvatarUpload" :auto-upload="false">
          <img v-if="imageUrl" :src="imageUrl" class="avatar">
          <i v-else class="el-icon-plus avatar-uploader-icon"></i>
        </el-upload>

        </el-col>
    </el-row>
  </div>
</template>
<script>
export default {
  name: "Modify",
  data() {
    return {
      imageUrl: ""
    };
  },
  methods: {
    beforeAvatarUpload(file) {
      this.imageUrl = URL.createObjectURL(file.raw);
    }
  }
};
</script>
<style lang="less">
#UserModify {
  .avatar-uploader .el-upload {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .avatar-uploader .el-upload:hover {
    border-color: #409EFF;
  }
  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 178px;
    height: 178px;
    line-height: 178px;
    text-align: center;
  }
  .avatar {
    width: 178px;
    height: 178px;
    display: block;
  }
}
</style>
