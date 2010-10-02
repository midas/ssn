ActiveRecord::Base.configurations = YAML::load( IO.read( File.dirname(__FILE__) + '/../spec/database.yml' ) )
ActiveRecord::Base.establish_connection( 'test' )

ActiveRecord::Schema.define :version => 1 do
  create_table "users", :force => true do |t|
    t.string   "name",       :limit => 50
    t.string   "raw_ssn",    :limit => 9
  end

  create_table "people", :force => true do |t|
    t.string   "name",       :limit => 50
  end
end

class User < ActiveRecord::Base
  has_ssn :ssn
end
