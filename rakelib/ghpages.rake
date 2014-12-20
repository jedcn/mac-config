require 'rake/clean'

desc 'Create Github Pages content'
task 'build-gh-pages' => [ 'gh-pages',
                           'gh-pages-supporting-content',
                           'gh-pages/index.html' ]

#
# Setup ./gh-pages as a git clone with gh-pages checked out.
#
directory 'gh-pages' do
  repo = 'https://github.com/jedcn/my-boxen.git'
  branch = 'gh-pages'
  dir = branch
  args = "#{repo} --branch #{branch} --single-branch ./#{dir}"
  command = "git clone #{args}"
  stdout, stderr, _status = run(command)
  puts stderr, stdout
end

#
# Extract supporting content from HTML5BoilerPlate
#
task 'gh-pages-supporting-content' => [ 'gh-pages/favicon.ico',
                                        'gh-pages/css/bootstrap.min.css',
                                        'gh-pages/css/bootstrap-theme.min.css',
                                        'gh-pages/js/vendor/modernizr-2.6.2-respond-1.1.0.min.js' ]

def add_option(url, s)
  "#{url}&#{s}"
end

CLEAN.include('gh-pages/initializr.zip')
CLEAN.include('gh-pages/initializr')
file 'gh-pages/initializr' do
  chdir('gh-pages') do
    `wget -O initializr.zip 'http://www.initializr.com/builder?boot-hero&jquerymin&h5bp-iecond&h5bp-chromeframe&h5bp-analytics&h5bp-favicon&h5bp-appletouchicons&modernizrrespond&izr-emptyscript&boot-css&boot-scripts'`
    `unzip initializr.zip`
  end
end

#
# Setup files from HTML5BoilerPlate
#
def cp_from_initializr(file, dir)
  dest =
    if dir
      "gh-pages/#{dir}"
    else
      'gh-pages'
    end
  FileUtils.cp("gh-pages/initializr/#{file}", dest, verbose: true)
end

file 'gh-pages/favicon.ico' => 'gh-pages/initializr' do
  cp_from_initializr('favicon.ico')
end

directory 'gh-pages/css' => 'gh-pages'
directory 'gh-pages/js' => 'gh-pages'
directory 'gh-pages/js/vendor' => 'gh-pages/js'

file 'gh-pages/favicon.ico' => 'gh-pages/initializr' do
  cp_from_initializr('favicon.ico')
end

file 'gh-pages/css/bootstrap.min.css' => 'gh-pages/css' do
  cp_from_initializr('css/bootstrap.min.css', 'css')
end

file 'gh-pages/css/bootstrap-theme.min.css' => 'gh-pages/css' do
  cp_from_initializr('css/bootstrap-theme.min.css', 'css')
end

file 'gh-pages/js/vendor/modernizr-2.6.2-respond-1.1.0.min.js' =>
     'gh-pages/js/vendor' do
  cp_from_initializr('js/vendor/modernizr-2.6.2-respond-1.1.0.min.js',
                     'js/vendor')
end

directory 'gh-pages/css' => 'gh-pages'

file 'README.html' => :emacs_installed do
  export_html_using_emacs('README.org')
end

file 'gh-pages/index.html' => [ 'gh-pages', 'README.html' ] do

  require 'erb'
  require 'ostruct'

  class ContentWrapper < OpenStruct
    def render(template)
      ERB.new(template).result(binding)
    end
  end

  template = File.read('rakelib/index.html.erb')

  content = File.read('README.html')

  cw = ContentWrapper.new({ content: content })
  File.open('gh-pages/index.html', 'w') do |file|
    file.write(cw.render(template))
  end

  rendered = File.read('gh-pages/index.html')
  s = "<pre>\n<code class='language-ruby'>"
  rendered = rendered.gsub('<pre class="src src-puppet">', s)
  rendered = rendered.gsub('</pre>', '</code></pre>')
  File.open('gh-pages/index.html', 'w') do |file|
    file.write(rendered)
  end
  rm 'README.html', verbose: true
end

def export_html_using_emacs(file)
  args = '--no-init-file --no-site-file --batch'
  tangle_elisp =
    %Q|(progn (require 'org) (find-file (expand-file-name \\"#{file}\\" \\"`pwd`\\")) (org-html-export-to-html nil nil nil t))|
  command = %Q|emacs #{args} --eval "#{tangle_elisp}"|
  stdout, stderr, _status = run(command)
  puts stderr
  puts stdout
end
