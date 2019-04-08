import React from 'react'
import { withRouter } from "react-router-dom"
import {BarChart, CartesianGrid, XAxis, YAxis, Tooltip, Legend, Bar} from 'recharts'

function TopTenComponent(props) {
  const { recommendations, history } = props

  const bar_data = recommendations.map(item => {
    return {name: `${item.item_title.slice(0, 4)}...`, price: item.item_price, data: item}
  })

  const CustomTooltip = ({ active, payload, label }) => {
    if (active) {
      return (
        <div style={{border: '1px solid black', borderRadius: '5px', backgroundColor: 'white', opacity: '0.9', padding: '6px', }}>
          <b><p>{payload[0].payload.data.item_title}</p></b>
          <p>{`Price: $${payload[0].payload.data.item_price}`}</p>
          <p>{`Average: $${payload[0].payload.data.mean_price}`}</p>
          <p style={{color: 'red'}}>{`Deviation: $${payload[0].payload.data.deviation}`}</p>
        </div>
      )
    } else return null
  };

  return (
    <div>
      <h2>Top 10 Items by Deviation from the Mean</h2>
      <BarChart width={900} height={500} data={bar_data}>
        <CartesianGrid strokeDasharray="3 3" />
        <XAxis dataKey="name" />
        <YAxis />
        <Tooltip content={<CustomTooltip />}/>
        <Legend />
        <Bar dataKey="price" fill="#8884d8" onClick={e => history.push(`/detail/${e.data.self.id}`)}/>
      </BarChart>
    </div>
  )
}

export default withRouter(TopTenComponent)