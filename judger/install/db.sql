set names utf8mb4;
create database if not exists jol;
use jol;


CREATE TABLE IF NOT EXISTS `contest_discuss` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL DEFAULT '',
  `contest_id` int(11) NOT NULL,
  `problem_id` int(11) DEFAULT NULL,
  `content` text,
  `reply` text,
  `in_date` datetime DEFAULT NULL,
  `reply_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `printer_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` char(48) NOT NULL,
  `contest_id` int(11) NOT NULL,
  `code` text NOT NULL,
  `in_date` datetime DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `compileinfo` (
  `solution_id` int(11) NOT NULL DEFAULT '0',
  `error` text,
  PRIMARY KEY (`solution_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `contest` (
  `contest_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `defunct` char(1) NOT NULL DEFAULT 'N',
  `description` text,
  `private` tinyint(4) NOT NULL DEFAULT '0',
  `langmask` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'bits for LANG to mask',
  `password` char(16) NOT NULL DEFAULT '',
  `user_id` varchar(48) NOT NULL DEFAULT 'admin',
  `user_limit` char(1) NOT NULL,
  `defunct_TA` char(1) NOT NULL,
  `open_source` char(1) NOT NULL,
  `lock_time` int(11) DEFAULT NULL,
  `unlock` tinyint(4) DEFAULT '1',
  `first_prize` int(11) DEFAULT '0',
  `second_prize` int(11) DEFAULT '0',
  `third_prize` int(11) DEFAULT '0',
  `practice` tinyint(4) DEFAULT '0',
  `isTop` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`contest_id`),
  KEY `contest_id` (`contest_id`,`defunct`,`private`,`defunct_TA`,`open_source`) USING BTREE,
  KEY `running_contest` (`start_time`,`end_time`,`practice`)
) ENGINE=MyISAM AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `contest_excluded_user` (
  `index` int(11) NOT NULL AUTO_INCREMENT,
  `contest_id` int(11) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`index`),
  KEY `contest_id` (`contest_id`,`user_id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;


CREATE TABLE IF NOT EXISTS `contest_problem` (
  `index` int(11) NOT NULL AUTO_INCREMENT,
  `problem_id` int(11) NOT NULL DEFAULT '0',
  `contest_id` int(11) NOT NULL,
  `title` char(200) NOT NULL DEFAULT '',
  `num` int(11) NOT NULL DEFAULT '0',
  `score` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`index`),
  KEY `contest_id` (`contest_id`) USING BTREE,
  KEY `problem_id` (`problem_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `custominput` (
  `solution_id` int(11) NOT NULL DEFAULT '0',
  `input_text` text,
  PRIMARY KEY (`solution_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `faq_codes` (
  `language` varchar(255) CHARACTER SET utf8 NOT NULL,
  `language_show` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `code` varchar(10000) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`language`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;


CREATE TABLE IF NOT EXISTS `faqs` (
  `index` int(11) NOT NULL AUTO_INCREMENT,
  `content` text,
  PRIMARY KEY (`index`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;


LOCK TABLES `faqs` WRITE;
/*!40000 ALTER TABLE `faqs` DISABLE KEYS */;
INSERT INTO `faqs` VALUES (1,'## 环境参数\r\n\r\n系统运行于[Debian 10](https://www.debian.org/)\r\n对应的编译器和编译选项如下:\r\n\r\n|   语言   |       编译器版本       |                   编译选项                   |\r\n| :----: | :---------------: | :--------------------------------------: |\r\n|   C    |     gcc 8.3.0     | gcc Main.c -o Main -fno-asm -O2 -Wall -lm --static -std=c99 -DONLINE_JUDGE |\r\n|  C++   |     g++ 8.3.0     | g++ Main.cc -o Main -fno-asm -O2 -Wall -lm --static -std=c++11 -DONLINE_JUDGE |\r\n| Python3 |       3.7.3       |                                          |\r\n|\r\n\r\n## 例题示范\r\n\r\n你的程序应该从标准输入 `stdin(\'Standard Input\')`获取输出 并将结果输出到标准输出 `stdout(\'Standard Output\')`.例如,在C语言可以使用 `scanf` ，在C++可以使用`cin` 进行输入；在C使用`printf` ，在C++使用`cout`进行输出. 用户程序不允许直接读写文件, 如果这样做可能会判为运行时错误 \"Runtime Error\"。\r\n详见[1000](/OJ/problem.php?id=1000)题hint中各种语言的参考答案。\r\n\r\n## 测评结果释义\r\n\r\n| 评测结果                  | 缩写   | 含义                                       |\r\n| --------------------- | ---- | :--------------------------------------- |\r\n| Pending               | PD   | 您的提交正排队等待评测。                             |\r\n| Pending Rejudge       | PR   | 因为数据更新或其他原因，系统将重新判你的答案。                  |\r\n| Compiling             | CP   | 您提交的代码正在被编译。                             |\r\n| Running & Judging     | RN   | 您的程序正在运行。                                |\r\n| Judging               | JG   | 我们 正在检查您程序的输出是否正确。                       |\r\n| Accepted              | AC   | 恭喜！您的程序通过了所有数据！                          |\r\n| Presentation Error    | PE   | 您的程序输出有格式问题，请检查是否多了或者少了空格 （\' \'）、制表符（\'\\t\'）或者换行符（\'\\n\'） |\r\n| Wrong Answer          | WA   | 您的程序输出结果错误。                              |\r\n| Runtime Error         | RE   | 您的程序在运行时发生错误。                            |\r\n| Time Limit Exceeded   | TLE  | 您的程序运行的时间已经超出了题目的时间限制。                   |\r\n| Memory Limit Exceeded | MLE  | 您的程序运行的内存已经超出了题目的内存限制。                   |\r\n| Output Limit Exceeded | OLE  | 您的程序输出内容太多，超过了这个题目的输出限制。（一般输出超过答案2倍时会触发，强制终止程序，防止恶意输出对硬盘造成压力） |\r\n| Compile Error         | CE   | 您的程序语法出现问题，编译器无法编译。                      |\r\n| System Error          | SE   | 评判系统内部出现错误 ，我们会尽快处理。                     |\r\n| Out Of Contest Time   | OCT  | 考试已经结束，不再评测提交。                           |\r\n\r\n## 常见编译问题\r\n\r\n有的时候你的程序在本地能编译通过，但提交OJ后却显示编译错误。\r\n\r\n这多见于C/C++，一般是因为你本地用的是VS，VS的编译器是MS-VC++，而OJ用的是G++，这两个编译器的标准略有不同，G++更符合标准，下面列出一些常见的导致CE原因：\r\n\r\n* `main` 函数必须返回`int`, ` void main()` 的函数声明会报编译错误。\r\n* `itoa` 不是ansi标准函数.\r\n* `__int64` 不是ANSI标准定义，只能在VC使用, 但是可以使用`long long`声明64位整数。\r\n\r\n如果你使用JAVA语言，请注意类名一定要是`Main`， 否则也会返回CE。\r\n\r\n## 比赛相关\r\n\r\n### 比赛的类型\r\n\r\n目前HZNUOJ有四种类型的比赛：\r\n\r\n* practice，练习赛，只是简单的把题目归个类做做练习，相应题目不会从problemset中隐藏，且通过后可以立即进入题目的status里查看别人的代码。\r\n* public，公开的比赛，任何人均可进入参加。\r\n* password，设有密码保护的比赛，只有输入正确密码才能进入。\r\n* special，特殊比赛，只有使用专门发放的账号才能进入。\r\n\r\n### 比赛赛制\r\n\r\nHZNUOJ所有类型的比赛均为ACM/ICPC赛制。\r\n\r\n每场比赛设有若干道题目，比赛开始后，参赛者需在时限内去解决这些题目。\r\n\r\n每场比赛都设有实时榜单，榜单排名规则也与ACM/ICPC相同。\r\n\r\n### ACM/ICPC排名规则\r\n\r\n每题耗时：Accepted的那一刻距离比赛开始的时间。\r\n\r\n总罚时：所有AC了的题的（耗时+错误次数*20min）的和。\r\n\r\n排名时，AC题数优先，题数相同时按罚时排序。 \r\n\r\n有些比较正式的比赛设有封榜机制，即比赛最后一段时间内的提交结果将隐藏（除了自己都不可见），榜单也会停止更新，新的提交会显示为灰色，留作最后滚榜用。\r\n\r\n#### 滚榜机制介绍\r\n\r\n滚榜是ACM/ICPC系列比赛中一个十分具有特色的机制。\r\n\r\n在正规ACM/ICPC系列比赛中，比赛最后一个小时的提交结果是隐藏的，只有选手本人能看到，在榜单上会显示成代表未知的灰色，以增加比赛紧张气氛。\r\n\r\n然后在颁奖会上，将从榜单最后一名开始，一个个揭晓灰色的未知提交，一旦揭晓的结果为通过，这个人的排名就会上升，否则这个人的排名确定，开始揭晓下一个人，以此类推。这样一来，可以从后往前一个个确定最终排名，一旦名次达到获奖名次内，可以直接进行颁奖。整个过程惊险刺激，是整个比赛的亮点所在。\r\n\r\n## 题目相关\r\n\r\nHZNUOJ的所有题目均在ProblemSet 中，每个题目都有一个唯一的数字编号，称为Problem ID。\r\n\r\n每当你AC了一道题，你就有权限查看这题所有的提交代码，借鉴参考大神们的写法，从而更上一层楼。\r\n\r\n比赛的所有题目，都是从ProblemSet中选出来的，是它的子集。\r\n\r\n当一道题被选入某个非practice模式的比赛中之后，为公平起见，它会在ProblemSet中被隐藏掉，在比赛结束后恢复。\r\n\r\n一般如果题目突然不见了，可能就是这个原因，当然也有可能是因为其他原因而被管理员手动隐藏了。\r\n\r\n当然，一般比赛的题都是新出的，比赛结束后才第一次在ProblemSet中露面。\r\n\r\n选入比赛中的题目，在比赛界面中，会隐藏掉原来的Problem ID，取而代之的是A, B, C...的代号。在比赛结束后，会在标题旁边显示真正的Problem ID，可以点击前往ProblemSet补题。\r\n\r\n## 积分规则\r\n\r\nHZNUOJ的ProblemSet中设有一个榜单，积分和等级的计算规则如下。\r\n\r\n等级由实力（Strength）决定，当实力达到一定值后自然会升级，而实力又从刷题中来，每道题后面均标有分数（Scores），代表AC这道题之后能提升多少实力。一般来说，越少人做的题目，分数越高，一起刷题的人越多，每道题的分数也越高。需要说明的是，用户的实力值是会根据大环境动态变化的（其实是因为分数在动态变化），如果你AC的题目被更多人AC出来了，你的实力值会下降，另外一方面，OJ内有更多强者涌入的时候，你的实力值也会提升。所以，想要快速升级，那就多刷题，刷难题！\r\n\r\n等级划分与小说《斗破苍穹》一致，自低向高分别为斗之气、斗者、斗师、大斗师、斗灵、斗王、斗皇、斗宗、斗尊、斗圣、斗帝，除斗帝外，每一阶又分不同等级，阶数越高，升级越困难。除此之外，每一阶还有不同的代表颜色，该阶等级越高，颜色越深。\r\n\r\n');
/*!40000 ALTER TABLE `faqs` ENABLE KEYS */;
UNLOCK TABLES;


CREATE TABLE IF NOT EXISTS `hit_log` (
  `index` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(46) DEFAULT NULL,
  `path` text,
  `time` datetime DEFAULT NULL,
  `user_id` text,
  PRIMARY KEY (`index`),
  KEY `time` (`time`),
  KEY `ip` (`ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `loginlog` (
  `index` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(40) DEFAULT NULL,
  `ip` varchar(46) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`index`),
  KEY `user_time_index` (`user_id`,`time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `mail` (
  `mail_id` int(11) NOT NULL AUTO_INCREMENT,
  `to_user` varchar(48) NOT NULL DEFAULT '' COMMENT 'user_id',
  `from_user` varchar(48) NOT NULL DEFAULT '' COMMENT 'user_id',
  `title` varchar(200) NOT NULL DEFAULT '',
  `content` text,
  `new_mail` tinyint(1) NOT NULL DEFAULT '1',
  `reply` tinyint(4) DEFAULT '0',
  `in_date` datetime DEFAULT NULL,
  `defunct` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`mail_id`),
  KEY `uid` (`to_user`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `message` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `problem_id` int(11) NOT NULL DEFAULT '0',
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `thread_id` int(11) NOT NULL DEFAULT '0',
  `depth` int(11) NOT NULL DEFAULT '0',
  `orderNum` int(11) NOT NULL DEFAULT '0',
  `user_id` varchar(20) NOT NULL DEFAULT '',
  `title` varchar(200) NOT NULL DEFAULT '',
  `content` text,
  `in_date` datetime DEFAULT NULL,
  `defunct` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`message_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `news` (
  `news_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(48) NOT NULL DEFAULT '' COMMENT 'user_id',
  `title` varchar(200) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `time` datetime NOT NULL,
  `importance` tinyint(4) NOT NULL DEFAULT '0',
  `defunct` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`news_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `online` (
  `hash` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `ip` varchar(46) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `ua` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `refer` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastmove` int(10) NOT NULL,
  `firsttime` int(10) DEFAULT NULL,
  `uri` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`hash`),
  UNIQUE KEY `hash` (`hash`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE IF NOT EXISTS `privilege` (
  `index` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` char(48) NOT NULL DEFAULT '',
  `rightstr` char(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`index`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;


LOCK TABLES `privilege` WRITE;
/*!40000 ALTER TABLE `privilege` DISABLE KEYS */;
INSERT INTO `privilege` VALUES (1,'admin','root');
/*!40000 ALTER TABLE `privilege` ENABLE KEYS */;
UNLOCK TABLES;


CREATE TABLE IF NOT EXISTS `privilege_distribution` (
  `group_name` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `enter_admin_page` tinyint(4) DEFAULT NULL,
  `edit_default_problem` tinyint(4) DEFAULT NULL,
  `rejudge` tinyint(4) DEFAULT NULL,
  `edit_news` tinyint(4) DEFAULT NULL,
  `edit_contest` tinyint(4) DEFAULT NULL,
  `download_ranklist` tinyint(4) DEFAULT NULL,
  `generate_team` tinyint(4) DEFAULT NULL,
  `edit_user_profile` tinyint(4) DEFAULT NULL,
  `edit_privilege_group` tinyint(4) DEFAULT NULL,
  `edit_privilege_distribution` tinyint(4) DEFAULT NULL,
  `inner_function` tinyint(4) DEFAULT NULL,
  `see_hidden_default_problem` tinyint(4) DEFAULT NULL,
  `see_hidden_user_info` tinyint(4) DEFAULT NULL,
  `see_wa_info_out_of_contest` tinyint(4) DEFAULT NULL,
  `see_wa_info_in_contest` tinyint(4) DEFAULT NULL,
  `see_source_out_of_contest` tinyint(4) DEFAULT NULL,
  `see_source_in_contest` tinyint(4) DEFAULT NULL,
  `see_compare` tinyint(4) DEFAULT NULL,
  `upload_files` tinyint(4) DEFAULT NULL,
  `watch_solution_video` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`group_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;


LOCK TABLES `privilege_distribution` WRITE;
/*!40000 ALTER TABLE `privilege_distribution` DISABLE KEYS */;
INSERT INTO `privilege_distribution` VALUES ('administrator',1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1),('exam_user',1,0,1,0,1,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0),('hznu_viewer',1,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0),('root',1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),('source_browser',1,0,1,0,0,1,0,0,0,0,0,0,1,1,1,1,1,1,0,0),('teacher',1,1,1,0,1,1,0,1,0,0,0,1,1,1,1,1,1,1,1,1),('teacher_assistant',1,1,1,0,1,0,0,0,0,0,0,1,1,1,1,1,1,0,1,0);
/*!40000 ALTER TABLE `privilege_distribution` ENABLE KEYS */;
UNLOCK TABLES;


CREATE TABLE IF NOT EXISTS `privilege_groups` (
  `group_order` int(11) NOT NULL DEFAULT '0',
  `group_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`group_order`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;


LOCK TABLES `privilege_groups` WRITE;
/*!40000 ALTER TABLE `privilege_groups` DISABLE KEYS */;
INSERT INTO `privilege_groups` VALUES (0,'root'),(1,'administrator'),(2,'teacher'),(3,'teacher_assistant'),(4,'source_browser'),(5,'hznu_viewer'),(6,'exam_user');
/*!40000 ALTER TABLE `privilege_groups` ENABLE KEYS */;
UNLOCK TABLES;


CREATE TABLE IF NOT EXISTS `problem` (
  `problem_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL DEFAULT '',
  `description` text,
  `input` text,
  `output` text,
  `sample_input` text,
  `sample_output` text,
  `spj` char(1) NOT NULL DEFAULT '0',
  `hint` text,
  `author` varchar(30) DEFAULT NULL,
  `source` varchar(100) DEFAULT NULL,
  `in_date` datetime DEFAULT NULL,
  `time_limit` int(11) NOT NULL DEFAULT '0',
  `memory_limit` int(11) NOT NULL DEFAULT '0',
  `defunct` char(1) NOT NULL DEFAULT 'N',
  `accepted` int(11) DEFAULT '0',
  `submit` int(9) DEFAULT '0',
  `solved_user` int(9) DEFAULT '0',
  `submit_user` int(9) DEFAULT NULL,
  `score` decimal(6,2) unsigned DEFAULT '100.00',
  `tag1` varchar(250) DEFAULT NULL,
  `tag2` varchar(250) DEFAULT NULL,
  `tag3` varchar(250) DEFAULT NULL,
  `problemset` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`problem_id`),
  UNIQUE KEY `problem_id` (`problem_id`) USING BTREE,
  KEY `score` (`score`,`accepted`)
) ENGINE=MyISAM AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4;


LOCK TABLES `problem` WRITE;
INSERT INTO `problem` (`problem_id`, `title`, `description`, `input`, `output`, `sample_input`, `sample_output`, `spj`, `hint`, `author`, `source`, `in_date`, `time_limit`, `memory_limit`, `defunct`, `accepted`, `submit`, `solved_user`, `submit_user`, `score`, `tag1`, `tag2`, `tag3`, `problemset`) VALUES (1000, 'A+B', '<p>\r\n  Calculate a+b\r\n</p>', '<p>\r\n  Two integer a,b (0&lt;=a,b&lt;=10)\r\n</p>', '<p>\r\n Output a+b\r\n</p>', NULL, NULL, '0', '<p>\r\n  C:\r\n</p>\r\n<pre class="prettyprint"><code>#include &lt;stdio.h&gt;\r\nint main()\r\n{\r\n    int a, b, sum;\r\n    scanf("%d%d", &amp;a, &amp;b);\r\n  sum = a + b;\r\n    printf("%d\\n", sum);\r\n    return 0;\r\n}</code></pre>\r\n<p>\r\n C++:\r\n</p>\r\n<pre class="prettyprint"><code>#include &lt;iostream&gt;\r\nusing namespace std;\r\nint main(){\r\n    int a, b, sum;\r\n    cin &gt;&gt; a &gt;&gt; b;\r\n sum = a + b;\r\n    cout &lt;&lt; sum;\r\n    return 0;\r\n}</code></pre>\r\nPython3:\r\n<pre class="prettyprint"><code>a,b=map(int,input().split())\r\nprint(a+b)</code></pre>', 'admin', '基础操作题', '2021-02-18 14:02:22', 1, 128, 'N', 0, 0, 0, NULL, 100.00, NULL, NULL, NULL, 'default');
UNLOCK TABLES;


CREATE TABLE IF NOT EXISTS `problem_samples` (
  `problem_id` int(11) NOT NULL,
  `sample_id` int(11) NOT NULL DEFAULT '0',
  `input` text CHARACTER SET utf8,
  `output` text CHARACTER SET utf8,
  `show_after` int(11) DEFAULT '0',
  PRIMARY KEY (`problem_id`,`sample_id`),
  KEY `problem_id` (`problem_id`,`sample_id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;


LOCK TABLES `problem_samples` WRITE;
/*!40000 ALTER TABLE `problem_samples` DISABLE KEYS */;
INSERT INTO `problem_samples` VALUES (1000,0,'1 2','3',0);
/*!40000 ALTER TABLE `problem_samples` ENABLE KEYS */;
UNLOCK TABLES;


CREATE TABLE IF NOT EXISTS `problemset` (
  `index` int(11) NOT NULL AUTO_INCREMENT,
  `set_name` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `set_name_show` varchar(255) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`index`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT AUTO_INCREMENT=2;


LOCK TABLES `problemset` WRITE;
/*!40000 ALTER TABLE `problemset` DISABLE KEYS */;
INSERT INTO `problemset` VALUES (1,'default','DEFAULT');
/*!40000 ALTER TABLE `problemset` ENABLE KEYS */;
UNLOCK TABLES;


CREATE TABLE IF NOT EXISTS `reply` (
  `rid` int(11) NOT NULL AUTO_INCREMENT,
  `author_id` varchar(48) NOT NULL DEFAULT '' COMMENT 'user_id',
  `time` datetime NOT NULL,
  `content` text NOT NULL,
  `topic_id` int(11) NOT NULL,
  `status` int(2) NOT NULL DEFAULT '0',
  `ip` varchar(46) NOT NULL,
  PRIMARY KEY (`rid`),
  KEY `author_id` (`author_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `runtimeinfo` (
  `solution_id` int(11) NOT NULL DEFAULT '0',
  `error` text,
  PRIMARY KEY (`solution_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `sim` (
  `s_id` int(11) NOT NULL,
  `sim_s_id` int(11) DEFAULT NULL,
  `sim` int(11) DEFAULT NULL,
  PRIMARY KEY (`s_id`),
  KEY `Index_sim_id` (`sim_s_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `slide` (
  `img_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(200) NOT NULL,
  `defunct` char(1) DEFAULT NULL,
  PRIMARY KEY (`img_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `solution` (
  `solution_id` int(11) NOT NULL AUTO_INCREMENT,
  `problem_id` int(11) DEFAULT '0',
  `user_id` char(48) NOT NULL,
  `time` int(11) NOT NULL DEFAULT '0',
  `memory` int(11) NOT NULL DEFAULT '0',
  `in_date` datetime NOT NULL,
  `result` smallint(6) NOT NULL DEFAULT '0',
  `language` tinyint(4) NOT NULL DEFAULT '0',
  `ip` char(46) NOT NULL,
  `contest_id` int(11) DEFAULT NULL,
  `valid` tinyint(4) NOT NULL DEFAULT '1',
  `num` tinyint(4) NOT NULL DEFAULT '-1',
  `code_length` int(11) NOT NULL DEFAULT '0',
  `judgetime` datetime DEFAULT NULL,
  `pass_rate` decimal(3,2) unsigned NOT NULL DEFAULT '0.00',
  `judger` char(16) NOT NULL DEFAULT 'LOCAL',
  PRIMARY KEY (`solution_id`),
  KEY `pid` (`problem_id`),
  KEY `res` (`result`),
  KEY `in_date` (`in_date`) USING BTREE,
  KEY `uid` (`user_id`,`result`) USING BTREE,
  KEY `cid` (`contest_id`,`result`,`num`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `solution_video_watch_log` (
  `index` int(11) NOT NULL AUTO_INCREMENT,
  `video_id` int(11) NOT NULL,
  `user_id` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`index`),
  KEY `video_id` (`video_id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;


CREATE TABLE IF NOT EXISTS `source_code` (
  `solution_id` int(11) NOT NULL,
  `source` text NOT NULL,
  PRIMARY KEY (`solution_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `source_code_user` (
  `solution_id` int(11) NOT NULL,
  `source` text NOT NULL,
  PRIMARY KEY (`solution_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `tag` (
  `index` int(11) NOT NULL AUTO_INCREMENT,
  `problem_id` int(10) unsigned zerofill NOT NULL,
  `user_id` varchar(100) CHARACTER SET utf8 NOT NULL,
  `tag` varchar(100) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`index`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `team` (
  `user_id` varchar(30) NOT NULL,
  `prefix` varchar(30) DEFAULT NULL,
  `NO` int(10) DEFAULT NULL,
  `password` varchar(32) NOT NULL,
  `nick` varchar(100) NOT NULL,
  `contest_id` int(13) NOT NULL,
  `stu_id` varchar(255) DEFAULT NULL,
  `institute` varchar(255) DEFAULT NULL,
  `class` varchar(30) DEFAULT NULL,
  `real_name` varchar(255) DEFAULT NULL,
  `seat` varchar(255) DEFAULT NULL,
  `school` varchar(100) DEFAULT NULL,
  `accesstime` datetime DEFAULT NULL,
  `reg_time` datetime DEFAULT NULL,
  `ip` varchar(46) DEFAULT NULL,
  PRIMARY KEY (`contest_id`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `topic` (
  `tid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varbinary(60) NOT NULL,
  `status` int(2) NOT NULL DEFAULT '0',
  `top_level` int(2) NOT NULL DEFAULT '0',
  `cid` int(11) DEFAULT NULL,
  `pid` int(11) NOT NULL,
  `author_id` varchar(48) NOT NULL DEFAULT '' COMMENT 'user_id',
  PRIMARY KEY (`tid`),
  KEY `cid` (`cid`,`pid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `users` (
  `user_id` varchar(48) NOT NULL DEFAULT '' COMMENT 'user_id',
  `stu_id` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `submit` int(11) DEFAULT '0',
  `solved` int(11) DEFAULT '0',
  `defunct` char(1) NOT NULL DEFAULT 'N',
  `ip` varchar(46) NOT NULL DEFAULT '',
  `accesstime` datetime DEFAULT NULL,
  `volume` int(11) NOT NULL DEFAULT '1',
  `volume_c` int(11) DEFAULT NULL,
  `language` int(11) NOT NULL DEFAULT '1',
  `password` varchar(32) DEFAULT NULL,
  `reg_time` datetime DEFAULT NULL,
  `real_name` varchar(100) DEFAULT NULL,
  `nick` varchar(100) NOT NULL DEFAULT '',
  `school` varchar(100) NOT NULL DEFAULT '',
  `class` varchar(127) DEFAULT NULL,
  `level` varchar(20) DEFAULT NULL,
  `strength` double(10,2) DEFAULT NULL,
  `color` varchar(20) DEFAULT NULL,
  `ZJU` int(9) unsigned DEFAULT NULL,
  `HDU` int(9) unsigned DEFAULT NULL,
  `PKU` int(9) unsigned DEFAULT NULL,
  `UVA` int(9) unsigned DEFAULT NULL,
  `CF` int(9) DEFAULT NULL,
  `like` int(9) DEFAULT '0',
  `dislike` int(9) DEFAULT '0',
  `tag` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;


LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('admin','','temp@temp.com',0,0,'N','::1','2019-03-12 16:34:09',1,NULL,1,'YQn1zuOVuWzSNcU5WwkMauvCGw00YzNl','2019-03-12 16:34:09','','admin','','其它','斗之气五段',0.00,'#b6b6b6',NULL,NULL,NULL,NULL,NULL,0,0,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;


CREATE TABLE IF NOT EXISTS `users_cache` (
  `user_id` varchar(48) NOT NULL,
  `class` varchar(15) CHARACTER SET utf8 NOT NULL,
  `AC_day` int(10) unsigned zerofill DEFAULT NULL,
  `sub_day` int(10) unsigned zerofill DEFAULT NULL,
  `activity` int(10) unsigned zerofill DEFAULT NULL,
  `total_score` decimal(10,2) unsigned zerofill DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;


LOCK TABLES `users_cache` WRITE;
/*!40000 ALTER TABLE `users_cache` DISABLE KEYS */;
INSERT INTO `users_cache` VALUES ('admin','',0000000001,0000000001,NULL,NULL);
/*!40000 ALTER TABLE `users_cache` ENABLE KEYS */;
UNLOCK TABLES;


CREATE TABLE IF NOT EXISTS `users_cache_array` (
  `index` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(48) NOT NULL,
  `type` varchar(15) NOT NULL,
  `week` int(9) unsigned zerofill DEFAULT NULL,
  `value_int` int(10) unsigned zerofill NOT NULL,
  `value_double` decimal(10,2) unsigned zerofill DEFAULT NULL,
  PRIMARY KEY (`index`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `class_list` (
  `class_name` varchar(100) NOT NULL,
  `enrollment_year` smallint(4) NOT NULL,
  PRIMARY KEY (`class_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;


LOCK TABLES `class_list` WRITE;
/*!40000 ALTER TABLE `class_list` DISABLE KEYS */;
INSERT INTO `class_list` VALUES ('其它', '0');
/*!40000 ALTER TABLE `class_list` ENABLE KEYS */;
UNLOCK TABLES;


CREATE TABLE IF NOT EXISTS `reg_code` (
  `class_name` varchar(100) NOT NULL,
  `reg_code` varchar(100) NOT NULL,
  `remain_num` smallint(4) NOT NULL,
  PRIMARY KEY (`class_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;


LOCK TABLES `reg_code` WRITE;
/*!40000 ALTER TABLE `reg_code` DISABLE KEYS */;
INSERT INTO `reg_code` VALUES ('其它', '', '0');
/*!40000 ALTER TABLE `reg_code` ENABLE KEYS */;
UNLOCK TABLES;


CREATE TABLE IF NOT EXISTS `course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `section` varchar(255) NOT NULL,
  `order` int(11) NOT NULL DEFAULT '10000',
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `isProblem` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;
-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('1', '入门篇', '0', '0', '0');

-- 添加触发器，防止同一用户类似代码提交第二遍时被认定为抄袭
delimiter //
drop trigger if exists simfilter//
create trigger simfilter
before insert on sim
for each row
begin
 declare new_user_id varchar(64);
 declare old_user_id varchar(64);
 select user_id from solution where solution_id=new.s_id into new_user_id;
 select user_id from solution where solution_id=new.sim_s_id into old_user_id;
 if old_user_id=new_user_id then
	set new.s_id=0;
 end if;
end;//
delimiter ;



