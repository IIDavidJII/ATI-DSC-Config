# Set power plan to high performance
Write "******************************************************************"
Write "Set power plan to high performance"
Write "******************************************************************"
Try {
        $HighPerf = powercfg -l | %{if($_.contains("High performance")) {$_.split()[3]}}
        $CurrPlan = $(powercfg -getactivescheme).split()[3]
        if ($CurrPlan -ne $HighPerf) {powercfg -setactive $HighPerf}
        Write "Set power plan to high performance"
    } Catch {
        Write-Warning -Message "Unable to set power plan to high performance"
    }