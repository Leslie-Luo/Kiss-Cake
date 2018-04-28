<template>
  <div id="app">
    <router-view/>
  </div>
</template>

<script>
export default {
  name: "app"
};
</script>

<style lang="less">
* {
  margin: 0px;
  padding: 0px;
  font-family: 'Noto Serif CJK SC', 'Noto Serif CJK', 'Source Han Serif SC', 'Source Han Serif', 'source-han-serif-sc', 'PT Serif', 'SongTi SC', 'MicroSoft Yahei', Georgia, serif;
}
.el-menu-item [class^="fa"] {
  margin-right: 5px;
  width: 24px;
  text-align: center;
  font-size: 18px;
  vertical-align: middle;
}
.el-submenu [class^="fa"] {
  vertical-align: middle;
  margin-right: 5px;
  width: 24px;
  text-align: center;
  font-size: 18px;
}
.center-y-f {
  position: relative;
  .center-y-c {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
  }
}
</style>
