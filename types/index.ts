export type DocumentationOrder = 'Α\'' | 'Β\'' | 'Γ\''

export type Category = 'Α\'' | 'Β\'' | 'Γ\'' | 'Δ\'' | 'Ε\''

export type IncidentStatus = 'Ενεργό' | 'Εκκρεμεί' | 'Έκλεισε'

export type SectionKey = 'tempi' | 'ypoklopες' | 'opekepe' | 'typos' | 'thesmoi'

export interface Incident {
  id: string
  title: string
  date: string
  category: Category
  type: string
  description: string
  documentation_order: DocumentationOrder
  references?: string[]
  score: number
  status: IncidentStatus
  section: SectionKey
  subsection?: string
  updated_at?: string
}

export interface Section {
  key: SectionKey
  label: string
  description: string
  icon: string
}

export interface Comment {
  id: string
  incident_id: string
  user_id: string
  content: string
  created_at: string
  user?: {
    email: string
    display_name?: string
  }
}

export interface EditProposal {
  id: string
  incident_id: string
  user_id: string
  proposed_changes: Partial<Incident>
  reason: string
  status: 'pending' | 'approved' | 'rejected'
  created_at: string
}
