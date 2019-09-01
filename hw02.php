<?php
$poker = range(0,51);
for($i=0;$i<51;$i++){
    $rand = rand(0,51);
    // echo $rand."<br>";
    $c = $poker[$i];
    $poker[$i] = $poker[$rand];
    $poker[$rand] = $c;
}
$players = [[],[],[],[]];
foreach($poker as $k=>$card){
    // 前面為玩家數,後面為牌數
    $players[$k%4][(int)($k/4)] = $card;    // p[0][0],p[1][0],p[2][0],p[3][0],
}                                           // p[0][1],p[1][1],p[2][1],p[3][1]......
// $a=1;$b=2;
// $c=$a;
// $a=$b;
// $b=$c;
// echo $a.":".$b;
?>
<table width="100%" border="1px">
    <?php
    $values = ["A",2,3,4,5,6,7,8,9,10,"J","Q","K"];
    $suits = ["&spades;",
                "<font color='red'>&hearts;</font>",
                "<font color='red'>&diams;</font>",
                "&clubs;"];
    foreach($players as $player){
        echo "<tr>";
        sort($player);  // 排序
        foreach($player as $k){
            echo "<td>{$suits[(int)($k/13)]}{$values[$k%13]}</td>";
        }
        echo "</tr>";
    }
    ?>
</table>