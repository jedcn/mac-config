class people::jedcn {
  include chrome
  include chrome::canary

  # automatically hide the doc
  include osx::dock::autohide

  # ensures the dock only contains apps that are running
  include osx::dock::clear_dock

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
}
