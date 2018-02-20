export default {
  setAuthToken (data) {
    localStorage.setItem('token', JSON.stringify(data))
  },
  getUserId () {
    var data = JSON.parse(localStorage.getItem('user_details'))
    return data.u_id
  },
  setUserDetails (data) {
    localStorage.setItem('user_details', JSON.stringify(data))
  },
  getAuthStatus () {
    if (localStorage.getItem('token')) {
      return true
    } else {
      return false
    }
  },
  logout () {
    localStorage.removeItem('token')
    localStorage.removeItem('user_details')
    return true
  }
}
