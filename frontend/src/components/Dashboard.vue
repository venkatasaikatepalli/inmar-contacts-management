<template>
  <div class="dashboard">
    <div class="container-fluid">
    <div class="row">
      <div class="col-md-12 min-50">
      <div class="search-box full-width">
        <input type="text" focus name="searchbar" class="dashboard-search-bar" placeholder="Search Contacts and Groups"  v-model="searchKey" v-on:keyup="filterContacts">
      </div>
      </div>
    </div>
    <div class="row pad-1">
      <div class="col-md-12 bg-white min-60">
        <br>
        <div class="sticky-mbl bg-white" v-if="tab === ''">
          <!-- if search bar type -->
          <h3 class="text-center" v-if="searchKey">Search Results for ` <b><span class="green">{{searchKey}}</span> </b>`</h3>
          <div v-if="resultList">
            <div class="row pad-1">
              <div class="col-md-7">
                <h3><b><span class="fa fa-address-book"></span> Contacts ({{resultList.length}})</b></h3>
              </div>
              <div class="col-md-5 text-right pad-1 hidden-xs">
                <button class="btn btn-primary" @click.prevent="openDialog('add', null)">+ Add New Contact</button>
              </div>
            </div>
           <contacts-list :contacts-list="resultList" @contactInfoChanged="getContactsList"></contacts-list>
          </div>
          <div v-if="resultGroupsList">
            <h3><b><span class="fa fa-users"></span> Contacts Groups ({{resultGroupsList.length}})</b></h3>
            <contacts-groups-list :contacts-groups-list="resultGroupsList" @contactGroupInfoChanged="getContactsGroupsList" @contactInfoChanged="getContactsList"></contacts-groups-list>
          </div>
        </div>
        <div class="row bg-white min-60">
          <div class="col-md-3">
            <div class="stat text-center">
              <h2>{{response.conatactslist[0].contacts}}</h2>
              <h3><span class="fa fa-address-book"></span> Total Contacts</h3>
            </div>
          </div>
          <div class="col-md-3 text-center">
            <div class="stat">
              <h2>{{response.groups.contactgroups}}</h2>
              <h3><span class="fa fa-users"></span> Total Groups</h3>
              
            </div>
          </div>
        </div>
      </div>
    </div>
    </div>
    <!-- contact dialog -->
    <el-dialog
      title=""
      :visible.sync="dialogVisible"
      width="30%">
      <manage-contact :form-title="formTitle" :contact-data="contactData" :role="role" @contactInfoChanged="contactAdded" :contacts-groups-list="contactsGroupsList"></manage-contact>
    </el-dialog>
  </div>
</template>
<script>
import axios from 'axios'
import auth from '@/services/authService'
import {constants} from '../constants.js'
import ContactsList from '@/components/contacts/ContactsList'
import ManageContact from '@/components/contacts/ManageContact'
import ContactsGroupsList from '@/components/contacts/ContactGroupsList'
export default {
  components: {
    ContactsList,
    ManageContact,
    ContactsGroupsList
  },
  data () {
    return {
      tab: 'contacts',
      searchKey: '',
      searchContactsList: [],
      resultList: '',
      resultGroupsList: '',
      userId: auth.getUserId(),
      formData: {
        u_id: auth.getUserId()
      },
      contactsList: [],
      contactsGroupsList: [],
      response: '',
      dialogVisible: false,
      contactData: {},
      formTitle: '',
      role: '',
      stats: {
        contacts: '',
        groups: ''
      }
    }
  },
  created () {
    this.checkAuthStatus()
    this.getStatistics()
    this.getContactsList()
    this.getContactsGroupsList()
  },
  methods: {
    checkAuthStatus () {
      if (!auth.getAuthStatus) {
        var url = '\login'
        this.$router.redirect(url)
      }
    },
    filterContacts () {
      this.tab = ''
      this.resultList = []
      var len = this.searchContactsList.length
      if (len > 0) {
        for (var i = 0; i < len; i++) {
          if (this.searchContactsList[i].name.toLowerCase().indexOf(this.searchKey) >= 0) {
            this.resultList.push(this.searchContactsList[i])
          }
        }
      }
      this.resultGroupsList = []
      var lenn = this.contactsGroupsList.length
      if (lenn > 0) {
        for (var j = 0; j < lenn; j++) {
          if (this.contactsGroupsList[j].name.toLowerCase().indexOf(this.searchKey) >= 0) {
            this.resultGroupsList.push(this.contactsGroupsList[j])
          }
        }
      }
      // string1.indexOf(string2) >= 0
    },
    filterContact () {
      if (this.searchKey === '') {
        this.tab = 'some'
      } else {
        this.tab = ''
      }
      this.resultList = this.filter(this.contactsList, name, this.searchKey)
      this.resultGroupsList = this.filter(this.contactsGroupsList, name, this.searchKey)
    },
    filter (datalist, searchKey, searchValue) {
      let result = []
      var len = datalist.length
      if (len > 0) {
        for (var i = 0; i < len; i++) {
          if (this.datalist[i][searchKey].toLowerCase().indexOf(searchValue) >= 0) {
            result.push(datalist[i])
          }
        }
        return result
      }
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
    },
    openDialog (event, data) {
      this.contactData = {}
      if (event === 'add') {
        // make a popup
        this.dialogVisible = true
        this.role = 'add'
        // change the formTitle
        this.formTitle = 'Add Contact'
        this.contactData.u_id = this.userId
        this.contactData.name = ''
        this.contactData.email = ''
        this.contactData.mobile = ''
        this.contactData.group_id = ''
      }
    },
    contactAdded () {
      this.dialogVisible = false
      this.getContactsList()
    },
    tabChange (value) {
      this.tab = value
      this.searchKey = ''
    },
    getStatistics () {
      axios.post(constants.get_stats, this.formData)
        .then((resp) => {
          if (resp.data.status === 'success') {
            this.response = resp.data
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
.min-50{
  min-height: 50vh;
  background-color: rgba(0,0,0,0.4);
  display: flex;
  align-items: center;
}
.dashboard-search-bar {
  width: 70%;
  display: table;
  margin:0 auto;
  background-color: transparent;
  border:none;
  font-size: 2em;
  letter-spacing: 2px;
  color: orange;
  outline: none;
  padding: 0.1em;
  border-bottom: 1px solid rgba(255,255,255,1);
}
::placeholder { /* Chrome, Firefox, Opera, Safari 10.1+ */
    color: rgba(255,255,255,0.5);
    opacity: 1; /* Firefox */
}
:-ms-input-placeholder { /* Internet Explorer 10-11 */
    color: rgba(255,255,255,0.5)
}
::-ms-input-placeholder { /* Microsoft Edge */
    color: rgba(255,255,255,0.5)
}
.min-60 {
  min-height: 60vh;
}
</style>
