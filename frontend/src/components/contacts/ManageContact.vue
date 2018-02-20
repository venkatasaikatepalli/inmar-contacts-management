<template>
  <div class="form">
    <h3 class="text-center"><b>{{ formTitle }}</b></h3>
    <div class="form-group">
      <label for="">Name</label>
      <input type="text" name="name" v-model="contactData.name">
      <span class="error" v-if="errors.name">{{errors.name}}</span>
    </div>
    <div class="form-group">
      <label for="">Mobile</label>
      <input type="number" name="name" v-model="contactData.mobile">
      <span class="error" v-if="errors.mobile">{{errors.mobile}}</span>
    </div>
    <div class="form-group">
      <label for="">Email</label>
      <input type="email" name="name" v-model="contactData.email">
      <span class="error" v-if="errors.email">{{errors.email}}</span>
    </div>
    <div class="form-group">
      <label for="">Status</label>
      <select name="" id="" v-model="contactData.status">
        <option value="Active">Active</option>
        <option value="InActive">Inactive</option>
      </select>
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
      response: '',
      errors: {
        name: '',
        email: '',
        mobile: ''
      }
    }
  },
  methods: {
    manageContact () {
      if (this.validate()) {
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
    },
    validate () {
      if (this.contactData.name === '') {
        this.errors.name = 'Name field is required'
      } else if (this.contactData.mobile === '') {
        this.errors.mobile = 'Mobile field is required'
      } else if (this.contactData.email === '') {
        this.errors.email = 'Email field is required'
      } else {
        return true
      }
    }
  }
}
</script>
