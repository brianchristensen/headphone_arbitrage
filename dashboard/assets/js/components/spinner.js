import React from 'react'
import ReactDOM from 'react-dom'

function renderSpinner() {
  let app_root = document.getElementById("app_root")
  ReactDOM.render(<div className="lds-ring"><div></div><div></div><div></div><div></div></div>, app_root)
}

export default renderSpinner