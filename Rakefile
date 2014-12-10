
def run(c)
  require 'open3'
  _stdin, stdout, stderr = Open3.popen3(c)
  [ stdout.gets, stderr.gets, $?.to_i ]
end

def tangle_file_using_emacs(file)
  args = '--no-init-file --no-site-file --batch'
  tangle_elisp =
    %Q|(progn (require 'ob-tangle) (org-babel-tangle-file \\"#{file}\\"))|
  command = %Q|emacs #{args} --eval "#{tangle_elisp}"|
  _stdout, stderr, status = run(command)
  puts stderr unless status == 0
end

task :emacs_installed do
  location = `which emacs`
  raise 'Unable to find emacs' if location.empty?
end

desc 'tangle literate source into puppet'
task :tangle => :emacs_installed do
  tangle_file_using_emacs('README.org')
end

task default: :tangle
