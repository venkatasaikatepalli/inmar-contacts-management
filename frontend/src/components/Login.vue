<template>
  <div class="login">
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-offset-4 col-md-4">
          <div class="login-form">
            <h3 class="sub-head blue text-center"><span class="fa fa-lock"></span> Login</h3>
              <p class="error text-center"><b>{{error}}</b></p>
            <form >
              <div class="form-group">
                <label for="exampleDropdownFormEmail1">Email address</label>
                <input type="email" class="form-control" v-model="formData.email"  placeholder="email@inmar.com">
              </div>
              <div class="form-group">
                <label for="exampleDropdownFormPassword1">Password</label>
                <input type="password" class="form-control" v-model="formData.password" placeholder="Password">
              </div>
              <div class="form-check">
                <input type="checkbox" class="form-check-input" id="dropdownCheck">
                <label class="form-check-label" for="dropdownCheck">
                  Remember me
                </label>
              </div>
              <button type="submit" @click.prevent="login()" class="btn btn-primary">Sign in</button>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import axios from 'axios'
import auth from '@/services/authService'
import {constants} from '@/constants.js'
export default {
  data () {
    return {
      formData: {
        email: 'venkatasaisoft@inmar.com',
        password: '123456'
      },
      errors: {
        email: '',
        password: ''
      },
      response: '',
      error: ''
    }
  },
  created () {
    this.checkAuthStatus()
  },
  methods: {
    checkAuthStatus () {
      if (auth.checkAuthStatus) {
        this.$router.push('/dashboard')
      }
    },
    login () {
      axios.post(constants.login, this.formData)
        .then((resp) => {
          if (resp.data.status === 'success') {
            this.status = resp.data.status
            auth.setAuthToken(resp.data.token)
            auth.setUserDetails(resp.data.userDetails)
            this.$emit('loginStatusChanged', true)
            this.$router.push('/dashboard')
          }
          if (resp.data.status === 'failed') {
            this.error = resp.data.message
          }
        })
    }
  }
}
</script>
<style scoped>
.login {
  min-height: 95vh;
  background-image: url('https://images.unsplash.com/photo-1454372182658-c712e4c5a1db?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=222a0154798d92d5950fd34abd985a18&auto=format&fit=crop&w=1050&q=80');
  background-size: cover;
  background-repeat: no-repeat;
}
.login-form {
  padding: 1em;
  margin-top: 20%;
  background-color: rgba(255,255,255,0.7);
  border-radius: 5px;
}
.form-group{
  text-align: left;
  margin:1em 0em;
}
.form-group input{
  border:none;
  width: 100%;
  font-size: 0.9em;
  border-bottom: 1px solid black;
  outline: none;
  border-radius: 0px;
  box-shadow: none;
  background:transparent;
  padding: 0.5em;
}
.form-group input:focus{
  border-color: blue;
}
</style>
