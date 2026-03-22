import Link from 'next/link'
import { Button } from '@/components/ui/button'
import { IconError404 } from '@tabler/icons-react'

export default function NotFound() {
  return (
    <div className="flex flex-col items-center justify-center min-h-[60vh] gap-6">
      <IconError404 size={128} stroke={1} className="text-muted-foreground" />
      <h1 className="text-3xl font-bold">Σελίδα δεν βρέθηκε</h1>
      <p className="text-xl text-muted-foreground">Η σελίδα που ζητήσατε δεν υπάρχει.</p>
      <Button size="lg" asChild>
        <Link href="/">Αρχική</Link>
      </Button>
    </div>
  )
}