<?php
  /**
   * This file is modified
   * by yybird
   * @2016.05.26
  **/
?>


<?php
  $title = "Show Source Code";
  $cache_time=90;
  $OJ_CACHE_SHARE=false;
  require_once('./include/cache_start.php');
  require_once('./include/db_info.inc.php');
  require_once('./include/setlang.php');
  require_once("./include/my_func.inc.php");
  $view_title= "Source Code"; 
  require_once("./include/const.inc.php");
  if (!isset($_GET['id'])){
    $view_errors= "No such code!\n";
    require("template/".$OJ_TEMPLATE."/error.php");
    exit(0);
  }


  /* 获取solution信息 start */
  $sid=strval(intval($_GET['id']));
  $sql="SELECT * FROM `solution` WHERE `solution_id`='".$sid."'";
  $result=mysql_query($sql);
  $row=mysql_fetch_object($result);
  $slanguage=$row->language;
  $sresult=$row->result;
  $stime=$row->time;
  $smemory=$row->memory;
  $view_user_id=$suser_id=$row->user_id;
  $pid = $row->problem_id;
  $cid = $row->contest_id;
  mysql_free_result($result);
  /* 获取solution信息 end */

  $ok = canSeeSource($sid);

  $view_source="No source code available!";
  
  $sql="SELECT `source` FROM `source_code_user` WHERE `solution_id`=".$sid;
  $result=mysql_query($sql);
  $row=mysql_fetch_object($result);
  if($row) $view_source=$row->source;

  /////////////////////////Template
  require("template/".$OJ_TEMPLATE."/showsource.php");
  /////////////////////////Common foot
  if(file_exists('./include/cache_end.php'))
    require_once('./include/cache_end.php');
?>
