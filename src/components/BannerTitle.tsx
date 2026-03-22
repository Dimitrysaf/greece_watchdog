"use client"

import { motion } from "framer-motion"

export default function BannerTitle() {
  const letters = "Παρατηρητήριο Ελλάδας".split("")

  return (
    <h1 className="text-5xl md:text-7xl font-bold tracking-tight cursor-default select-none">
      {letters.map((letter, i) => (
        <motion.span
          key={i}
          className="inline-block text-white"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: i * 0.02 }}
          whileHover={{
            textShadow: "0 0 20px rgba(255,255,255,0.8)",
            color: "#e2e8f0",
            transition: { duration: 0.2 }
          }}
        >
          {letter === " " ? "\u00A0" : letter}
        </motion.span>
      ))}
    </h1>
  )
}