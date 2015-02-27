require 'pg'
require 'yaml'

class SqlTaskChecker
  class << self
    attr_reader :config

    def check(checker_sql:, user_sql:)
      @config = YAML.load_file('database.yml')
      connection = establish_connection

      begin
        checker_result = connection.exec(checker_sql).values
        user_result = connection.exec(user_sql).values
      rescue PG::Error => pg_error
        error_msg = pg_error.error
      end

      result = checker_result == user_result

      { result: result, error: error_msg }
    end

    private

    def establish_connection
      PG::Connection.new(
        dbname: config['database'],
        user: config['username'],
        password: config['password'],
        host:     config['host']
      )
    end
  end
end

# example:
# puts SqlTaskChecker.check(checker_sql: 'SELECT * FROM articles;', user_sql: 'SELECT * FROM articles;')
