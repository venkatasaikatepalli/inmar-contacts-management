<template>
  <div>
    <div class="row">
      <div class="col-md-7">
        <h3 class="black"><span class="fa fa-users"></span> Contacts Management</h3>
      </div>
      <div class="col-md-5 text-right">
        <button class="btn btn-primary" @click.prevent="openDialog('add', null)">+ Add New</button>
      </div>
    </div>
    <div class="row contact-head">
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
      <div class="row contact-item" v-for="(item, index) in contactsList" :key="item.name">
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
            <li><a @click.prevent="openDialog('edit', item)"><span class="fa fa-pencil"></span></a></li>
            <li><a href=""><span class="fa fa-trash"></span></a></li>
          </ul>
        </div>
      </div>
    </div>
    <!-- contact dialog -->
    <el-dialog
      title=""
      :visible.sync="dialogVisible"
      width="30%">
      <manage-contact :form-title="formTitle" :contact-data="contactData" :role="role"></manage-contact>
    </el-dialog>
  </div>
</template>
<script>
import ManageContact from '@/components/contacts/ManageContact'
export default {
  components: {
    ManageContact
  },
  props: ['contactsList', 'u_id'],
  data () {
    return {
      response: '',
      dialogVisible: false,
      contactData: {},
      formTitle: '',
      role: ''
    }
  },
  methods: {
    openDialog (event, data) {
      this.contactData = {}
      if (event === 'edit') {
        // make a popup
        this.dialogVisible = true
        this.role = 'edit'
        // change the formTitle
        this.formTitle = 'Edit Contact'
        // generate form Data
        this.contactData = data
      }
      if (event === 'add') {
        // make a popup
        this.dialogVisible = true
        this.role = 'add'
        // change the formTitle
        this.formTitle = 'Add Contact'
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
  }
  .contact-item:hover {
    background-color: #4A2AD5;
    color: white;
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
</style>
