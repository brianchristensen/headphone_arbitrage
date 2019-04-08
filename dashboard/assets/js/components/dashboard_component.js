import React from 'react'
import ReactDOM from 'react-dom'
import { BrowserRouter as Router, Route, Link } from "react-router-dom";

// TODO: Add table component to page through the full sales list
// TODO: Component that shows wanted posts (score demand for items)
import TopTenComponent from './top_ten'
import DetailComponent from './detail'

function DashboardComponent(props) {
  const { recommendations } = props

  return (
    <Router>
      <div>
        <nav>
          <ul>
            <li>
              <Link to="/">Top 10 Items</Link>
            </li>
          </ul>
        </nav>

        <Route path="/" exact component={props => <TopTenComponent recommendations={recommendations}/>} />
        <Route path="/detail/:id" render={props => <DetailComponent recommendations={recommendations}/>} />
      </div>
    </Router>
  )
}

let renderDashboard = (recommendations, refresh) => {
  let app_root = document.getElementById("app_root")
  ReactDOM.render(<DashboardComponent recommendations={recommendations} refresh={refresh}/>, app_root)
}

export default renderDashboard