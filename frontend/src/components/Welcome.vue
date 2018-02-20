<template>
  <div class="welcome">
    <div class="full-height">
      <div class="cnt text-center full-width">
        <img src="@/assets/header-logo.svg" height="100px" alt="">
        <br><br>
        <p class="max-width-70">Anyone who has redeemed a coupon, filled a prescription or returned a product, has touched Inmar. We apply technology and data science to improve outcomes for consumers and those who serve them.</p>
        <ul class="list-inline">
          <li><button class="btn btn-success" @click.prevent="open('signup')">Signup</button></li>
          <li><button class="btn btn-primary"  @click.prevent="open('login')">Login</button></li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'HelloWorld',
  data () {
    return {
      msg: 'Welcome to Your Vue.js App'
    }
  },
  methods: {
    open (value) {
      this.$router.push(value)
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.welcome {
  background-image: url('https://images.unsplash.com/photo-1487058792275-0ad4aaf24ca7?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6726719ee78dabe78033950d9f3f7145&auto=format&fit=crop&w=1050&q=80');
  background-attachment: fixed;
  background-size: cover;
}
.full-height{
  background-color: rgba(255,255,255,0.9);
  min-height: 100vh;
  display: flex;
  align-items: center;
}
.btn{
  outline: none;
  margin:1em;
}
.max-width-70 {
  width: 70%;
  display: table;
  margin:1em auto;
  text-align: center;
}
</style>
