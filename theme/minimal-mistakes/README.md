
# [Installation Guide for First Setting]
  
This web-page is based on jekyll.  
  
[1]: Installs ruby  
* https://rubyinstaller.org/downloads/  
* have to choose one that includes devkit  
* e.g. rubyinstaller-devkit-2.5.3-1-x64.exe  
   
[2]: Runs ruby cmd  
* start command prompt with ruby  
  
[3]: Installs pkg using gem cmds  
* gem install jekyll  
* gem install minima  
* gem install bundler  
* gem install jekyll-feed  
* gem install tzinfo-data  
  
[4]: Downloads theme
* e.g. [https://mmistakes.github.io/minimal-mistakes/](https://mmistakes.github.io/minimal-mistakes/)  
* unzip  
* move them to workplace  
* e.g. git workplace  
  
[5]: Edits Gemfile
* source "https://rubygems.org"  
* gem  "minimal-mistakes-jekyll"  
* \# gemspec  
  
[6]: Runs bundle  
* bundle  
* bundle update, to update bundle  
  
[7]: Edits _config.yml  
* source \_config.yml  
un-comment theme  
theme                    : "minimal-mistakes-jekyll"  
  
* you can modify others e.g. locale, title, name, etc. for your costomizing  
  
[8]: Removes un-necessary files or folders  
\|-- .editorconfig  
|-- .gitattributes  
|-- .github  
|-- docs  
|-- test  
|-- CHANGELOG.md  
|-- minimal-mistakes-jekyll.gemspec  
|-- README.md  
|-- screenshot-layouts.png  
|-- screenshot.png  
  
(optional)  
|-- \_includes  
|-- \_layouts  
|-- \_sass  
|-- assets  
|-- |-- css  
|-- |-- fonts  
|-- |-- js  
  
#### [continue.]  
  
* user have to sync _config.yml with Gemfile  
* _config.yml for github  
* Gemfile for ruby, bundle  
  
[9]: Edits Gemfile  
* source Gemfile  
source "https://rubygems.org"  
gem "jekyll", "~> 3.5" # (optional)  
gem  "minimal-mistakes-jekyll"  
\# gemspec  
  
[10]: Publics to github  
* git commit -m hello  
* git push   
  





