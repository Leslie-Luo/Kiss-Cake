import Vue from 'vue'
import Router from 'vue-router'

const Login = () =>
  import ('@/views/login/Login')
const Home = () =>
  import ('@/views/home/Home')
const Main = () =>
  import ('@/views/main/Main')
const CakeList = () =>
  import ('@/views/manage/list/CakeList')
const AddCake = () =>
  import ('@/views/manage/add/AddCake')
const Modify = () =>
  import ('@/views/manage/modify/Modify')
const Carousel = () =>
  import ('@/views/manage/carousel/Carousel')
const OrderList = () =>
  import ('@/views/order/list/OrderList')
const Member = () =>
  import ('@/views/member/Member')
const AdminList = () =>
  import ('@/views/member/AdminList')

Vue.use(Router)
export default new Router({
  routes: [{
      path: '/login',
      component: Login
    },
    {
      path: '/',
      redirect: '/home',
      component: Home,
      children: [{
          path: '/home',
          name: '/home',
          meta: [{
            title: '首页',
            path: '/home'
          }],
          component: Main,
        },
        {
          path: '/home/cakelist',
          component: CakeList,
          name: '/home/cakelist',
          meta: [{
            title: '首页',
            path: '/home'
          }, {
            title: '商品管理',
            path: '/home/cakelist'
          }, {
            title: '商品列表',
            path: '/home/cakelis'
          }]
        },
        {
          path: '/home/addcake',
          component: AddCake,
          name: '/home/addcake',
          meta: [{
              title: '首页',
              path: '/home'
            }, {
              title: '商品管理',
              path: '/home/cakelist'
            },
            {
              title: '添加商品',
              path: '/home/addcake'
            }
          ]
        },
        {
          path: '/home/modify/:cakeId',
          component: Modify,
          name: '/home/modify/null',
          meta: [{
              title: '首页',
              path: '/home'
            }, {
              title: '商品管理',
              path: '/home/cakelist'
            },
            {
              title: '修改商品',
              path: '/home/modify'
            }
          ]
        },
        {
          path: '/home/carousel',
          component: Carousel,
          name: '/home/carousel',
          meta: [{
            title: '首页',
            path: '/home'
          }, {
            title: '商品管理',
            path: '/home/cakelist'
          }, {
            title: '轮播管理',
            path: '/home/carousel'
          }]
        },
        {
          path: '/home/order/',
          component: OrderList,
          name: '/home/order/',
          meta: [{
            title: '首页',
            path: '/home'
          }, {
            title: '订单管理',
            path: '/home/order/'
          }]
        },
        {
          path: '/home/member/',
          component: Member,
          name: '/home/member/',
          meta: [{
            title: '首页',
            path: '/home'
          }, {
            title: '会员管理',
            path: '/home/member/'
          }]
        },
        {
          path: '/home/adminlist/',
          component: AdminList,
          name: '/home/adminlist/',
          meta: [{
            title: '首页',
            path: '/home'
          }, {
            title: '管理员列表',
            path: '/home/adminlist/'
          }]
        }
      ]
    }
  ]
})
