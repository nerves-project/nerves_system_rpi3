use Mix.Config

config :nerves_system_rpi3, :nerves_env,
  type: :system,
  bakeware: [target: "rpi3", recipe: "nerves/rpi3"],
  build_platform: Nerves.System.Platforms.BR,
  build_config: [
    defconfig: "nerves_defconfig"
  ]
