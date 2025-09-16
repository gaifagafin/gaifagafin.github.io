---
title: GMCC
createTime: 2025/09/12 10:57:05
permalink: /article/3w8z9vtt/
---

## 120.237.25.155:7547

此IP疑似存在xml解析漏洞，于是尝试使用curl命令验证。

```bash
Invoke-WebRequest -Uri "http://120.237.25.155:7547/cwmp" -Method POST -Headers @{"Content-Type"="text/xmoap:Body><GetRPCMethods xmlns="urn:dslforum-org:cwmp-1-0"/></soap:Body></soap:Envelope>' -UseBasicParsing
```

但是返回如下，似乎并没有什么利用价值：

```bash
StatusCode        : 200
StatusDescription : OK
Content           :
RawContent        : HTTP/1.1 200 OK
                    Connection: keep-alive
                    Content-Length: 0
                    Content-Type: text/xml; charset=utf-8
                    Server: RG/Device 10.x


Forms             :
Headers           : {[Connection, keep-alive], [Content-Length, 0], [Content-Type, text/xml; charset=utf-8], [Server,
                    RG/Device 10.x]}
Images            : {}
InputFields       : {}
ParsedHtml        :
RawContentLength  : 0
```



## 信息搜集

个人感觉可能值得深入的IP或域名，很多资产都已经关闭了，感觉渗透的面很窄

```http
http://www.ydxxt.com
https://h5card.gdhjy.cn/user/login
https://business.ydxxt.com/
https://visitor.ydxxt.com/
https://vrbt.gmcc.net/vrbt/gd/home
https://card.gdhjy.cn/guide/user/login
http://www.hjyy100.cn
```

