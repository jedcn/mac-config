
def org_files
  require 'find'
  org_files = []
  Find.find('.') do |path|
    org_files << path if path.end_with? 'org'
  end
  org_files
end

def run(c)
  require 'open3'
  _stdin, stdout, stderr = Open3.popen3(c)
  [ stdout.gets, stderr.gets ]
end

def tangle_file_using_emacs(file)
  args = '--no-init-file --no-site-file --batch'
  tangle_elisp =
    %Q|(progn (require 'ob-tangle) (org-babel-tangle-file \\"#{file}\\"))|
  command = %Q|emacs #{args} --eval "#{tangle_elisp}"|
  _stdout, stderr = run(command)
  puts stderr unless $?.to_i == 0
end

task :emacs_installed do
  location = `which emacs`
  raise 'Unable to find emacs' if location.empty?
end

desc 'tangle literate source into puppet'
task :tangle => :emacs_installed do
  org_files.each do |file|
    tangle_file_using_emacs(file)
  end
end

task default: :tangle
