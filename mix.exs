defmodule NervesSystemRpi3.Mixfile do
  use Mix.Project

  def project do
    [app: :nerves_system_rpi3,
    version: "0.4.0-rc3",
    elixir: "~> 1.2",
    compilers: Mix.compilers ++ [:nerves_system],
    deps: deps]
 end

 def application do
   []
 end

 defp deps do
   [
     {:nerves_system, path: "../nerves_system"},
     {:nerves_system_br, path: "../nerves-system-br"},
     {:nerves_toolchain_arm_unknown_linux_gnueabihf, path: "../nerves_toolchain_arm_unknown_linux_gnueabihf"}
   ]
 end
end
