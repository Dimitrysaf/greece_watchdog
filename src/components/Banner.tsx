import BannerTitle from "@/components/BannerTitle"
import { ReactNode } from "react"

interface BannerProps {
  background?: ReactNode
}

export default function Banner({ background }: BannerProps) {
  return (
    <div className="relative h-[50vh] flex items-center overflow-hidden">

      {/* Background slot ή grid */}
      {background ? (
        <div className="absolute inset-0 z-0">
          <div className="w-full h-full blur-sm scale-105">
            {background}
          </div>
        </div>
      ) : (
        <div
          className="absolute inset-0 z-0"
          style={{
            backgroundImage: `linear-gradient(rgba(255,255,255,0.1) 1px, transparent 1px),
                  linear-gradient(90deg, rgba(255,255,255,0.1) 1px, transparent 1px)`,
            backgroundSize: "40px 40px",
          }}
        />
      )}

      {/* Overlay */}
      <div className="absolute inset-0 z-10 bg-black/20" />

      {/* Content */}
      <div className="relative z-20 container mx-auto px-8 md:px-16 text-white">
        <BannerTitle />
        <p className="mt-4 text-lg text-white/70">
          Ανεξάρτητη καταγραφή θεσμικών αποκλίσεων στην Ελλάδα.
        </p>
      </div>

    </div>
  )
}