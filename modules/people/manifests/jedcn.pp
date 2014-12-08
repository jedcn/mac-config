class people::jedcn {
  include chrome
  include chrome::canary

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

  $my_init_dir = '/p/init'

  file { [ '/p', '/p/init', '/p/src', '/p/dist' ]:
    ensure => directory,
    mode   => 0644,
  }

  repository { "${my_init_dir}/dot-org-files":
    source  => 'jedcn/dot-org-files',
    require => File['/p/init']
  }

  repository { "${my_init_dir}/emacs-setup":
    source  => 'jedcn/emacs-setup',
    require => File['/p/init']
  }
}
