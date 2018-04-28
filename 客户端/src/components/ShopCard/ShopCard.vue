<template>
  <div>
    <Card></Card>
  </div>
</template>
<script>
import $ from "jquery";
import Card from "./module/Card";
export default {
  name: "ShopCard",
  components: {
    Card
  },
  data() {
    return {
    };
  },
  mounted() {
    $("html,body").animate({ scrollTop: 0 }, 0);
  }
};
</script>

<style lang="less">

</style>