"use client"

import { ReactNode } from "react"
import { motion } from "framer-motion"
import BannerTitle from "@/components/BannerTitle"

interface BannerProps {
  background?: ReactNode
}

const shapes = [
  { size: 300, x: "10%", y: "20%", duration: 8, delay: 0 },
  { size: 200, x: "70%", y: "10%", duration: 10, delay: 1 },
  { size: 150, x: "80%", y: "60%", duration: 7, delay: 2 },
  { size: 250, x: "20%", y: "70%", duration: 12, delay: 0.5 },
  { size: 100, x: "50%", y: "40%", duration: 9, delay: 1.5 },
]

export default function Banner({ background }: BannerProps) {
  return (
    <div className="relative h-[60vh] flex items-center justify-center overflow-hidden">

      {/* Background slot ή animated shapes */}
      {background ? (
        <div className="absolute inset-0 z-0">
          <div className="w-full h-full blur-sm scale-105">
            {background}
          </div>
        </div>
      ) : (
        <div className="absolute inset-0 z-0">
          {shapes.map((shape, i) => (
            <motion.div
              key={i}
              className="absolute rounded-full bg-cyan-500/30"
              style={{
                width: shape.size,
                height: shape.size,
                left: shape.x,
                top: shape.y,
                filter: "blur(40px)",
              }}
              animate={{
                x: [0, 30, -20, 10, 0],
                y: [0, -20, 30, -10, 0],
                scale: [1, 1.1, 0.9, 1.05, 1],
              }}
              transition={{
                duration: shape.duration,
                delay: shape.delay,
                repeat: Infinity,
                ease: "easeInOut",
              }}
            />
          ))}
        </div>
      )}

      {/* Overlay */}
      <div className="absolute inset-0 z-10 bg-black/40" />

      {/* Content */}
      <div className="relative z-20 text-center text-white px-4">
        <BannerTitle />
        <p className="mt-4 text-lg md:text-xl text-white/70">
          Ανεξάρτητη καταγραφή θεσμικών αποκλίσεων στην Ελλάδα.
        </p>
      </div>

    </div>
  )
}