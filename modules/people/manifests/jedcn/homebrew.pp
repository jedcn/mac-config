class people::jedcn::homebrew {
  $homebrew_packages = [
                        'ag',
                        'tmux',
                        'tree',
                        'wget',
                        'zsh',
                        ]

  package { $homebrew_packages: }

  package { 'cask':
    ensure  => present,
    require => Package['emacs'],
  }

  package { 'emacs':
    ensure          => present,
    install_options => [
      '--cocoa',
      '--srgb'
    ],
  }
}
