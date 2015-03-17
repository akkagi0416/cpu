#!/usr/bin/env ruby

require 'sqlite3'

df = '/home/pi/a/cpu/cpu.db'

time = Time.now.strftime("%Y-%m-%d %H:%M:%S")
temp = open('/sys/class/thermal/thermal_zone0/temp'){|f| f.read }
puts time + " " + temp

db = SQLite3::Database.new(df)
sql = <<-SQL
	CREATE TABLE cpu(
		time    text,
		temp	int
	)
SQL
# テーブル無ければ作成
unless db.execute('select tbl_name from sqlite_master').flatten.include?('cpu')
	db.execute(sql)
end

time = Time.now.strftime("%Y-%m-%d %H:%M:%S")
db.execute('INSERT INTO cpu(time, temp) VALUES(?,?)', time, temp)
db.close
