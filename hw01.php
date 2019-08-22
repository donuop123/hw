<table border ="1px" width="100%">
    <?php
    $temp = array();
    $tot = 0;
    for($a = 1;$a <=100; $a++){
        $t = 0;
        for($b =1; $b<=$a; $b++){
            if($a%$b == 0){
                $t = $t + 1;
            }
        }
        if($t == 2){
            $temp[] = $a;
            $tot ++;
        }
    }
    foreach($temp as $l => $v){
        echo "{$l}:{$v}<br>";
    }
    echo $tot."<br>";
    // echo $temp[$l];
    $k = 0;
    $isrepeat = false;
    for($j = 1; $j <= 10; $j++){
        echo "<tr>";
        for($i = 1; $i <= 10; $i++){
            $k = $k + 1;
            for($m =0; $m < $tot; $m++){
                if($temp[$m] == $k){
                    echo "<td bgcolor='pink'>{$k}";
                    $isrepeat = true;
                    // $i = $i + 1;
                    // $k = $k + 1;
                } 
            }   
            if($isrepeat == false){
                echo "<td>{$k}";
            } else {
                $isrepeat = false;
            }
            echo "</td>";
        }
        echo "</tr>";
    }   
?>
</table>