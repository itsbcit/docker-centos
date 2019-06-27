require "erb"

# @ripienaar https://www.devco.net/archives/2010/11/18/a_few_rake_tips.php
# Brilliant.
def render_template(template, output, scope)
    tmpl = File.read(template)
    erb = ERB.new(tmpl, 0, "<>")
    File.open(output, "w") do |f|
        f.puts erb.result(scope)
    end
end

maintainer = 'jesse@weisner.ca, chriswood.ca@gmail.com'
org_name = 'bcit'
image_name = 'centos'
tini_version = '0.17.0'
de_version   = '1.3'
tags = [
  '6',
  '7',
  '7-supervisord',
]

desc "Template, build, tag, push"
task :default do
  Rake::Task[:Dockerfile].invoke
  # Rake::Task[:build].invoke
  # Rake::Task[:test].invoke
  # Rake::Task[:tag].invoke
  # Rake::Task[:push].invoke
end

desc "Update Dockerfile templates"
task :Dockerfile do
  render_template("Dockerfile.erb", "Dockerfile", binding)
end

desc "Build docker images"
task :build do
  sh "docker build -t #{org_name}/#{image_name}:#{tag} . --no-cache --pull"
end

desc "Test docker images"
task :test do
  puts "Running tests on #{org_name}/#{image_name}:#{tag}"
  puts "lol"
end

desc "Tag docker images"
task :tag do
  sh "docker tag #{org_name}/#{image_name}:#{tag} #{org_name}/#{image_name}:latest"
end

desc "Push to Docker Hub"
task :push do
  sh "docker push #{org_name}/#{image_name}:#{tag}"
  sh "docker push #{org_name}/#{image_name}:latest"
end
