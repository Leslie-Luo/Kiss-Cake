<template>
  <div class="flavor">
    <div class="flavor-list">
      <dl class="tag-list">
        <dt>口味：</dt>
        <dd>
          <a href="javascript:void(0);" :class="'All'== Action ? 'active' : ''" @click="Action = 'All'">全部口味</a>
        </dd>
        <dd v-for="item in GetFlavor.taste" :key="item.key" @click="Action = 'taste' + item.id">
          <a href="javascript:void(0);" :class="'taste' + item.id == Action ? 'active' : ''">{{item.taste}}</a>
        </dd>
      </dl>
      <dl class="tag-list">
        <dt>标签：</dt>
        <dd>
          <a href="javascript:void(0);" :class="'All'== ActionTag ? 'active' : ''" @click="ActionTag = 'All'">全部标签</a>
        </dd>
        <dd v-for="item in GetFlavor.tag" :key="item.key" @click="ActionTag = 'tag' + item.id">
          <a href="javascript:void(0);" :class="'tag' + item.id == ActionTag ? 'active' : ''">{{item.tag}}</a>
        </dd>
      </dl>
    </div>
    <div style="width: 1100px;margin: 0 auto;">
      <el-row :gutter="20">
        <div v-for="item in CakeList" :key="item.key">
          <transition name="slide-fade">
            <el-col :data-id="DataId(item)" v-if="Show(DataId(item))" v-show="ShowTag(DataId(item))" :span="6">
              <Cake :CakeInfo="item"></Cake>
            </el-col>
          </transition>
        </div>
      </el-row>
    </div>
    <ToTop></ToTop>
  </div>
</template>
<script>
import $ from "jquery";
import Cake from "./../Index/module/Cake";
import ToTop from "./../Layout/ToTop";
import { getServer } from "@/assets/js/server.js";
export default {
  name: "Flavor",
  components: {
    Cake,
    ToTop
  },
  data() {
    return {
      CakeList: [],
      GetFlavor: [],
      Action: "All",
      ActionTag: "All"
    };
  },
  beforeMount() {
    $("html,body").animate({ scrollTop: 0 }, 0);
  },
  mounted() {
    let server = getServer() + "BuyCake.php";
    this.$http
      .post(server, { action: "GetFlavor" }, { emulateJSON: true })
      .then(
        response => {
          let data = response.body;
          if (data.code == "0") {
            this.GetFlavor = response.body.data;
          }
        },
        response => {}
      );
    this.$http
      .post(server, { action: "GetCakeList" }, { emulateJSON: true })
      .then(
        response => {
          let data = response.body;
          if (data.code == "0") {
            this.CakeList = response.body.data;
          }
        },
        response => {}
      );
  },
  methods: {
    DataId(item) {
      let type = ["taste", "tag"];
      let DataId = new Array();
      for (let x = 0; x < type.length; x++) {
        const element = type[x];
        for (let z = 0; z < item[element].length; z++) {
          const elements = item[element][z];
          DataId.push(type[x] + elements["id"]);
        }
      }
      return DataId.join(" ");
    },
    Show(val) {
      let type = val.split(" ");
      if (this.Action == "All") {
        return true;
      } else {
        let show = "0";
        for (let x = 0; x < type.length; x++) {
          const element = type[x];
          if (element == this.Action) {
            show = "1";
          } else {
          }
        }
        if (show == "1") {
          return true;
        } else {
          return false;
        }
      }
    },
    ShowTag(val) {
      let type = val.split(" ");
      if (this.ActionTag == "All") {
        return true;
      } else {
        let show = "0";
        for (let x = 0; x < type.length; x++) {
          const element = type[x];
          if (element == this.ActionTag) {
            show = "1";
          } else {
          }
        }
        if (show == "1") {
          return true;
        } else {
          return false;
        }
      }
    }
  }
};
</script>
<style lang="less">
.flavor {
  margin-bottom: 50px;
  .slide-fade-enter-active {
    transition: all 0.3s ease;
  }
  .slide-fade-leave-active {
    transition: all 0s;
  }
  .slide-fade-enter,
  .slide-fade-leave-to {
    transform: translateX(10px);
    opacity: 0;
  }
  .flavor-list {
    font-size: 13px;
    margin-top: 25px;
    margin-bottom: 35px;
    width: 1200px;
    background-color: #ffffff;
    border-radius: 5px;
    overflow: hidden;
    padding: 8px 0;
    -webkit-box-shadow: 0 2px 5px 0 rgba(146, 146, 146, 0.1);
    box-shadow: 0 2px 5px 0 rgba(146, 146, 146, 0.1);
    .tag-list {
      line-height: 50px;
      overflow: hidden;
      height: 50px;
      .active {
        color: #bb9772;
      }
      dt {
        float: left;
        color: #9b9b9b;
        margin-left: 50px;
      }
      dd {
        float: left;
        margin: 0 13px;
        a {
          color: #461e09;
          text-decoration: none;
        }
      }
    }
  }
}
</style>
