
class people::jedcn::applications {
  include chrome
  include chrome::canary
  include firefox
  include slate

  include virtualbox

  class { 'vagrant':
    version => '1.7.2'
  }
}
