#!/usr/bin/env ruby

require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require 'slim'
require 'json'

set :bind => '192.168.11.100'
set :port => 9999

get '/' do
	slim :index
end

get '/data' do
	db = SQLite3::Database.new('cpu.db')
	data = db.execute('SELECT * FROM cpu')
#	data = db.execute('SELECT * FROM cpu limit 3')
	data.to_json
end

__END__

@@ index

doctype html
html
	head
		title cpu thermo data
		meta charset='utf-8'
	body
		#chartdiv style='height:400px;width:960px;'
		script src='jquery.min.js'
		script src='jquery.jqplot.min.js'
		script src='plugins/jqplot.dateAxisRenderer.min.js'
		link rel='stylesheet' href='jquery.jqplot.min.css' type='text/css'

javascript:
	$(function(){
		$.ajax({
			type:		'GET',
			url:		'/data',
			dataType:	'json',
			success: function(d){
				$.jqplot('chartdiv', [d], {
					axes:{
						xaxis:{
							renderer: $.jqplot.DateAxisRenderer,
						}
					},
					seriesDefaults:{
						showMarker: false,
					}
				});
			},
			error: function(d){
				alert('error');
			}
		});
	});
