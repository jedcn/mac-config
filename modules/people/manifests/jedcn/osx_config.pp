class people::jedcn::osx_config {

  # Change the default shell to the zsh version above.
  osx_chsh { $::luser:
    shell   => '/opt/boxen/homebrew/bin/zsh',
    require => Package['zsh'],
  }

  file_line { 'add zsh to /etc/shells':
    path    => '/etc/shells',
    line    => "${boxen::config::homebrewdir}/bin/zsh",
    require => Package['zsh'],
  }

  # Automatically hide the doc
  include osx::dock::autohide

  # ensures the dock only contains apps that are running
  include osx::dock::clear_dock

  # Enables zoom by scrolling while holding Control. Need to
  # logout/login.
  include osx::universal_access::ctrl_mod_zoom

  # Enables zoom using the scroll wheel
  include osx::universal_access::enable_scrollwheel_zoom

  # Set the default value (35)
  class { 'osx::global::key_repeat_delay':
    delay => 10
  }

  # The amount of time (in ms) before key repeat 'presses' (default
  # value (0)). Need to logout/login.
  include osx::global::key_repeat_rate

  include osx::keyboard::capslock_to_control
}
