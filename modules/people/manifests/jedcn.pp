class people::jedcn {
  include chrome
  include chrome::canary

  package { 'tree':
    ensure => installed,
  }
}
