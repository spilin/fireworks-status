require 'sinatra'
require 'sqlite3'
require 'oj'

db = SQLite3::Database.new "#{Dir.pwd}/sqlite3.db"
db.execute "create table if not exists deploys ( id INTEGER PRIMARY KEY, details text );"

get '/' do
  items = db.execute('SELECT * FROM deploys ORDER BY id').map { |data| Oj.load(data[1]).merge({'id' => data[0]}) }
  puts items.inspect
  erb :index, locals: { items: items }
end

post '/' do
  if params[:token] == ENV['FIREWORKS_TOKEN']
    if entry = find_entry(db)
      update_entry(db, entry)
    else
      add_new_entry(db)
    end
  else
    status 403
  end
end


def find_entry(db)
  entry = db.execute('SELECT * FROM deploys').detect { |data| Oj.load(data[1])['name'] == params[:name] }
  entry && entry[0]
end

def add_new_entry(db)
  db.execute("INSERT INTO deploys (details) VALUES ('#{Oj.dump(details_for_entry)}');")
end

def update_entry(db, entry)
  db.execute("UPDATE deploys SET details = '#{Oj.dump(details_for_entry)}' WHERE id = #{entry[0]};")
end

def details_for_entry
  data = %i{name branch}.each_with_object({}) {|key, memo| memo[key.to_s] = params[key] }
  data['updated_at'] = Time.now
  data
end
