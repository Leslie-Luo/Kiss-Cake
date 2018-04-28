<template>
  <div>
    <MemberList ref="MemberList" v-show="!InfoId" @MemberInfo="MemberInfo"></MemberList>
    <MemberInfo ref="MemberInfo" v-if="InfoId" @MemberList="MemberList"></MemberInfo>
  </div>
</template>

<script>
import MemberList from "./components/MemberList.vue";
import MemberInfo from "./components/MemberInfo.vue";
export default {
  name: "Member",
  components: {
    MemberList,
    MemberInfo
  },
  data() {
    return {
      InfoId: false
    };
  },
  created: function() {
  },
  methods: {
    MemberInfo: function(val) {
      this.InfoId = true;
      var _this = this;
      setTimeout(() => {
        _this.$refs.MemberInfo.getMemberInfo(val);
      }, 100);
    },
    MemberList: function(val) {
      this.InfoId = false;
    }
  }
};
</script>

<style lang="less">

</style>

