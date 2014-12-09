class people::jedcn {
  include chrome
  include chrome::canary

  # automatically hide the doc
  include osx::dock::autohide

  # ensures the dock only contains apps that are running
  include osx::dock::clear_dock

  # enables zoom by scrolling while holding Control. Need to
  # logout/login.
  include osx::universal_access::ctrl_mod_zoom

  # enables zoom using the scroll wheel
  include osx::universal_access::enable_scrollwheel_zoom

  # Set the default value (35)
  class { 'osx::global::key_repeat_delay':
    delay => 10
  }

  # the amount of time (in ms) before key repeat 'presses' (default
  # value (0)). Need to logout/login.
  include osx::global::key_repeat_rate

  include osx::keyboard::capslock_to_control

  package { 'tree':
    ensure => installed,
  }

  package { 'ag':
    ensure => present,
  }

  package { 'cask':
    ensure => present,
    require => Package['emacs'],
  }

  package { 'emacs':
    ensure => present,
    install_options => [
      '--cocoa',
      '--srgb'
    ],
  }

  $my_init_src = '/opt/init-src'

  file { $my_init_src:
    ensure => directory,
    mode   => 0644,
  }

  repository { "${my_init_src}/dot-org-files":
    source  => 'jedcn/dot-org-files',
    require => File[$my_init_src]
  }

  repository { "${my_init_src}/emacs-setup":
    source  => 'jedcn/emacs-setup',
    require => File[$my_init_src]
  }

  repository { "${my_init_src}/z":
    source  => 'rupa/z',
    require => File[$my_init_src]
  }

  ########################################
  # ZSH
  ########################################

  # Get ZSH from brew-- it's likely more recent than whatever Apple
  # ships.
  package { 'zsh':
    ensure => present,
  }

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

  file { "/Users/${luser}/.zshrc":
    ensure  => link,
    mode    => '0644',
    target  => "${my_init_src}/dot-org-files/home/.zshrc",
    require => Repository["${my_init_src}/dot-org-files"],
  }

  repository { "${my_init_src}/oh-my-zsh":
    source  => 'robbyrussell/oh-my-zsh',
    require => File[$my_init_src]
  }

  file { "/Users/${luser}/.oh-my-zsh":
    ensure  => link,
    target  => "${my_init_src}/oh-my-zsh",
    require => Repository["${my_init_src}/oh-my-zsh"],
  }


  ########################################
  # Slate
  ########################################
  #
  # I needed to manually launch Slate and allow it access to control
  # my "accessibility devices." I just followed prompts on my first
  # launch.
  include slate

  file { "/Users/${luser}/.slate":
    ensure  => link,
    mode    => '0644',
    target  => "${my_init_src}/dot-org-files/home/.slate",
    require => Repository["${my_init_src}/dot-org-files"],
  }

  ########################################
  # Git
  ########################################
  git::config::global { 'core.editor':
    value  => '/opt/boxen/homebrew/bin/emacsclient'
  }
}
