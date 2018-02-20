<template>
  <div id="app">
    <div class="header">
      <div class="container-fluid visible-xs">
        <div class="row flx">
          <div class="col-xs-9 no-pad mobile-header">
            <a class="" href="#"><img src="./assets/header-logo.svg" height="40px" alt=""></a>
          </div>
          <div class="col-xs-3 flx-cend">
            <el-button type="text btn-menu" @click.prevent="changeNav"><span class="fa fa-bars"></span></el-button>
          </div>
        </div>
      </div>
      <nav class="navbar hidden-xs" role="navigation">
        <div class="container-fluid">
          <!-- Brand and toggle get grouped for better mobile display -->
          <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#"><img src="./assets/header-logo.svg" height="30px" alt=""></a>
          </div>
          <!-- Collect the nav links, forms, and other content for toggling -->
          <div class="collapse navbar-collapse navbar-ex1-collapse">
            <ul class="nav navbar-nav navbar-right" v-if="!loginStatus">
              <li><router-link to="/login">Login</router-link></li>
              <li><router-link to="/signup">SignUp</router-link></li>
            </ul>
            <ul class="nav navbar-nav navbar-right" v-if="loginStatus">
              <li><router-link to="/dashboard"><span class="fa fa-tachometer"></span> Dashboard</router-link></li>
              <li><router-link to="/contacts"><span class="fa fa-users"></span> Contacts</router-link></li>
              <li><a v-on:click="logout()"><span class="fa fa-power-off"></span> Logout</a></li>
            </ul>
          </div><!-- /.navbar-collapse -->
        </div>
      </nav>
    </div>
    <!-- mobile header -->
    <div class="mobile-nav" v-bind:class="{ navActive: sidenav}">
      <div class="text-left">
        <el-button type="text btn-close f-right" @click.prevent="changeNav"><span class="fa fa-times"></span></el-button>
      </div>
      <br><br>
      <div>
        <ul class="mobile-navlist" v-if="!loginStatus">
          <li><a v-on:click="mobileNav('/login')"><span class="fa fa-lock"></span> Login</a></li>
          <li><a v-on:click="mobileNav('/signup')"><span class="fa fa-user"></span> Signup</a></li>
        </ul>
        <ul class="mobile-navlist" v-if="loginStatus">
          <li><a v-on:click="mobileNav('/dashboard')"><span class="fa fa-tachometer"></span> Dashboard</a></li>
          <li><a v-on:click="mobileNav('/contacts')"><span class="fa fa-users"></span> Contacts</a></li>
          <li><a v-on:click="logout()"><span class="fa fa-power-off"></span> Logout</a></li>
        </ul>
      </div>
    </div>
    <router-view @loginStatusChanged="loginStatusChanged"></router-view>
  </div>
</template>

<script>
import auth from '@/services/authService'
export default {
  name: 'App',
  data () {
    return {
      loginStatus: auth.getAuthStatus(),
      sidenav: false
    }
  },
  methods: {
    loginStatusChanged (value) {
      this.loginStatus = value
    },
    logout () {
      this.sidenav = false
      this.loginStatus = false
      if (auth.logout()) {
        this.$router.push('/login')
      }
    },
    changeNav () {
      this.sidenav = !this.sidenav
    },
    mobileNav (value) {
      this.$router.push(value)
      this.sidenav = !this.sidenav
    }
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  padding-top: 50px;
}
.header {
  background-color: white;
  box-shadow: 1px 1px 1px 1px rgba(0,0,0,0.1);
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 50;
}
.search-block {
  margin-left: 3em;
}
.search-block .form-control{
  width: 40vw;
  background-color: rgba(0,0,0,0.05);
  border-radius: 0px;
}
.mobile-header {
  padding: 0.7em 0em;
  display: flex;
  align-items: center;
}
.flx-cend {
  display: flex;
  justify-content: flex-end;
}
.btn-menu {
  font-size: 26px;
}
.mobile-nav {
  display: none;
  position: fixed;
  top: 0;
  right: 0;
  left: 0;
  bottom: 0;
  padding: 1em;
  background-color: rgba(0,0,0,0.7);
  z-index: 300;
  color: white;
  overflow:hidden;
}
.mobile-navlist {
  display: inline-block;
}
.mobile-navlist li {
  padding: 1em;
  overflow: hidden;
}
.mobile-navlist>li>a {
  color: white;
  font-size: 1.5em;
  letter-spacing: 1px;
}
.f-right {
  float: right;
}
.btn-close {
  color: red;
  font-weight: bold;
  font-size: 2em;
}
.navActive {
  display: block!important;
}
</style>
