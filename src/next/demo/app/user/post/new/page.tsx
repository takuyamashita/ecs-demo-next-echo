'use client'

import { useState } from 'react'

export default function Page() {
  const [title, setTitle] = useState('')
  const [content, setContent] = useState('')

  const handleSubmit = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault()
    const response = await fetch('/api/v1/auth/me/posts', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ title, body: content }),
    })
    if (response.ok) {
      // Redirect to the dashboard
    } else {
      // Handle the error
    }
  }

  return (
    <main className="flex min-h-screen flex-col items-center justify-center p-24">
      <h1 className="text-4xl font-bold">New Post</h1>
      <form
        onSubmit={handleSubmit}
        className="flex flex-col space-y-4"
      >
        <label className="flex flex-col">
          <span className="text-lg font-semibold">Title</span>
          <input
            className="p-2 border border-gray-300 rounded-md"
            type="text"
            value={title}
            onChange={(event) => setTitle(event.target.value)}
          />
        </label>
        <label className="flex flex-col">
          <span className="text-lg font-semibold">Content</span>
          <textarea
            className="p-2 border border-gray-300 rounded-md"
            value={content}
            onChange={(event) => setContent(event.target.value)}
          />
        </label>
        <button className="p-2 bg-blue-500 text-white font-semibold rounded-md">
          Post
        </button>
      </form>
    </main>
  )
}
