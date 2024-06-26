async function getData() {
  try {
    const response = await fetch(`${process.env.API_ENDPOINT}`, {
      cache: 'no-store',
    })
    return response.json()
  } catch (error) {
    return { message: 'Error fetching data' }
  }
}

export const dynamic = 'force-dynamic'

export default async function Post() {
  const data = await getData()

  const array = []
  for (let i = 0; i < 5000000; i++) {
    array.push(i)
  }

  return (
    <main className="flex min-h-screen flex-col items-center justify-center p-24">
      <h1 className="text-4xl font-bold">Post</h1>
      {process.env.API_ENDPOINT}
      {data.message}
    </main>
  )
}