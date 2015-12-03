
class people::jedcn::applications {
  include chrome
  include chrome::canary

  include brewcask
  package { 'hammerspoon': provider => 'brewcask' }
}
