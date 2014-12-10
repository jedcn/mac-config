class people::jedcn::links {

  $my_init_src = '/opt/init-src'

  file { "/Users/${luser}/.zshrc":
    ensure  => link,
    mode    => '0644',
    target  => "${my_init_src}/dot-org-files/home/.zshrc",
    require => Repository["${my_init_src}/dot-org-files"],
  }

  file { "/Users/${luser}/.oh-my-zsh":
    ensure  => link,
    target  => "${my_init_src}/oh-my-zsh",
    require => Repository["${my_init_src}/oh-my-zsh"],
  }

  file { "/Users/${luser}/.slate":
    ensure  => link,
    mode    => '0644',
    target  => "${my_init_src}/dot-org-files/home/.slate",
    require => Repository["${my_init_src}/dot-org-files"],
  }
}
