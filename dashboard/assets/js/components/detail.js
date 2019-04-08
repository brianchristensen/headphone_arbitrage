import React from 'react'
import { withRouter } from "react-router-dom"
import {
  LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend,
} from 'recharts';

function DetailComponent(props) {
  const { match, recommendations } = props
  const detail = recommendations.find(item => item.self.id === match.params.id)

  const line_data = detail.similar.sort((a, b) => new Date(a.date) - new Date(b.date)).map(item => {
    return {date: item.date, price: item.price, data: item}
  })

  return (
    <div>
      <h2>{`${detail.item_title} price history`}</h2>
      <LineChart width={900} height={500} data={line_data}>
        <CartesianGrid strokeDasharray="3 3" />
        <XAxis dataKey="date" />
        <YAxis />
        <Tooltip />
        <Legend />
        <Line type="monotone" dataKey="price" stroke="#8884d8" activeDot={{ r: 8 }} />
      </LineChart>
      <br />
      <h2>Details</h2>
      <p>Name               : {detail.item_title}</p>
      <p>Price              : ${detail.item_price}</p>
      <p>Mean               : ${detail.mean_price}</p>
      <p>Median             : ${detail.median_price}</p>
      <p>Mode               : ${detail.mode_price}</p>
      <p>Deviation from Mean : ${detail.deviation}</p>
      <p>Max Deal Price     : {detail.max_spend}</p>
    </div>
  )
}

export default withRouter(DetailComponent)