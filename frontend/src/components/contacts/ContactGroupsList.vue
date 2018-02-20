<template>
  <div>
    <div v-if="viewRole === 'groups'">
      <div class="row">
        <div class="col-md-7">
          <h3 class="black"><span class="fa fa-users"></span> Contacts Groups Management</h3>
        </div>
        <div class="col-md-5 text-right hidden-xs">
          <button class="btn btn-primary" @click.prevent="openDialog('add', null)">+ Add New Group</button>
        </div>
      </div>
      <div class="full-block-table">
        <div class="row contact-head hidden-xs">
          <div class="col-md-6">
            <b>Name</b><br>
            <!-- <span v-if="sortkey.name === 'yes'" class="fa fa-sort-up f-right" @click.prevent="sort('name')"></span>
            <span v-if="sortkey.name === ''" class="fa fa-sort-down f-right" @click.prevent="sort('name')"></span> -->
            <input type="text" class="table-search-bar" v-model="searchKey.name" v-on:keyup="filterMe('name')" placeholder="Search">
          </div>
          <div class="col-md-5">
            <b>Status</b><br>
            <!-- <span v-if="sortkey.name === 'yes'" class="fa fa-sort-up f-right" @click.prevent="sort('name')"></span>
            <span v-if="sortkey.name === ''" class="fa fa-sort-down f-right" @click.prevent="sort('name')"></span> -->
            <input type="text" class="table-search-bar" v-model="searchKey.status" v-on:keyup="filterMe('status')" placeholder="Search">
          </div>
          <div class="col-md-1">
          </div>
        </div>
        <div class="row visible-xs contact-head">
          <div class="col-xs-8">
            <h3><span class="fa fa-users"></span> Groups</h3>
          </div>
          <div class="col-xs-4">
            <h2 class="text-right"><span class="fa fa-user-plus" @click.prevent="openDialog('add', null)"></span></h2>
          </div>
        </div>
        <div class="contacts-list">
          <div class="row contact-item" v-for="item in pageinList" :key="item.name" >
            <div class="col-md-6 c-name" @click.prevent="openFullView(item)">
              {{item.name}}
            </div>
            <div class="col-md-5 c-number" @click.prevent="openFullView(item)">
              <p v-if="item.status === '1'">Active</p>
              <p class="red" v-if="item.status === '0'">InActive</p>
            </div>
            <div class="col-md-1 text-right">
              <ul class="list-inline">
                <li><a @click.prevent="openDialog('edit', item)"><span class="fa fa-pencil"></span></a></li>
                <li><a @click.prevent="openDialog('delete', item)"><span class="fa fa-trash red"></span></a></li>
              </ul>
            </div>
          </div>
        </div>
        <div class="row pagin">
          <div class="col-md-3">
            <el-button size="mini" @click.prevent="prevPage">Previous Page</el-button>
          </div>
          <div class="col-md-2 text-center">
            <p><span>Current Page: <b>{{paginData.pageNum}}/{{paginData.pages}}</b></span></p>
          </div>
          <div class="col-md-2 text-center">
            Per Page: <select  v-model="paginData.perPage" v-on:change="createPagin(contactsGroupsList)">
              <option value="5">5</option>
              <option value="10">10</option>
              <option value="20">20</option>
            </select>
          </div>
          <div class="col-md-2 text-center">
            <p class="text-center"><span>Total: <b>{{paginData.total}}</b></span></p>
          </div>
          <div class="col-md-3 text-right">
            <el-button size="mini" @click.prevent="nextPage">Next Page</el-button>
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
import auth from '@/services/authService'
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
      userId: auth.getUserId(),
      resultList: [],
      paginData: {
        perPage: 5,
        total: 0,
        pages: 0,
        pageNum: 1
      },
      pageinList: [],
      searchKey: {
        name: '',
        status: ''
      },
      sortKey: {
        name: '',
        status: ''
      }
    }
  },
  created () {
    this.createPagin(this.contactsGroupsList)
  },
  watch: {
    contactsGroupsList: function () {
      this.createPagin(this.contactsGroupsList)
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
        this.contactsGroupsData.status = 1
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
    },
    createPagin (datalist) {
      let len = datalist.length
      this.paginData.total = len
      this.paginData.pageNum = 1
      if (len < this.paginData.perPage) {
        this.paginData.pages = 1
        this.paginate(datalist)
      } else {
        if (len % this.paginData.perPage > 0) {
          this.paginData.pages = parseInt(len / this.paginData.perPage) + 1
          // this.paginData.pages = len / this.paginData.perPage
        } else {
          this.paginData.pages = len / this.paginData.perPage
        }
        if (this.paginData.total > 0) {
          this.paginate(datalist)
        }
      }
    },
    nextPage () {
      if (this.paginData.pageNum < this.paginData.pages) {
        this.paginData.pageNum += 1
        this.paginate(this.contactsList)
      }
    },
    prevPage () {
      if (this.paginData.pageNum > 1) {
        this.paginData.pageNum -= 1
        this.paginate(this.contactsList)
      }
    },
    paginate (datalist) {
      let len = datalist.length
      let start = (this.paginData.pageNum - 1) * this.paginData.perPage
      let end = this.paginData.pageNum * this.paginData.perPage
      this.pageinList = []
      if (end < len) {
        for (var i = start; i < end; i++) {
          this.pageinList.push(datalist[i])
        }
      } else {
        for (var j = start; j < this.paginData.total; j++) {
          this.pageinList.push(datalist[j])
        }
      }
    },
    filterMe (value) {
      this.createPagin(this.filter(this.contactsGroupsList, value, this.searchKey[value]))
    },
    filter (datalist, searchKey, searchValue) {
      let result = []
      var len = datalist.length
      if (len > 0) {
        for (var i = 0; i < len; i++) {
          if (datalist[i][searchKey].toLowerCase().indexOf(searchValue) >= 0) {
            result.push(datalist[i])
          }
        }
        return result
      }
    },
    sort (value) {
      this.sortkey[value] = 'yes'
      this.createPagin(this.sortByKey(this.contactsList, value))
    },
    sortByKey (array, key) {
      return array.sort(function (a, b) {
        var x = a[key]; var y = b[key]
        return ((x < y) ? -1 : ((x > y) ? 1 : 0))
      })
    }
  }
}
</script>
<style scoped>
  .contact-head {
    background-color: #3dae2b;
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
