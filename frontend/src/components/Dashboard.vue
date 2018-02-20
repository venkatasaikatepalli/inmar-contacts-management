<template>
  <div class="dashboard">
    <div class="container">
      <div class="row">
        <div class="col-md-3">
          <div class="stat text-center">
            <h2>100</h2>
            <h3>Total Contacts</h3>
          </div>
        </div>
        <div class="col-md-3 text-center">
          <div class="stat">
            <h2>30</h2>
            <h3>Total Groups</h3>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import axios from 'axios'
import auth from '@/services/authService'
import {constants} from '../constants.js'
export default {
  data () {
    return {
      formData: {
        u_id: auth.getUserId()
      },
      stats: ''
    }
  },
  created () {
    this.checkAuthStatus()
    this.getStatistics()
  },
  methods: {
    checkAuthStatus () {
      if (!auth.getAuthStatus) {
        this.$router.push('\login')
      }
    },
    getStatistics () {
      axios.post(constants.get_stats, this.formData)
        .then((resp) => {
          if (resp.data.status === 'success') {
            this.stats = resp.data.stats
          }
        })
    }
  }
}
</script>
<style scoped>
.dashboard {
  background-image: url('https://images.unsplash.com/photo-1465411801898-f1a78de00afc?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=7c3c6df24265d43ff599a5c2f71d1b13&auto=format&fit=crop&w=1052&q=80');
  background-attachment: fixed;
  background-size: cover;
  min-height: 95vh;
}
.frame {
  /*height: 100%;*/
  /*background-color: rgba(255,255,255,0.2);*/
}
.box {
  background-color: white;
}
.stat {
  margin-top: 2em;
  background-color: white;
  border-radius: 5px;
  padding: 1em;
}
</style>
