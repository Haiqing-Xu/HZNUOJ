<!-- 页标签 start -->
  <div class="am-g">
    <ul class="am-pagination am-text-center">
        <?php $link = generate_url(Array("page"=>max($page-1, 1)))?>
      <li><a href="<?php echo $link ?>">&laquo; Prev</a></li>

<?php
  //分页 by XuHaiqing xhq@qszx.cn 2021.02.12

  if(intval($view_total_page)<=9){
    $start_num=1;
    $stop_num=intval($view_total_page);
  }
  else{
    if($page-4>0){
      $start_num=$page-4;
      if($start_num+8<intval($view_total_page)){
        $stop_num=$start_num+8;
      }
      else{
        $start_num=intval($view_total_page)-8;
        $stop_num=intval($view_total_page);
      }
    }
    else{
      $start_num=1;
      $stop_num=$start_num+8;
    }
  }

  if($start_num>5){
    for($i=1;$i<=3;$i++){
      $link=generate_url(Array("page"=>"$i"));
      echo "<li><a href=\"$link\">{$i}</a></li>";
    }
    echo "&nbsp;...&nbsp;";
  }
  else{
    for($i=1;$i<=$start_num-1;$i++){
      $link=generate_url(Array("page"=>"$i"));
      echo "<li><a href=\"$link\">{$i}</a></li>";
    }
  }
  
  for($i=$start_num;$i<=$stop_num;$i++){
    $link=generate_url(Array("page"=>"$i"));
    if($page==$i)
      echo "<li class='am-active'><a href=\"$link\">{$i}</a></li>";
    else
      echo "<li><a href=\"$link\">{$i}</a></li>";
  }

  if($stop_num<intval($view_total_page)-4){
    echo "&nbsp;...&nbsp;";
    for($i=intval($view_total_page)-2;$i<=intval($view_total_page);$i++){
      $link=generate_url(Array("page"=>"$i"));
      echo "<li><a href=\"$link\">{$i}</a></li>";
    }
  }
  else{
    for($i=$stop_num+1;$i<=intval($view_total_page);$i++){
      $link=generate_url(Array("page"=>"$i"));
      echo "<li><a href=\"$link\">{$i}</a></li>";
    }
  }
?>
        <?php $link = generate_url(Array("page"=>min($page+1,intval($view_total_page)))) ?>
      <li><a href="<?php echo $link ?>">Next &raquo;</a></li>
    </ul>
  </div>
<!-- 页标签 end -->