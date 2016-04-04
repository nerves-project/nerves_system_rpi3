use Mix.Config

config :nerves_system_rpi3, :nerves_env,
  type: :system,
  build_platform: Nerves.System.Platforms.BR,
  bakeware: [target: "rpi3", recipe: "nerves/rpi3"],
  ext: [
    defconfig: "nerves_defconfig"
  ]
