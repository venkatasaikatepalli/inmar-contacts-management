<template>
  <div>
    <div class="full-block-table">
      <div class="row contact-head">
        <div class="col-md-4">
          <b>Name</b>
        </div>
        <div class="col-md-3">
          <b>Mobile Number</b>
        </div>
        <div class="col-md-4">
          <b>Email Address</b>
        </div>
        <div class="col-md-1">
        </div>
      </div>
      <div class="contacts-list">
        <div class="row contact-item" v-if="pageinList" v-for="item in pageinList" :key="item.name">
          <div class="col-md-4 c-name" @click.prevent="openFullView(item)">
            {{item.name}}
          </div>
          <div class="col-md-3 c-number" @click.prevent="openFullView(item)">
            {{item.mobile}}
          </div>
          <div class="col-md-3 c-number" @click.prevent="openFullView(item)">
            {{item.email}}
          </div>
          <div class="col-md-1 text-right">
            <ul class="list-inline float-right">
              <li><a @click.prevent="openDialog('edit', item)"><span class="fa fa-pencil"></span></a></li>
              <li><a @click.prevent="openDialog('delete', item)"><span class="fa fa-trash"></span></a></li>
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
          Per Page: <select  v-model="paginData.perPage" v-on:change="createPagin(contactsList)">
            <option value="5">5</option>
            <option value="10">10</option>
            <option value="20">20</option>
            <option value="50">50</option>
            <option value="100">100</option>
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
      <br><br><br><br>
      <br><br><br><br>
    <!-- contact dialog -->
    <el-dialog
      title=""
      :visible.sync="dialogVisible"
      width="30%">
      <manage-contact :form-title="formTitle" :contact-data="contactData" :role="role" @contactInfoChanged="contactInfoChanged" :contacts-groups-list="contactsGroupsList"></manage-contact>
    </el-dialog>
    <el-dialog
      title=""
      :visible.sync="fullViewVisible"
      width="30%">
      <div class="text-right">
        <ul class="list-inline">
          <li><a @click.prevent="openDialog('edit', contactData)"><span class="fa fa-pencil"></span></a></li>
          <li><a @click.prevent="openDialog('delete', contactData)"><span class="fa fa-trash"></span></a></li>
        </ul>
      </div>
      <div class="contact-pop-info">
        <p><span class="nm">Name:</span> <br><b>{{ contactData.name }}</b></p>
        <p><span class="nm">Mobile Number:</span><br><b>{{ contactData.mobile }}</b></p>
        <p><span class="nm">Email Address:</span> <br><b>{{ contactData.email }}</b></p>
        <p v-for="item in contactsGroupsList" :key="item.id" v-if="contactData.group_id === item.id"><span class="nm">Group: </span><br><b>{{ item.name }}</b></p>
      </div>
      <span slot="footer" class="dialog-footer">
        <el-button size="mini" type="danger" @click="fullViewVisible = false">Close</el-button>
      </span>

    </el-dialog>
  </div>
</template>
<script>
import {constants} from '@/constants.js'
import axios from 'axios'
import ManageContact from '@/components/contacts/ManageContact'
export default {
  components: {
    ManageContact
  },
  props: ['contactsList', 'contactsGroupsList'],
  data () {
    return {
      response: '',
      dialogVisible: false,
      fullViewVisible: false,
      contactData: {},
      formTitle: '',
      role: '',
      userId: '102',
      paginData: {
        perPage: 5,
        total: 0,
        pages: 0,
        pageNum: 1
      },
      perPage: 5,
      total: '',
      pages: 10,
      pageNum: 1,
      pageinList: []
    }
  },
  created () {
    this.createPagin(this.contactsList)
  },
  watch: {
    contactsList: function () {
      this.createPagin(this.contactsList)
    }
  },
  methods: {
    openDialog (event, data) {
      this.fullViewVisible = false
      this.contactData = {}
      if (event === 'edit') {
        // make a popup
        this.dialogVisible = true
        this.role = 'edit'
        // change the formTitle
        this.formTitle = 'Edit Contact'
        // generate form Data
        this.contactData.id = data.id
        this.contactData.name = data.name
        this.contactData.mobile = data.mobile
        this.contactData.email = data.email
        this.contactData.group_id = data.group_id
        this.contactData.u_id = this.userId
      }
      if (event === 'add') {
        // make a popup
        this.dialogVisible = true
        this.role = 'add'
        // change the formTitle
        this.formTitle = 'Add Contact'
        this.contactData.u_id = this.userId
      }
      if (event === 'delete') {
        this.contactData.id = data.id
        this.$confirm('This will permanently delete the Contact. Continue?', 'Warning', {
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
      axios.post(constants.delete_contact, this.contactData)
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
      this.fullViewVisible = true
      this.contactData = data
    },
    contactInfoChanged () {
      this.dialogVisible = false
      this.$emit('contactInfoChanged')
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
    max-height: 60vh;
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
  .nm{
    color: rgba(0,0,0,0.4);
    font-size: 0.9em;
  }
  .pagin {
    background-color: white;
    margin:0em;
    padding: 1em;
    border:1px solid rgba(0,0,0,0.10);
  }
  .full-block-table{
    box-shadow: 1px 1px 10px 1px rgba(0,0,0,0.10);
  }
</style>
