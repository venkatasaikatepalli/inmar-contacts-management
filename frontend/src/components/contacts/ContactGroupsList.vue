<template>
  <div>
    <div v-if="viewRole === 'groups'">
      <div class="row">
        <div class="col-md-7">
          <h3 class="black"><span class="fa fa-users"></span> Contacts Groups Management</h3>
        </div>
        <div class="col-md-5 text-right">
          <button class="btn btn-primary" @click.prevent="openDialog('add', null)">+ Add New Group</button>
        </div>
      </div>
      <div class="row contact-head">
        <div class="col-md-6">
          <b>Name</b>
        </div>
        <div class="col-md-5">
          <b>Status</b>
        </div>
        <div class="col-md-1">
        </div>
      </div>
      <div class="contacts-list">
        <div class="row contact-item" v-for="item in contactsGroupsList" :key="item.name" >
          <div class="col-md-6 c-name" @click.prevent="openFullView(item)">
            {{item.name}}
          </div>
          <div class="col-md-5 c-number" @click.prevent="openFullView(item)">
            {{item.status}}
          </div>
          <div class="col-md-1 text-right">
            <ul class="list-inline">
              <li><a @click.prevent="openDialog('edit', item)"><span class="fa fa-pencil"></span></a></li>
              <li><a @click.prevent="openDialog('delete', item)"><span class="fa fa-trash"></span></a></li>
            </ul>
          </div>
        </div>
      </div>
    </div>
    <div v-if="viewRole === 'groupContacts'">
      <div class="row">
        <div class="col-md-3">
          <el-button size="mini" @click.prevent="viewRole = 'groups'"><span class="fa fa-left" ></span> <span class="fa fa-arrow-left"></span> Back</el-button>
        </div>
        <div class="col-md-6">
          <h3 class="text-center"><b><span class="fa fa-users"></span> {{contactsGroupsData.name}}</b></h3>
        </div>
      </div>
      <contacts-list :contacts-list="resultList" :contacts-groups-list="contactsGroupsList" @contactInfoChanged="contactGroupInfoChanged"></contacts-list>
    </div>
    <!-- contact dialog -->
    <el-dialog
      title=""
      :visible.sync="dialogVisible"
      width="30%">
      <manage-group :form-title="formTitle" :contacts-group-data="contactsGroupsData" :role="role" @contactGroupInfoChanged="contactGroupInfoChanged"></manage-group>
    </el-dialog>
  </div>
</template>
<script>
import {constants} from '@/constants.js'
import axios from 'axios'
import ManageGroup from '@/components/contacts/ManageGroup'
import ContactsList from '@/components/contacts/ContactsList'
export default {
  components: {
    ManageGroup,
    ContactsList
  },
  props: ['contactsGroupsList', 'contactsList'],
  data () {
    return {
      response: '',
      dialogVisible: false,
      fullViewVisible: false,
      contactsGroupsData: {},
      formTitle: '',
      viewRole: 'groups',
      role: '',
      userId: '102',
      resultList: []
    }
  },
  methods: {
    openDialog (event, data) {
      this.fullViewVisible = false
      this.contactsGroupsData = {}
      if (event === 'edit') {
        // make a popup
        this.dialogVisible = true
        this.role = 'edit'
        // change the formTitle
        this.formTitle = 'Edit Contacts Group'
        // generate form Data
        this.contactsGroupsData.id = data.id
        this.contactsGroupsData.name = data.name
        this.contactsGroupsData.status = data.status
        this.contactsGroupsData.u_id = this.userId
      }
      if (event === 'add') {
        // make a popup
        this.dialogVisible = true
        this.role = 'add'
        // change the formTitle
        this.formTitle = 'Add Contacts Group'
        this.contactsGroupsData.u_id = this.userId
      }
      if (event === 'delete') {
        this.contactsGroupsData.id = data.id
        this.$confirm('This will permanently delete the Group. Continue?', 'Warning', {
          confirmButtonText: 'Delete',
          cancelButtonText: 'Cancel',
          type: 'warning',
          center: true
        })
          .then(() => {
            this.deleteContact(data)
          })
          .catch(() => {
            this.$message({
              type: 'info',
              message: 'Delete canceled'
            })
          })
      }
    },
    deleteContact (data) {
      axios.post(constants.delete_contacts_group, this.contactsGroupsData)
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
    },
    openFullView (data) {
      this.viewRole = 'groupContacts'
      // this.fullViewVisible = true
      this.contactsGroupsData = data
      this.filterGroupContacts(data.id)
    },
    back () {
      this.viewRole = 'groups'
    },
    contactGroupInfoChanged () {
      this.dialogVisible = false
      this.$emit('contactGroupInfoChanged')
    },
    filterGroupContacts (searchKey) {
      this.resultList = []
      var len = this.contactsList.length
      if (len > 0) {
        for (var i = 0; i < len; i++) {
          if (this.contactsList[i].group_id === searchKey) {
            this.resultList.push(this.contactsList[i])
          }
        }
      }
    }
  }
}
</script>
<style scoped>
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
    cursor: pointer;
  }
  .contact-item:hover {
    background-color: rgba(0,0,0,0.01);
    font-weight: bold;
  }
  .contact-item:hover .contact-item .fa{
    color: white;
  }
  .contacts-list {
    max-height: 80vh;
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
  .contact-pop-info {
    padding: 0em 1em 1em;
  }
  .contact-pop-info p{
    font-weight: bold;
    font-size: 1em;
  }
</style>
