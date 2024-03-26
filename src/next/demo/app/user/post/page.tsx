import { cookies } from 'next/headers'
import Link from 'next/link'

async function getData() {
  const response = await fetch(
    `${process.env.API_ENDPOINT}/api/v1/auth/me/posts`,
    {
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${cookies().get('token')?.value}`,
      },
      cache: 'no-store',
    },
  )

  if (response.ok) {
    return response.json()
  } else {
    console.error(await response.text())
    throw new Error('Failed to fetch data')
  }
}

export default async function Page() {
  const posts = await getData()

  return (
    <main className="flex min-h-screen flex-col items-center justify-center p-24">
      <h1 className="text-4xl font-bold">Page</h1>
      {posts.map(({ id, title }: { id: string; title: string }) => (
        <div
          key={id}
          className="flex flex-col space-y-4"
        >
          <h2 className="text-2xl font-semibold">{title}</h2>
          <Link href={`/posts/${id}`}>view</Link>
        </div>
      ))}
    </main>
  )
}
