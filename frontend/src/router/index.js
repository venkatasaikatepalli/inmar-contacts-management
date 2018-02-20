import Vue from 'vue'
import Router from 'vue-router'
import Welcome from '@/components/Welcome'
import Login from '@/components/Login'
import SignUp from '@/components/SignUp'
import Dashboard from '@/components/Dashboard'
import Contacts from '@/components/Contacts'
import auth from '@/services/authService'

Vue.use(Router)

function requireAuth (to, from, next) {
  if (auth.getAuthStatus) {
    next() // we are authorized, continue on to the requested route
  } else {
    next('/login') // they are not authorized, so redirect to login
  }
}

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Welcome',
      component: Welcome
    },
    {
      path: '/login',
      name: 'Login',
      component: Login
    },
    {
      path: '/signup',
      name: 'SignUp',
      component: SignUp
    },
    {
      path: '/dashboard',
      name: 'Dashboard',
      component: Dashboard,
      beforeEnter: requireAuth
    },
    {
      path: '/contacts',
      name: 'Contacts',
      component: Contacts,
      beforeEnter: requireAuth
    }
  ]
})
