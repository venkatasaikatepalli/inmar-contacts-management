<template>
  <div class="form">
    <h3 class="text-center"><b>{{ formTitle }}</b></h3>
    <div class="form-group">
      <label for="">Name</label>
      <input type="text" name="name" v-model="contactsGroupData.name">
    </div>
    <div class="form-group">
      <label for="">Status</label>
      <select name="" id="" v-model="contactsGroupData.status">
        <option value="1">Active</option>
        <option value="0">Inactive</option>
      </select>
    </div>
    <div class="text-center">
      <el-button type="success" @click.prevent="manageContactGroup">{{ formTitle }}</el-button>
    </div>
  </div>
</template>
<script>
import axios from 'axios'
import {constants} from '@/constants.js'
export default {
  props: ['contactsGroupData', 'formTitle', 'role'],
  data () {
    return {
      response: ''
    }
  },
  methods: {
    manageContactGroup () {
      axios.post(constants.manage_contacts_group, this.contactsGroupData)
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
