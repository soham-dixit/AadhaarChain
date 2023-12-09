import { useState } from 'react'
import reactLogo from './assets/react.svg'
import Signature from './components/Signature'
import './App.css'

function App() {
  const [count, setCount] = useState(0)

  return (
    <>
      <Signature />
    </>
  )
}

export default App
