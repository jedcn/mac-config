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
}
