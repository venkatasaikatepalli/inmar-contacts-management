<template>
  <div id="app">
    <div class="header">
      <nav class="navbar" role="navigation">
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
    <router-view @loginStatusChanged="loginStatusChanged"></router-view>
  </div>
</template>

<script>
import auth from '@/services/authService'
export default {
  name: 'App',
  data () {
    return {
      loginStatus: auth.getAuthStatus()
    }
  },
  methods: {
    loginStatusChanged (value) {
      this.loginStatus = value
    },
    logout () {
      if (auth.logout()) {
        this.$router.push('/login')
      }
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
</style>
