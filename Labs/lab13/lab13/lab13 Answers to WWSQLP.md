```sqlite
sqlite> SELECT * FROM students LIMIT 30; -- This is a comment. * is shorthand for all columns!
2020/07/28 10:06:24 PM CDT|55|yellow|the number 7 below.|So What by Miles Davis|07-07|turtle|Image 3|1
2020/07/28 10:07:01 PM CDT|2|yellow|7|Truth Hurts|04-17|seacucumber|Image 1|1
2020/07/28 10:08:05 PM CDT|7|red|seven|Dancing Queen|12-20|cat|Image 5|77
2020/07/28 10:09:13 PM CDT|31|green|the number 7 below.|Dancing Queen|12-24|capybara|Image 4|1
2020/07/28 10:09:28 PM CDT|16|blue|the number 7 below.|Truth Hurts|09-30|panda|Image 4|12
2020/07/28 10:09:33 PM CDT|17|red|the number 7 below.|So What|04-13|liger|Image 2|13
2020/07/28 10:09:50 PM CDT|17|blue|7|Dancing Queen|08-17|turtle|Image 5|14
2020/07/28 10:11:58 PM CDT|9|green|7|Clair De Lune|12-25|chameleon|Image 2|23
2020/07/28 10:12:00 PM CDT|24|blue|the number 7 below.|Clair De Lune|02-15|dog|Image 3|41
2020/07/28 10:12:39 PM CDT|8|blue|7|Formation|11-01|dog|Image 4|24
2020/07/28 10:13:24 PM CDT|90|red|I find this question condescending|Seasons of Love|09-28|hawk|Image 5|1
2020/07/28 10:14:54 PM CDT|69|blue|I find this question condescending|Clair De Lune|04-20|cat|Image 2|28
2020/07/28 10:16:24 PM CDT|5|blue|7|Truth Hurts|05-21|fox|Image 2|1000000
2020/07/28 10:17:20 PM CDT|69|berkeley blue|I find this question condescending|Down With The Sickness|04-20|unicorn|Image 3|21
2020/07/28 10:17:21 PM CDT|69|blue|7|So What|04-20|cheetah|Image 5|1
2020/07/28 10:19:32 PM CDT|100|red|the number 7 below.|Never Be Like You|04-11|monkey|Image 2|4
2020/07/28 10:20:58 PM CDT|7|blue|7|Dancing Queen|07-01|turtle|Image 2|16
2020/07/28 10:21:50 PM CDT|12|blue|7|Dancing Queen|10-12|dog|Image 4|21
2020/07/28 10:30:55 PM CDT|27|orangee|7|Never Be Like You|03-27|a dolphin|Image 3|1
2020/07/28 10:31:16 PM CDT|73|green|I find this question condescending|Truth Hurts|07-20|penguin|Image 2|73
2020/07/28 10:33:52 PM CDT|5|red|I find this question condescending|Truth Hurts|10-07|old world sparrow|Image 3|7
2020/07/28 10:46:01 PM CDT|23|blue|I find this question condescending|Dancing Queen|08-31|dog|Image 5|36
2020/07/28 10:48:00 PM CDT|61|blue|the number 7 below.|Clair De Lune|06-01|python|Image 2|1
2020/07/28 10:50:49 PM CDT|88|blue|seven|Dancing Queen|05-14|monkey|Image 1|20
2020/07/28 10:52:47 PM CDT|16|blue|the number 7 below.|Dancing Queen|12-25|tiger|Image 5|11
2020/07/28 10:53:21 PM CDT|3.141592653589793|razmatazz|7|Truth Hurts|02-29|cockroach|Image 1|1e+212
2020/07/28 10:54:41 PM CDT|8|burgundy|7|Dancing Queen|05-03|whale|Image 5|1
2020/07/28 11:03:45 PM CDT|2|red|7|Never Be Like You|02-12|cat|Image 3|1
2020/07/28 11:04:13 PM CDT|17|coral|I find this question condescending|Seasons of Love|08-19|otter|Image 2|19
2020/07/28 11:07:12 PM CDT|1|red|7|Clair De Lune|01-10|dog|Image 3|12


sqlite> SELECT color FROM students WHERE number = 7;
red
blue
blue
red
green
blue
red (bright red, blood red, miss me with maroon)


sqlite> SELECT song, pet FROM students WHERE color = "blue" AND date = "12-25";
Dancing Queen|tiger
Dancing Queen|mammoth
Never Be Like You|cat
```

