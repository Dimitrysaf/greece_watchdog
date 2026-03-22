"use client"

import Link from 'next/link'
import { Button } from '@/components/ui/button'
import { IconExclamationCircle } from '@tabler/icons-react'

export default function Error() {
  return (
    <div className="flex flex-col items-center justify-center min-h-[60vh] gap-6">
      <IconExclamationCircle size={128} stroke={1} className="text-muted-foreground" />
      <h1 className="text-3xl font-bold">Κάτι πήγε στραβά</h1>
      <p className="text-xl text-muted-foreground">Παρουσιάστηκε ένα σφάλμα. Δοκιμάστε ξανά.</p>
      <Button size="lg" asChild>
        <Link href="/">Αρχική</Link>
      </Button>
    </div>
  )
}