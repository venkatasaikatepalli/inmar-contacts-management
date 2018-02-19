<template>
  <div class="">
    <div class="container-fluid">
      <div class="row" style="display:flex;">
        <div class="col-md-2 bg-blue no-pad">
          <ul class="side-nav">
            <li>
              <a href="#"><span class="fa fa-address-book"></span> Contacts</a>
            </li>
            <li>
              <a href="#"><span class="fa fa-users"></span> Contact Groups</a>
            </li>
          </ul>
        </div>
        <div class="col-md-10 bg-grey min-95 contacts-block">
          <contacts-list :contacts-list="contactsList"></contacts-list>
        </div>
      </div>
    </div>
    <!-- <p>{{contactsList}}</p> -->
  </div>
</template>
<script>
import axios from 'axios'
import {constants} from '../constants.js'
import ContactsList from '@/components/contacts/ContactsList'
export default {
  components: {
    ContactsList
  },
  data () {
    return {
      u_id: '102',
      formData: {
        u_id: '102'
      },
      contactsList: [],
      response: ''
    }
  },
  created () {
    this.getContactsList()
  },
  methods: {
    getContactsList () {
      axios.post(constants.get_contacts, this.formData)
        .then((resp) => {
          if (resp.data.status === 'success') {
            this.contactsList = resp.data.contacts
          }
        })
        .catch((err) => {
          console.log(err)
        })
    }
  }
}
</script>
<style scoped>
.contacts-block {
  padding: 1em 2em;
  color: white;
}
.side-nav {
  margin:0px;
  padding:0px;
  width: 100%;
  display: inline-block;
}
.side-nav li {
  overflow: hidden;
  padding: 1em;
  color: white;
  width: 100%;
  text-align: left;
  border-bottom: 1px solid rgba(255,255,255,0.5);
}
.side-nav>li>a {
  color: white;
  font-weight: bold;
}
</style>
