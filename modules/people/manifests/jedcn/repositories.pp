class people::jedcn::repositories {

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

  repository { "${my_init_src}/oh-my-zsh":
    source  => 'robbyrussell/oh-my-zsh',
    require => File[$my_init_src]
  }
}
