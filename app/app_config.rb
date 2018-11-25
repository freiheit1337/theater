# Config
module AppConfig
  def self.get
    params = {
      db: ENV.fetch('MYSQL_PARAMS', 'mysql2://user:user@127.0.0.1/test')
    }

    Hashie::Mash.new params
  end
end
