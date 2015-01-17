
class people::jedcn::git {
  git::config::global { 'core.editor':
    value  => '/opt/boxen/homebrew/bin/emacsclient'
  }
}
