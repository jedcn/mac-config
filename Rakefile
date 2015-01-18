
def run(c)
  require 'open3'
  _stdin, stdout, stderr = Open3.popen3(c)
  [ stdout.gets, stderr.gets, $?.to_i ]
end

task :emacs_installed do
  location = `which emacs`
  raise 'Unable to find emacs' if location.empty?
end

task default: :tangle
