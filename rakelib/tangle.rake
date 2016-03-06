
def tangle_file_using_emacs(file)
  args = '--no-init-file --no-site-file --batch'
  tangle_elisp =
    %Q|(progn (require 'ob-tangle) (org-babel-tangle-file \\"#{file}\\"))|
  command = %Q|emacs #{args} --eval "#{tangle_elisp}"|
  _stdout, stderr, status = run(command)
  puts stderr unless status == 0
end

desc 'tangle literate source into puppet'
task :tangle => :emacs_installed do
  tangle_file_using_emacs('literate/tools.org')
  tangle_file_using_emacs('literate/boxen.org')
  tangle_file_using_emacs('literate/website.org')
end
