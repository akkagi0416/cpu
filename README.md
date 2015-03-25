# プログラム練習

データを蓄積して視覚化してチェック

## 使う技術

* Ruby
* sinatra
* slim
* sqlite3
* jquery
* jqPlot
* crontab
* ajax

## ファイル構成

* cpu.rb
* myapp.rb
* cpu.db
* public
 * jquery.min.js
 * jquery.jqplot.min.js
 * jquery.jqplot.min.css
 * plugins/jqplot.dateAxisRenderer.min.js

## しくみ

1. cpu.rbでRaspberry PiのCPU温度を取得&データベースへ記録
2. crontabで定期的にcpu.rbを呼び出してデータ蓄積
3. myapp.rbを起動してブラウザ上からアクセス
4. myapp.rbはajaxでデータベースのデータ取得
5. myapp.rbは取得したデータをjqplotでグラフ表示
