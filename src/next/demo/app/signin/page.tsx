'use client'

import { useState } from 'react'

export default function Page() {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')

  const handleSubmit = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault()
    const response = await fetch('/api/v1/signin', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ email, password }),
    })
    if (response.ok) {
      // Redirect to the dashboard
    } else {
      // Handle the error
    }
  }

  return (
    <main className="flex min-h-screen flex-col items-center justify-center p-24">
      <h1 className="text-4xl font-bold">Sign In</h1>
      <form
        onSubmit={handleSubmit}
        className="flex flex-col space-y-4"
      >
        <label className="flex flex-col">
          <span className="text-lg font-semibold">Email</span>
          <input
            className="p-2 border border-gray-300 rounded-md"
            type="email"
            value={email}
            onChange={(event) => setEmail(event.target.value)}
          />
        </label>
        <label className="flex flex-col">
          <span className="text-lg font-semibold">Password</span>
          <input
            className="p-2 border border-gray-300 rounded-md"
            type="password"
            value={password}
            onChange={(event) => setPassword(event.target.value)}
          />
        </label>
        <button className="p-2 bg-blue-500 text-white font-semibold rounded-md">
          Sign In
        </button>
      </form>
    </main>
  )
}
