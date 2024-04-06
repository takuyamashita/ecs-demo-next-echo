async function getData() {
  const response = await fetch(`${process.env.API_ENDPOINT}`, { cache: 'no-store' })
  return response.json()
}

export default async function Post() {
  const data = await getData()

  return (
    <main className="flex min-h-screen flex-col items-center justify-center p-24">
      <h1 className="text-4xl font-bold">Post</h1>
      {data.message}
    </main>
  )
}
