<template>
  <div>
    <el-tabs v-model="activeName" type="border-card" @tab-click="handleClick">
      <el-tab-pane label="待发货" name="Delivery">
        <OrderTable ref="Delivery" :orderType="this.orderType.Delivery"></OrderTable>
      </el-tab-pane>
      <el-tab-pane label="已发货" name="Shipped">
        <OrderTable ref="Shipped" :orderType="this.orderType.Shipped"></OrderTable>
      </el-tab-pane>
      <el-tab-pane label="全部订单" name="All">
        <OrderTable ref="All" :orderType="this.orderType.All"></OrderTable>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import { orderlist } from "vuex";
import OrderTable from "./components/OrderTable.vue";
import { getServer } from "@/assets/js/server.js";
export default {
  name: "OrderList",
  components: {
    OrderTable
  },
  data() {
    return {
      activeName: "Delivery",
      orderType: {
        Delivery: "Delivery",
        Shipped: "Shipped",
        All: "All"
      }
    };
  },
  created: function() {},
  methods: {
    handleClick(tab, event) {
      var _this = this;
      _this.$refs[tab["name"]].changePage(1);
    }
  }
};
</script>

<style lang="less" scoped>

</style>

