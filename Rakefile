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
parent_tags = [
  '6',
  '7',
]
tags = [
  '6',
  '6-supervisord',
  '7',
  '7-supervisord',
]

desc "Template, build, tag, push"
task :default do
  Rake::Task[:Dockerfile].invoke
  # Rake::Task[:build].invoke
  # Rake::Task[:test].invoke
  # Rake::Task[:push].invoke
end

desc "Update Dockerfile templates"
task :Dockerfile do
  tags.each do |tag|
    parent_tags.each do |parent_tag|
      if tag.include? parent_tag
        sh "mkdir -p #{tag}"
        render_template("Dockerfile.erb", "#{tag}/Dockerfile", binding)
      end
    end
    if tag.include? "supervisor"
      sh "cp -f supervisor.conf #{tag}/supervisor.conf"
    end
  end
end

desc "Build docker images"
task :build do
  tags.each do |tag|
    Dir.chdir(tag) do
      sh "docker build -t #{org_name}/#{image_name}:#{tag} . --no-cache --pull"
    end
  end
end

desc "Test docker images"
task :test do
  tags.each do |tag|
    Dir.chdir(tag) do
      puts "Running tests on #{org_name}/#{image_name}:#{tag}"
      puts "lol"
    end
  end
end

desc "Push to Docker Hub"
task :push do
  tags.each do |tag|
    Dir.chdir(tag) do
      sh "docker push #{org_name}/#{image_name}:#{tag}"
    end
  end
end
