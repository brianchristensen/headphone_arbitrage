import {Socket} from "phoenix"
import renderSpinner from "./components/spinner"
import renderDashboard from "./components/dashboard_component"

export default class DashboardSocket {
  constructor() {
    this.get_recommendations = this.get_recommendations.bind(this)
    this.socket = new Socket("/socket", {})
    this.socket.connect();
  }

  connect_to_dashboard() {
    this.setup_channel()

    this.channel.on("recommendations", res => {
      // render the dashboard
      renderDashboard(res.recommendations, this.get_recommendations)
    })
  }  

  setup_channel() {
    renderSpinner()
    this.channel = this.socket.channel("dashboard:insight", {})    
    this.channel
      .join()
      .receive("ok", res => {
        this.get_recommendations()
      })
      .receive("error", res => {
        alert(res)
        throw(res)
      })
  }

  get_recommendations() {
    this.channel.push("recommendations", {})
  }
}