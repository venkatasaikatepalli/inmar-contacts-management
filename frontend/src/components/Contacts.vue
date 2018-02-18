<template>
  <div class="">
    <div class="container-fluid">
      <div class="row" style="display:flex;">
        <div class="col-md-2 bg-blue no-pad">
          <ul class="side-nav">
            <li>
              <a href="#">Contacts</a>
            </li>
            <li>
              <a href="#">Contact Groups</a>
            </li>
          </ul>
        </div>
        <div class="col-md-10 bg-grey min-95 contacts-block">
          <div class="row">
            <div class="col-md-7">
              <h3 class="black"><span class="fa fa-users"></span> Contacts Management</h3>
            </div>
            <div class="col-md-5 text-right">
              <button class="btn btn-primary">+ Add New</button>
              <button class="btn btn-primary">+ Add New Group</button>
            </div>
          </div>
          <!-- <div class="row contact-head">
            <div class="col-md-1">
              SNO
            </div>
            <div class="col-md-5">
              <b>Name</b>
            </div>
            <div class="col-md-5">
              <b>Mobile Number</b>
            </div>
            <div class="col-md-1">
            </div>
          </div>
          <div class="contacts-list">
            <div class="row contact-item" v-for="(item, index) in contactsList">
              <div class="col-md-1">
                {{index + 1}}
              </div>
              <div class="col-md-5 c-name">
                {{item.name}}
              </div>
              <div class="col-md-5 c-number">
                {{item.mobile}}
              </div>
              <div class="col-md-1 text-right">
                <ul class="list-inline">
                  <li><a href=""><span class="fa fa-pencil"></span></a></li>
                  <li><a href=""><span class="fa fa-trash"></span></a></li>
                </ul>
              </div>
            </div>
          </div> -->
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
.contact-head {
  background-color: blue;
  margin:0;
  padding: 1em;
}
.contact-item {
  background-color: white;
  color: black;
  padding: 1em;
  border-bottom: 1px solid rgba(0,0,0,0.1);
}
.contact-item:hover {
  background-color: #4A2AD5;
  color: white;
  font-weight: bold;
}
.contacts-list {
  height: 80vh;
  overflow-y: scroll;
  width: 100%;
  box-shadow: 1px 1px 10px 1px rgba(0,0,0,0.10);
  font-size: 0.9em;
  letter-spacing: 1px;
}
.contacts-list .row{
  margin: 0;
}
.contacts-list::-webkit-scrollbar {
    width: 2px;
}
.contacts-list::-webkit-scrollbar-track {
    -webkit-box-shadow: inset 0 0 3px rgba(0,1.0,0,0.3);
    /*-webkit-box-shadow: inset 0 0 3px blue;*/
}
.contacts-list::-webkit-scrollbar-thumb {
  background-color:orange;
  /*outline: 0px solid #BA4A00;*/
  outline: 0px solid blue;
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
}
</style>
