
class people::jedcn::applications {
  include chrome
  include chrome::canary

  include brewcask
  package { 'hammerspoon':
    provider => 'brewcask',
    require  => File["/Users/${luser}/.hammerspoon"],
  }

  package { 'aerial':
    provider => 'brewcask',
  }

  package { 'emacs-mac':
    provider => 'brewcask'
  }

  package { 'cask':
    ensure  => present,
    require => Package['emacs-mac'],
  }
}
