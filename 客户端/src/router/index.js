import Vue from 'vue'
import Router from 'vue-router'
const Index = () =>
  import ('@/components/Index')
const IndexPage = () =>
  import ('@/components/Index/Index')
const Details = () =>
  import ('@/components/Details/Details')
const Flavor = () =>
  import ('@/components/Flavor/Flavor')
const UserSign = () =>
  import ('@/components/UserSign/UserSign')
const ShopCard = () =>
  import ('@/components/ShopCard/ShopCard')
const CheckOut = () =>
  import ('@/components/CheckOut/CheckOut')
const User = () =>
  import ('@/components/User/User')
const Tag = () =>
  import ('@/components/Tag/Tag')
Vue.use(Router)

export default new Router({
  routes: [{
    path: '/',
    component: Index,
    children: [{
        path: '/',
        name: 'Kiss-Cake',
        component: IndexPage,
      },
      {
        path: '/Details',
        name: 'Kiss Cake-商品详情',
        component: Details,
      },
      {
        path: '/Flavor',
        name: 'Kiss Cake-口味',
        component: Flavor,
      },
      {
        path: '/UserSign',
        name: '登录/注册',
        component: UserSign,
      },
      {
        path: '/CheckOut',
        name: '结算',
        component: CheckOut,
      },
      {
        path: '/ShopCard',
        name: '购物车',
        component: ShopCard,
      },
      {
        path: '/Member',
        name: '用户中心',
        component: User,
      },
      {
        path: '/Tag/:TagText',
        name: '标签',
        component: Tag,
      }
    ]
  }]
})
