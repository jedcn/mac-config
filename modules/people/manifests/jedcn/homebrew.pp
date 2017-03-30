
class people::jedcn::homebrew {
  $homebrew_packages = [
                        'ag',
                        'tmux',
                        'tree',
                        'wget',
                        'zsh',
                        ]

  package { $homebrew_packages: }

}
