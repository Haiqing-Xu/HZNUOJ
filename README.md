**HZNUOJ 是基于 [HUSTOJ](https://github.com/zhblue/hustoj) 改造而来的，遵循GPL协议开源**

# 优势

* 更华丽的界面
* 更灵活的权限管理
* 支持多组样例
* 有封装好的Docker镜像，一键部署


# 界面截图

## 首页

支持提交量和访问量的统计

![index](images/index.jpg)

## 榜单

重写过的的榜单

![board](images/board.jpg)

能点开查看每题的提交状况

![board2](images/board2.jpg)

## 题目编辑界面

![problem-edit](images/problem-edit.jpg)

多样例支持

![problem-edit](images/problem-edit2.jpg)

## 权限管理界面

细分的权限分配

![privilege](images/privilege.jpg)

# 部署指南

## 使用源码

0. 此版本HZNUOJ目前在Ubuntu20.04.1上跑过，可以正常运行。

1. 下载源码
   `git clone https://github.com/tiger2010/HZNUOJ.git`
   或者直接访问`https://github.com/tiger2010/HZNUOJ` 下载zip包

2. 若已安装mysql，请修改`intall.sh` `judge.conf` `/web/OJ/include/static.php` 中的相应账户密码信息(默认为root/root)。若还未安装，请确保接下来安装mysql的过程中将用户名和密码都设成root。

3. 以root权限运行`judger/install/install.sh` , 请确保在目录 `judger/install/` 下

	本地登录或者ssh远程登录Ubuntu系统后，命令行下按顺序执行以下指令：
   ```bash
   admin@ubuntu16:~$ cd HZNUOJ/judger/install
   admin@ubuntu16:~/HZNUOJ/judger/install$ sudo bash install.sh
   ```
4. ## MySQL Configuration

Remember to increase `max_connections`, `thread_stack` and `max_heap_table_size` in `my.cnf`:

    max_connections = 1000
    thread_stack = 640K
    max_heap_table_size = 1024M

Also change default character set to UTF-8:

    default-character-set = utf8

5. 安装完成后访问localhost、服务器IP或相应域名即可。

## 原理

系统分为后台的Core(判题机)和前台的web(网站)两大部分。两个部分相对独立，通过数据库关联。判题机通过轮询数据库提取判题队列，生成判题信息回写数据库，web部分读取数据库显示在网页上。

若发现提交代码后无法判题，一直显示pending或者等待，请尝试服务器中运行以下命令重启判题机进程
```bash
admin@ubuntu16:~$ sudo pkill -9 judged && sudo judged && ps -A | grep judged
若出现类似"xxxx ?        00:00:00 judged"的字样，说明进程重启成功
```

更多原理和说明可参考[hustoj文档大全.pdf](https://github.com/zhblue/hustoj/wiki/hustoj文档大全.pdf)及[HZNUOJ常见问题列表](wiki/maintainer-manual.md)

# 使用教程

默认管理员账号为admin/123456。

出题手册见https://www.yuque.com/weilixinlianxin/zcf10d/yfk05w

# 贡献代码/Bug反馈

HZNUOJ目前开发人手很有限，只有已经上班的我和训练繁忙的一些学弟，有许多已知的不友好的功能和小BUG，只能抽时间慢慢改了。

同时也欢迎大家反馈[issue](https://github.com/wlx65003/HZNUOJ/issues)/提交[pull request](https://github.com/wlx65003/HZNUOJ/pulls)帮忙一起完善HZNUOJ。

最后，如果您觉得HZNUOJ好用，请给我一个Star，这将是对我莫大的帮助与鼓励，十分感谢！
