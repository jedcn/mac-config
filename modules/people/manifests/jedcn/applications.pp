class people::jedcn::applications {
  include chrome
  include chrome::canary

  ########################################
  # Slate
  ########################################
  #
  # I needed to manually launch Slate and allow it access to control
  # my "accessibility devices." I just followed prompts on my first
  # launch.
  include slate
}
