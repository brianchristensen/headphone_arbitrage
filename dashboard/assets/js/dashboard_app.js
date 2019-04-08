import DashboardSocket from "./dashboard_socket.js"

window.onload = function() {
  let dashboard = new DashboardSocket()
  dashboard.connect_to_dashboard()
}