import { cookies } from 'next/headers'

async function getUser() {
  const response = await fetch('http://echo:1323/api/v1/auth/me', {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${cookies().get('token')?.value}`,
    },
    cache: 'no-store',
  })
  return response.json()
}

export default async function Page() {
  const user = await getUser()

  return (
    <main className="flex min-h-screen flex-col items-center justify-center p-24">
      <h1 className="text-4xl font-bold">User</h1>
      {user.email}
    </main>
  )
}
