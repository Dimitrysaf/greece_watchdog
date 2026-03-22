/**
 * useIncidents — composable που διαχειρίζεται τα incidents.
 *
 * Αυτή τη στιγμή χρησιμοποιεί mock data.
 * Για να συνδεθεί με Supabase, κάνε uncomment τα σχολιασμένα τμήματα
 * και βάλε τα credentials στο .env
 */

import type { Incident } from '~/types'
import { INCIDENTS } from '~/utils/mockData'

export function useIncidents() {
  const incidents = ref<Incident[]>([])
  const loading = ref(false)
  const error = ref<string | null>(null)

  // ── Mock (χρησιμοποιείται τώρα) ──────────────────────────────────────────
  const fetchMock = () => {
    loading.value = true
    setTimeout(() => {
      incidents.value = INCIDENTS
      loading.value = false
    }, 120) // simulate network
  }

  // ── Supabase (uncomment όταν έτοιμο) ─────────────────────────────────────
  // const supabase = useSupabaseClient()
  //
  // const fetchFromDB = async () => {
  //   loading.value = true
  //   error.value = null
  //   const { data, error: err } = await supabase
  //     .from('incidents')
  //     .select('*')
  //     .order('score', { ascending: false })
  //   if (err) { error.value = err.message }
  //   else { incidents.value = data as Incident[] }
  //   loading.value = false
  // }

  const fetch = () => fetchMock()
  // const fetch = () => fetchFromDB()  // ← αλλαγή για Supabase

  const bySection = (section: string) =>
    incidents.value.filter(i => i.section === section)

  const byId = (id: string) =>
    incidents.value.find(i => i.id === id) ?? null

  const critical = computed(() =>
    incidents.value.filter(i => i.score >= 9)
  )

  const active = computed(() =>
    incidents.value.filter(i => i.status === 'Ενεργό')
  )

  return { incidents, loading, error, fetch, bySection, byId, critical, active }
}
