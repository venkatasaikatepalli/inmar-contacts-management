<template>
  <div class="">
    <div class="container-fluid">
      <div class="row" style="display:flex;">
        <div class="col-md-2 bg-blue no-pad">
          <ul class="side-nav">
            <li>
              <p @click.prevent="tab = 'contacts'"><span class="fa fa-address-book"></span> Contacts</p>
            </li>
            <li>
              <p @click.prevent="tab = 'groups'"><span class="fa fa-users"></span> Contact Groups</p>
            </li>
          </ul>
        </div>
        <div class="col-md-10 bg-grey min-95">
          <div class="form-group">
            <input type="text" class="form-control search-bar" v-model="searchKey" v-on:keyup="filterContacts" placeholder="Search">
          </div>
          <button class="btn btn-primary" @click.prevent="filterContacts">Filter</button>
          <contacts-list v-if="tab === 'contacts'" :contacts-list="contactsList" @contactInfoChanged="getContactsList"></contacts-list>
          <contacts-groups-list v-if="tab === 'groups'" :contacts-groups-list="contactsGroupsList" @contactInfoChanged="getContactsList"></contacts-groups-list>
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
import ContactsGroupsList from '@/components/contacts/ContactGroupsList'
export default {
  components: {
    ContactsList,
    ContactsGroupsList
  },
  data () {
    return {
      tab: 'contacts',
      searchKey: '',
      searchContactsList: [],
      resultList: [],
      userId: 102,
      formData: {
        u_id: '102'
      },
      contactsList: [],
      contactsGroupsList: [],
      response: '',
      fruits: ['apple', 'banana', 'grapes', 'mango', 'orange']
    }
  },
  created () {
    this.getContactsList()
    this.getContactsGroupsList()
  },
  methods: {
    filterItems (query) {
      return this.fruits.filter(function (el) {
        return el.toLowerCase().indexOf(query.toLowerCase()) > -1
      })
    },
    filterContacts () {
      var len = this.searchContactsList.length
      if (len > 0) {
        for (var i = 0; i < len; i++) {
          if (this.searchContactsList[i].name.toLowerCase().indexOf(this.searchKey) >= 0) {
            this.resultList.push(this.searchContactsList[i])
          }
        }
      }
      // string1.indexOf(string2) >= 0
    },
    getContactsList () {
      axios.post(constants.get_contacts, this.formData)
        .then((resp) => {
          if (resp.data.status === 'success') {
            this.contactsList = resp.data.contacts
            this.searchContactsList = resp.data.contacts
          }
        })
        .catch((err) => {
          console.log(err)
        })
    },
    getContactsGroupsList () {
      axios.post(constants.get_contacts_groups, this.formData)
        .then((resp) => {
          if (resp.data.status === 'success') {
            this.contactsGroupsList = resp.data.contacts
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
.side-nav>li>p {
  color: white;
  font-weight: bold;
  cursor: pointer;
}
.search-bar {
  border:none;
  border-radius: 0px;
  border-bottom: 1px solid rgba(0,0,0,0.2);
  background-color: transparent;
  margin: 1.5em 0em;
  width: 40%;
  outline: none;
  box-shadow: none;
}
</style>
