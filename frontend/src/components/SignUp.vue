<template>
  <div class="">
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-12 signup-img-block">
          <div class="row">
            <div class="col-md-6 no-pad hidden-xs">
              <div class="history">
                <div class="text-center">
                  <h3>Inmar Contacts</h3>
                  <p>A place to make more do less. Which will provide a effective quality of a product. Save your contacts on our Cloud be a secure person by joining our cloud.</p>
                  <div class="row">
                    <div class="col-md-6 text-center">
                      <h3 class="card"><span class="fa fa-address-book"></span></h3>
                      <h3>Contacts</h3>
                    </div>
                    <div class="col-md-6 text-center">
                      <h3 class="card"><span class="fa fa-address-book"></span></h3>
                      <h3>Contact Groups</h3>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-md-6 signup-form-block text-left">
              <h3 class="sub-head blue">Signup For New Account</h3>
              <form v-if="status === 'notlogin'">
                <div class="row">
                  <div class="col-md-6 no-pad">
                    <div class="form-item">
                      <label for="firstName">First Name</label>
                      <input type="text" name="firstName" v-model="formData.firstName" placeholder="First Name">
                      <span class="error" v-if="error.firstName">{{error.firstName}}</span>
                    </div>
                  </div>
                  <div class="col-md-6 no-pad">
                    <div class="form-item">
                      <label for="firstName">Last Name</label>
                      <input type="text" name="lastName" v-model="formData.lastName" placeholder="Last Name">
                      <span class="error" v-if="error.lastName">{{error.lastName}}</span>
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-md-6 col-xs-6 no-pad">
                    <div class="form-item">
                      <label for="firstName">Email Address</label>
                      <input type="text" name="email" v-model="email.name" placeholder="emailaddress">
                      <span class="error" v-if="error.email">{{error.email}}</span>
                    </div>
                  </div>
                  <div class="col-md-6 col-xs-6 no-pad">
                    <div class="form-item">
                      <label for="firstName"><br></label>
                      <input type="text" name="email" disabled v-model="email.domain" placeholder="emailaddress">
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-md-12 no-pad">
                    <div class="form-item">
                      <label for="firstName">Password</label>
                      <input type="password" name="password" v-model="formData.password" placeholder="Enter Password">
                      <p class="error" v-if="error.password" :key="item" v-for="item in error.password">{{item}}</p><br>
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-md-12 no-pad">
                    <div class="form-item">
                      <label for="firstName">Aadhar Number</label>
                      <input type="number" name="aadhar" v-model="formData.aadharno" placeholder="XXXX XXXX XXXX">
                      <span class="error" v-if="error.aadharno">{{error.aadharno}}</span>
                    </div>
                  </div>
                </div>
                <div class="text-right mb-top-1">
                  <button class="btn btn-primary" @click.prevent="signup()">
                    Signup
                  </button>
                </div>
              </form>
              <div v-if="status === 'success'">
                <p class="sMessage">{{response}}</p>
                <button @click.prevent="redirectLogin()" class="btn btn-primary">Go to Login Page</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import axios from 'axios'
import {constants} from '../constants.js'
export default {
  data () {
    return {
      error: [],
      email: {
        name: 'sai',
        domain: '@inmar.com'
      },
      formData: {
        firstName: 'Venkata',
        lastName: 'sai',
        email: '',
        password: '',
        aadharno: '123456789012'
      },
      response: '',
      status: 'notlogin'
    }
  },
  methods: {
    signup () {
      this.error = []
      if (this.validate()) {
        axios.post(constants.signup, this.formData)
          .then((response) => {
            if (response.data.status === 'success') {
              this.status = response.data.status
              this.response = response.data.message
            }
            if (response.data.status === 'failed') {
              if (response.data.errors) {
                this.error = response.data.errors
              }
            }
          })
      } else {
        this.$notify({
          title: 'Failed',
          message: 'Please Enter Valid Details',
          type: 'error'
        })
      }
    },
    validate () {
      this.formData.email = this.email.name + this.email.domain
      if (this.formData.firstName === '') {
        this.error.firstName = 'LastName is required'
      } else if (this.formData.firstName === '') {
        this.error.lastName = 'LastName is required'
      } else if (this.formData.email.name === '') {
        this.error.email = 'Email is required'
      } else if (!this.validatePassword()) {
        // this.error.password = 'Password is required'
      } else if (this.formData.aadharno === '') {
        this.error.aadharno = 'Aadhar no is required'
      } else if (this.formData.aadharno.length !== 12) {
        this.error.aadharno = 'Please Enter Valid Aadhar no'
      } else {
        return true
      }
    },
    validatePassword () {
      var p = this.formData.password
      this.error.password = []
      if (p.length < 8) {
        this.error.password.push('Your password must be at least 8 characters.')
      }
      if (p.search(/[a-z]/i) < 0) {
        this.error.password.push('Your password must contain at least one letter.')
      }
      if (p.search(/[A-Z]/i) < 0) {
        this.error.password.push('Your password must contain at least Uppercase. letter.')
      }
      if (p.search(/[0-9]/) < 0) {
        this.error.password.push('Your password must contain at least one digit.')
      }
      if (this.error.password.length > 0) {
        return false
      }
      return true
    },
    redirectLogin () {
      this.$router.push('/login')
    }
  }
}
</script>
<style scoped>
.signup-img-block {
  background-image: url('https://images.unsplash.com/photo-1457317680121-ef12e98979e8?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a41dc0dcd19e2358b1acb5e17b298aed&auto=format&fit=crop&w=1050&q=80');
  /*position: fixed;*/
  background-repeat: no-repeat;
  background-size: cover;
  height: 100vh;
}
.signup-form-block {
  background: linear-gradient(to right, rgba(255,255,255,0.8) 10%, white 100%);
  height: 100vh;
  padding: 1em 2em;
}
.form-item{
  padding: 1em;
}
.form-item label{
  font-size: 0.7em;
}
.form-item input{
  border:none;
  width: 100%;
  font-size: 0.9em;
  border-bottom: 1px solid black;
  outline: none;
  box-shadow: none;
  background:transparent;
  padding: 0.5em 0em;
}
.form-item input:focus{
  border-color: blue;
}
.history {
  padding: 2em;
  color: white;
  height: 100vh;
  display: flex;
  align-items: center;
  text-align: center;
  background-color: rgba(0,0,0,0.5);
}
.history h3 {
  font-weight: bold;
  font-size: 1.5em;
}
.card .fa{
  font-size: 4em;
  color:#3dae2b;
}
</style>
