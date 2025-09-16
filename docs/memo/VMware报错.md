---
title: VMware报错：虚拟机使用的是此版本 VMware Workstation不支持的硬件版本
createTime: 2025/09/15 10:07:47
permalink: /article/cis9ftyl/
tags: 
  - VMware
  - 报错
---
## 报错提示

在VMware打开虚拟机的时候，经常会遇到如下的提示：

![](../.vuepress/public/images/image-20250915100936819.png)

## 解决方法

打开此虚拟机所在的文件夹，找到`.vmx`后缀的配置文件，以文本形式打开，并找到选项`virtuaIHW.version`对应的那一行，将后面的数字改为你安装的VMware对应的版本。

例如我这里报错的原因是我安装的Vmware版本是16，但是虚拟机配置文件中`virtuaIHW.version=21`，将其改为16后，可以正常打开。

![](../.vuepress/public/images/image-20250915101520916.png)