<?php
$BENCHMARK_RESULTS = substr($argv[1], strrpos($argv[1], "Pfam search time:") + 18);
echo trim(substr($BENCHMARK_RESULTS, 0, strpos($BENCHMARK_RESULTS, "seconds")));
?>
