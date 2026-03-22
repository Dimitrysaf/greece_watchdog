import type { Metadata } from "next"
import { Inter } from "next/font/google"
import { ThemeProvider } from "@/components/ThemeProvider"
import AppMenu from "@/components/AppMenu"
import "./globals.css"

const inter = Inter({ subsets: ["latin", "greek"] })

export const metadata: Metadata = {
  title: "Παρατηρητήριο Ελλάδας",
  description: "Ανεξάρτητη καταγραφή θεσμικών αποκλίσεων στην Ελλάδα.",
}

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html suppressHydrationWarning>
      <body className={inter.className}>
        <ThemeProvider>
          <AppMenu />
          {children}
        </ThemeProvider>
      </body>
    </html>
  )
}