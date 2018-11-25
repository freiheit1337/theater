require 'app_config'
require 'hashie'
require 'json'
require 'semantic_logger'

# Main singleton settings class
class Application
  class << self
    def config
      AppConfig.get
    end

    def logger
      return @logger if @logger
      STDOUT.sync = true
      SemanticLogger.add_appender(
        io:          STDOUT,
        level:       (ENV['LOG_LEVEL'] || 'info').to_sym,
        formatter:   SemanticLogger::Formatters::Json.new(
          time_format: '%Y-%m-%dT%H:%M:%S.%3N%:z',
          time_key: :time,
          log_application: false,
          log_host: false
        )
      )

      @logger = SemanticLogger['Theater']
    end
  end
end

App = Application
