<template>
  <div class="">
    <div class="container-fluid">
      <div class="row" style="display:flex;">
        <div class="col-md-2 bg-blue no-pad">
          <!-- sidenav -->
          <ul class="side-nav">
            <li>
              <p @click.prevent="tab = 'contacts'"><span class="fa fa-address-book"></span> Contacts ({{contactsList.length}})</p>
            </li>
            <li>
              <p @click.prevent="tab = 'groups'"><span class="fa fa-users"></span> Contact Groups ({{contactsGroupsList.length}})</p>
            </li>
          </ul>
        </div>
        <div class="col-md-10 bg-grey min-95">
          <!-- full-block -->
          <br>
          <div class="form-group hidden">
            <input type="text" class="form-control search-bar" v-model="searchKey" v-on:keyup="filterContacts" placeholder="Search">
          </div>
          <div v-if="resultList">
            <h3><b><span class="fa fa-address-book"></span> Contacts ({{resultList.length}})</b></h3>
           <contacts-list :contacts-list="resultList" @contactInfoChanged="getContactsList"></contacts-list>
          </div>
          <div v-if="resultGroupsList">
            <h3><b><span class="fa fa-users"></span> Contacts Groups ({{resultGroupsList.length}})</b></h3>
            <contacts-groups-list :contacts-groups-list="resultGroupsList" @contactGroupInfoChanged="getContactsGroupsList" @contactInfoChanged="getContactsList"></contacts-groups-list>
          </div>

          <!-- tabs -->
          <div  v-if="tab === 'contacts'">
            <div class="row">
              <div class="col-md-7">
                <h3 class="black"><span class="fa fa-address-book"></span> Contacts Management</h3>
              </div>
              <div class="col-md-5 text-right">
                <button class="btn btn-primary" @click.prevent="openDialog('add', null)">+ Add New Contact</button>
              </div>
            </div>
            <contacts-list :contacts-list="contactsList" @contactInfoChanged="getContactsList" :contacts-groups-list="contactsGroupsList"></contacts-list>
          </div>
          <div v-if="tab === 'groups'">
            <contacts-groups-list :contacts-list="contactsList" :contacts-groups-list="contactsGroupsList" @contactGroupInfoChanged="getContactsGroupsList"></contacts-groups-list>
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
      userId: 102,
      formData: {
        u_id: '102'
      },
      contactsList: [],
      contactsGroupsList: [],
      response: '',
      dialogVisible: false,
      contactData: {},
      formTitle: '',
      role: ''
    }
  },
  created () {
    this.getContactsList()
    this.getContactsGroupsList()
  },
  methods: {
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
  margin-top:2em;
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
.srch-cnt-head {
  padding: 1em 0em;
}
.srch-cnt-item {
  border-bottom: 1px solid rgba(0,0,0,0.2);
  padding: 0.5em;
}
</style>
