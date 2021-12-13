require 'active_support/all'
# システム日付から見た昨日/明日を求める

Date.current # => Tue, 05 Nov 2013
Date.yesterday  # => Tue, 04 Nov 2013
Date.tomorrow # =>  # => Tue, 06 Nov 2013
Date.current # => 2013-11-05
2.years.ago   # => 2011-11-05 06:21:40 +0900
2.years.since # => 2015-11-05 06:21:40 +0900
2.months.ago   # => 2013-09-05 06:21:40 +0900
2.months.since # => 2014-01-05 06:21:40 +0900

# 特定の日付/日時から見た昨日/明日、先週/来週、xx日前/後、etcを求める
date = Date.current # => 2013-11-05

date.yesterday # => 2013-11-04
date.tomorrow  # => 2013-11-06

date.prev_day # => 2013-11-04
date.next_day # => 2013-11-06

date.prev_day(2) # => 2013-11-03
date.next_day(2) # => 2013-11-07

date - 2.days # => 2013-11-03
date + 2.days # => 2013-11-07

date.ago(2.days)   # => 2013-11-03
date.since(2.days) # => 2013-11-07

date.prev_month # => 2013-10-05
date.next_month # => 2013-12-05

date.prev_month(2) # => 2013-09-05
date.next_month(2) # => 2014-01-05

date - 2.months # => 2013-09-05
date + 2.months # => 2014-01-05

date.months_ago(2)   # => 2013-09-05
date.months_since(2) # => 2014-01-05

date.ago(2.months)   # => 2013-09-05
date.since(2.months) # => 2014-01-05

# ある日付/日時から見た始まりと終わりの日付/日時を求める

date = Date.current # => 2013-11-05

date.beginning_of_month # => 2013-11-01
date.end_of_month       # => 2013-11-30

date.beginning_of_day # => 2013-11-05 00:00:00 +0900
date.end_of_day       # => 2013-11-05 23:59:59 +0900

datetime = Time.current # => 2013-11-05T06:43:53+09:00

datetime.beginning_of_hour # => 2013-11-05T06:00:00+09:00
datetime.end_of_hour       # => 2013-11-05T06:59:59+09:00

# 1日の初めから終わりまで、月の初めから終わりまで、といった範囲を求める

time = Time.current
# => Mon, 23 Nov 2015 16:45:23 JST +09:00

# その日の始まりと終わりの日時を取得
time.all_day
# => Mon, 23 Nov 2015 00:00:00 JST +09:00..Mon, 23 Nov 2015 23:59:59 JST +09:00

# その日から見た月の始まりと、月の終わりの日時を取得する
time.all_month
# => Sun, 01 Nov 2015 00:00:00 JST +09:00..Mon, 30 Nov 2015 23:59:59 JST +09:00

# その日から見た年の始まりと、年の終わりの日時を取得する
time.all_year

# ある日付から見た先週/来週のxx曜日を求める

date = Date.current # => 2013-11-05
date.tuesday?     # => true

date.prev_week(:monday) # => 2013-10-28
date.next_week(:monday) # => 2013-11-11
