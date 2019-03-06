require "erb"

def render_template(template, output, scope)
    tmpl = File.read(template)
    erb = ERB.new(tmpl, 0, "<>")
    File.open(output, "w") do |f|
        f.puts erb.result(scope)
    end
end

desc "Update Dockerfile templates"
task :default do

  org_name = 'bcit'
  image_name = 'centos'
  tags = [
    '6',
    '7',
  ]
  tini_version = '0.17.0'
  de_version   = '1.2'

  tags.each do |tag|
      sh "mkdir -p #{tag}"
      render_template("Dockerfile.erb", "#{tag}/Dockerfile", binding)
      #sh "cat Dockerfile.template > #{tag}/Dockerfile"
      #sh "perl -pi -e 's/%%VERSION%%/#{tag}/' #{tag}/Dockerfile"
      #sh "perl -pi -e 's/%%TINI_VERSION%%/#{tini_version}/' #{tag}/Dockerfile"
      #sh "perl -pi -e 's/%%DE_VERSION%%/#{de_version}/' #{tag}/Dockerfile"
      Dir.chdir(tag) do
        sh "docker build -t #{org_name}/#{image_name}:#{tag} ."
        #sh "docker push #{org_name}/#{image_name}:#{tag}"
      end
  end
end
