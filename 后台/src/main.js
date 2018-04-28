import Vue from 'vue'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import App from './App.vue'
import router from './router'
import 'font-awesome/css/font-awesome.css'
import VueResource from 'vue-resource'
import VeLine from 'v-charts/lib/line'
import VePie from 'v-charts/lib/pie'
import store from './store/index';

Vue.config.productionTip = false

Vue.use(ElementUI)
Vue.use(VueResource)
Vue.component(VeLine.name, VeLine)
Vue.component(VePie.name, VePie)

new Vue({
  el: '#app',
	router,
	store,
	template: '<App/>',
	components: { App }
})
