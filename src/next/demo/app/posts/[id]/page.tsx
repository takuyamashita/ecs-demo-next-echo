async function getData(id: string) {
  const response = await fetch(
    `${process.env.API_ENDPOINT}/api/v1/posts/${id}`,
    {
      headers: {
        'Content-Type': 'application/json',
      },
      cache: 'no-store',
    },
  )
  return await response.json()
}

export default async function Page({
  params,
}: Readonly<{ params: { id: string } }>) {
  const posts = await getData(params.id)

  return (
    <main className="flex min-h-screen flex-col items-center justify-center p-24">
      <h1 className="text-4xl font-bold">{posts.title}</h1>
      {posts.body}
    </main>
  )
}
