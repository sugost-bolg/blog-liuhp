---
title: "Typecho 实现博客在线访问人数统计代码"
date: 2019-09-19T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---




统计显示正在访问自己博客人数的功能，使用一些第三方统计工具（如cnzz）一般会有提供相关功能，但是如果 Typecho 博主不想使用第三方统计工具，直接通过相关代码是否可以实现？答案是可以的，只需要添加简单的php代码就可以达到统计并显示当前正在访问Typecho 博客的在线人数。

把下面的代码添加至要显示在线人数的地方即可：
    <?php
        //首先你要有读写文件的权限，首次访问会不显示，正常情况刷新即可
        $online_log = "slzxrs.dat"; //保存人数的文件到根目录,
        $timeout = 30;//30秒内没动作者,认为掉线
        $entries = file($online_log);
        $temp = array();
        for ($i=0;$i<count($entries);$i++){
            $entry = explode(",",trim($entries[$i]));
            if(($entry[0] != getenv('REMOTE_ADDR')) && ($entry[1] > time())) {
                array_push($temp,$entry[0].",".$entry[1]."\n"); //取出其他浏览者的信息,并去掉超时者,保存进$temp
            }
        }
        array_push($temp,getenv('REMOTE_ADDR').",".(time() + ($timeout))."\n"); //更新浏览者的时间
        $slzxrs = count($temp); //计算在线人数
        $entries = implode("",$temp);
        //写入文件
        $fp = fopen($online_log,"w");
        flock($fp,LOCK_EX); //flock() 不能在NFS以及其他的一些网络文件系统中正常工作
        fputs($fp,$entries);
        flock($fp,LOCK_UN);
        fclose($fp);
        echo "在线人数：".$slzxrs."人";
    ?>

以上代码不仅适用于 Typecho 程序，也适用于其它php博客系统，仅需要进行简单的调整即可。
