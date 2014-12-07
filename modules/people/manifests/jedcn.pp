class people::jedcn {
  include chrome
  include chrome::canary

  package { 'tree':
    ensure => installed,
  }

  package { 'emacs':
    ensure => present,
    install_options => [
      '--cocoa',
      '--srgb'
    ],
  }

  file { [ '/p', '/p/init', '/p/src', '/p/dist' ]:
    ensure => directory,
    mode   => 0644,
  }
}
