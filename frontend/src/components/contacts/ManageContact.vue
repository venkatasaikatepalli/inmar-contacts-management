<template>
  <div class="form">
    <h3 class="text-center"><b>{{ formTitle }}</b></h3>
    <div class="form-group">
      <label for="">Name</label>
      <input type="text" name="name" v-model="contactData.name">
    </div>
    <div class="form-group">
      <label for="">Mobile</label>
      <input type="number" name="name" v-model="contactData.mobile">
    </div>
    <div class="form-group">
      <label for="">Email</label>
      <input type="text" name="name" v-model="contactData.email">
    </div>
    <div class="form-group">
      <label for="">Group</label>
      <select name="" v-model="contactData.group_id" id="">
        <option v-for="item in contactsGroupsList" :key="item.name" v-bind:value="item.id">{{item.name}}</option>
      </select>
    </div>

    <div class="text-center">
      <el-button type="success" @click.prevent="manageContact">{{ formTitle }}</el-button>
    </div>
  </div>
</template>
<script>
import axios from 'axios'
import {constants} from '@/constants.js'
export default {
  props: ['contactData', 'formTitle', 'role', 'contactsGroupsList'],
  data () {
    return {
      response: ''
    }
  },
  methods: {
    manageContact () {
      axios.post(constants.manage_contact, this.contactData)
        .then((resp) => {
          if (resp.data.status === 'success') {
            this.$notify({
              title: 'Success',
              message: resp.data.message,
              type: 'success'
            })
            this.$emit('contactInfoChanged')
          }
        })
        .catch((err) => {
          this.$notify({
            title: 'Failed',
            message: err.response.data.message,
            type: 'error'
          })
        })
    }
  }
}
</script>
