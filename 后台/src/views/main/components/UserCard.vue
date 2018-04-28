<template>
  <div class="box-card">
    <el-row>
      <el-col :span="10">
        <div class="user-img">
          <img src="./../../../assets/cake.svg" alt="">
        </div>
      </el-col>
      <el-col :span="14" class="info center-y-f">
        <el-row class="center-y-c">
          <el-col :span="24">
            <div class="user-name" v-html="this.username">

            </div>
          </el-col>
          <el-col :span="24">
            <div class="user-welcome">
              {{ welcome }}
            </div>
          </el-col>
        </el-row>
      </el-col>
    </el-row>
  </div>
</template>
<script>
export default {
  name: "UserCard",
  data() {
    return {
      username: ""
    };
  },
  mounted() {
    this.username = localStorage.getItem("Adminname");
  },
  computed: {
    welcome: function() {
      let hour;
      hour = new Date().getHours();
      if (hour < 6) {
        return "凌晨好！";
      } else if (hour < 12) {
        return "早上好！";
      } else if (hour < 14) {
        return "中午好！";
      } else if (hour < 18) {
        return "下午好！";
      } else if (hour <= 24) {
        return "晚上好！";
      } else {
        return "凌晨好！";
      }
    }
  }
};
</script>

<style lang="less" scoped>
@100: 20vh;
.box-card {
  height: @100;
  background-color: #fff;
  -webkit-box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  border-radius: 4px;
  overflow: hidden;
  .user-img {
    width: 100%;
    height: @100;
    text-align: center;
    img {
      max-width: 80%;
      margin-top: 15%;
      max-height: 70%;
    }
  }
  .info {
    height:  @100;
    right: 0;
    .el-row {
      .user-name {
        font-size: 2rem;
        font-weight: 600;
      }
    }
  }
}
</style>

