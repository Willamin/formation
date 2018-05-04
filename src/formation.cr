require "ecr"
require "colorize"
require "kebab"

module Formation
  VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}

  class App
    def initialize(name : String)
      @appname = name.kebabcase
      @apptitle = name.camelcase
      @destination = File.join(Dir.current, @appname)
    end

    property appname : String
    property year : String = Time.now.year.to_s
    property name : String = `git config --get user.name`.chomp
    property username : String = `git config --get user.githubusername`.chomp || "<github username>"
    property email : String = `git config --get user.email`.chomp
    property crystal : String = `crystal --version`.lines[0].split(" ")[1].chomp
    property apptitle : String
    property destination : String

    def list_templates
      {{ run("#{__DIR__}/get_all_templates.cr").lines }}
    end

    def cat_template(template_name : String)
      io = IO::Memory.new
      {% begin %}
        case
        {% for template in run("#{__DIR__}/get_all_templates.cr").lines %}
        when {{template}}
          ECR.embed {{template}}, io
        {% end %}
        end
      {% end %}
      io.to_s
    end

    def run_templates
      unless Dir.exists?(destination)
        Dir.mkdir_p(destination)
      end

      {% for template in run("#{__DIR__}/get_all_templates.cr").lines %}
        %relative_name = {{template}}.lchop("#{__DIR__}/templates/")
        %template_dir = File.dirname(%relative_name)

        # remove .ecr from the end
        %dest_filename = File.basename(%relative_name, ".ecr")

        # remove __DIR__/templates from the beginning
        %path = %template_dir.lchop("#{__DIR__}/templates/")

        # TODO
        %fullpath = File.expand_path(File.join(destination, %path, %dest_filename))

        %dir = (%fullpath.split("/") - [File.basename(%dest_filename)]).join("/")

        unless Dir.exists?(File.dirname(%fullpath))
          Dir.mkdir_p(%dir)
        end

        %file = File.new(%fullpath, mode: "w")
        ECR.embed {{template}}, %file
        %file.close
      {% end %}
    end
  end
end

if ARGV.size == 0
  puts <<-USAGE
  Usage: #{PROGRAM_NAME} APPNAME

  generates a new project under the given name


  USAGE
  exit 1
end

app = Formation::App.new(ARGV[0])
# pp app.list_templates
app.run_templates
