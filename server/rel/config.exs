use Mix.Releases.Config,
    # This sets the default release built by `mix release`
    default_release: :default,
    # This sets the default environment used by `mix release`
    default_environment: :dev

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/configuration.html


# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :"JKJRKwFTq}L_U2uP)PcXY1ZieLQ5K]38,%e4Tp4OPHS`zW4$.EVNw_Mor}QYE{Ja"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"@]1eF`7JVW@jK_kVERCp$;Q7g60?RR`x76$/R(P{x3qC(TW&jdAXrU*cmjK2_QHO"
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix release`, the first release in the file
# will be used by default

release :chatty do
  set version: current_version(:chatty)
end

