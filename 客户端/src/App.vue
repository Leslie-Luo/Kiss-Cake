<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: "app"
};
</script>

<style>
* {
  margin: 0px;
  padding: 0px;
}
#app {
  font-family: 'Noto Serif CJK SC', 'Noto Serif CJK', 'Source Han Serif SC', 'Source Han Serif', 'source-han-serif-sc', 'PT Serif', 'SongTi SC', 'MicroSoft Yahei', Georgia, serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  background-color: #f6f6f6;
}
.el-container{
  min-width: 1200px;
}
</style>
