<template>
    <div id="ToTop">
        <div @click="totop" class="back-to-top back-to-top-on">
            <icon name="arrow-up"></icon>
        </div>
    </div>
</template>
<script>
import $ from "jquery";
import "vue-awesome/icons";
import Icon from "vue-awesome/components/Icon";
export default {
  name: "ToTop",
  components: {
    Icon
  },
  mounted() {
    window.addEventListener("scroll", this.menu);
  },
  methods: {
    menu() {
      $(window).scrollTop(function() {
        if ($(window).scrollTop() > 100) {
          $("#ToTop").css("bottom", "30px");
        } else {
          $("#ToTop").css("bottom", "-100px");
        }
      });
    },
    totop() {
      $("html,body").animate({ scrollTop: 0 }, 800);
    }
  }
};
</script>
<style lang="less">
#ToTop {
  //   display: none;
  position: fixed;
  right: 5%;
  bottom: -100px;
  z-index: 998;
  -webkit-transform: translateZ(0);
  transition-property: bottom;
  transition-duration: 0.2s;
  transition-timing-function: ease-in-out;
  transition-delay: 0s;
  .back-to-top {
    box-sizing: border-box;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background: #565555;
    font-size: 12px;
    color: #fff;
    cursor: pointer;
    text-align: center;
    .fa-icon {
      margin-top: 10px;
    }
  }
}
</style>
