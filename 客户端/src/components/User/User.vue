<template>
    <el-card id="User">
        <el-tabs v-model="activeName" tab-position="right" style="height: 100%;">
            <el-tab-pane label="个人信息" name="My">
                <My></My>
            </el-tab-pane>
            <!-- <el-tab-pane label="修改资料">
                <Modify></Modify>
            </el-tab-pane> -->
            <el-tab-pane label="我的订单" name="Order">
                <MyOrder></MyOrder>
            </el-tab-pane>
            <el-tab-pane label="地址管理" name="Address">
                <MyAddress></MyAddress>
            </el-tab-pane>
        </el-tabs>
    </el-card>
</template>
<script>
import $ from "jquery";
import My from "./module/My";
import Modify from "./module/Modify";
import MyOrder from "./module/MyOrder";
import MyAddress from "./module/MyAddress";
export default {
  name: "User",
  components: {
    My,
    Modify,
    MyOrder,
    MyAddress
  },
  data() {
    return {
      activeName: "My"
    };
  },
  mounted() {
    $("html,body").animate({ scrollTop: 0 }, 300);
    let type = this.$route.params.type;
    if (type == "Address") {
      this.activeName = "Address";
    }
    if (type == "Order") {
      this.activeName = "Order";
    }
  }
};
</script>
<style lang="less">
#User {
  margin-top: 25px;
  min-height: 80vh;
}
</style>
