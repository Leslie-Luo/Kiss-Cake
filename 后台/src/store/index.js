import Vue from 'vue'
import Vuex from 'vuex'
import cakelist from './modules/cakelist'
import typelist from './modules/typelist'
import orderlist from './modules/orderlist'
import memberlist from './modules/memberlist'
import adminlist from './modules/adminlist'
import linkage from './modules/linkage'

Vue.use(Vuex)

const store = new Vuex.Store({
  modules: {
    cakelist,
    typelist,
    orderlist,
    memberlist,
    adminlist,
    linkage
  },
})

export default store