import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import Catalogue from '@/views/Catalogue.vue'
import Login from '../views/Login.vue'
import Profile from '@/views/Profile.vue'
import Register from '@/views/Register.vue'
import Conditioner from '@/views/Conditioner.vue'
import Order from '@/views/Order.vue'
import MakeOrder from '@/views/MakeOrder.vue'
import Pending from '@/views/Pending.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/pending',
      name: 'panding',
      component: Pending
    },
    {
      path: '/login',
      name: 'Login',
      component: Login,
    },
    {
      path: '/ordering',
      name: 'ordering',
      component: Order,
    },
    {
      path: '/',
      name: 'home',
      component: HomeView,
    },
    {
      path: '/cakes',
      component: Catalogue,
    },
    {
      path: '/profile/:client_id',
      component: Profile,
      name: 'Profile',
      props: true
    },
    {
      path: '/about',
      name: 'about',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/AboutView.vue'),
    },
    {
      path: '/register',
      name: 'Registration',
      component: Register,
    },
    {
      path: '/conditioners',
      name: 'conditioners',
      component: Conditioner,
    },
    {
      path: "/makeorder",
      name: "makeorder",
      component: MakeOrder
    }
  ],
  
})
router.beforeEach((to, from, next) => {
  const isAuthenticated = !!localStorage.getItem('token');
  if (to.matched.some(record => record.meta.requiresAuth) && !isAuthenticated) {
    next({ path: '/login' });
  } else {
    next();
  }
});
export default router
