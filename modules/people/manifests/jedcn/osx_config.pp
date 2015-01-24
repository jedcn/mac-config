
class people::jedcn::osx_config {

  # ZSH
  osx_chsh { $::luser:
    shell   => '/opt/boxen/homebrew/bin/zsh',
    require => Package['zsh'],
  }

  file_line { 'add zsh to /etc/shells':
    path    => '/etc/shells',
    line    => "${boxen::config::homebrewdir}/bin/zsh",
    require => Package['zsh'],
  }

  # Dock Settings
  include osx::dock::autohide
  include osx::dock::clear_dock

  # Screen Zoom
  include osx::universal_access::ctrl_mod_zoom
  include osx::universal_access::enable_scrollwheel_zoom

  # Key Repeat
  class { 'osx::global::key_repeat_delay':
    delay => 10
  }
  include osx::global::key_repeat_rate

  # Capslock becomes Control
  include osx::keyboard::capslock_to_control

  # Hot Corners
  osx::dock::hot_corner { 'Show the desktop':
    position => 'Bottom Right',
    action => 'Desktop'
  }
  osx::dock::hot_corner { 'Put Display to Sleep':
    position => 'Bottom Left',
    action => 'Put Display to Sleep'
  }

  # Make Developer Tools available in Safari (ie: right-click and see
  # Inspect Element)
  include osx::safari::enable_developer_mode

  # Recovery Message
  $recovery_owner = "This computer belongs to Jed Northridge."
  $recovery_contact = "If found, please contact jedcn@jedcn.com or 305-985-3326."
  osx::recovery_message { "${recovery_owner} ${recovery_contact}": }
}
