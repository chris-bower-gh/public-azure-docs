# Data Factory — Pipeline run counts, failure rate, and last status (last 30 days)
# CONFIGURE: Populate $dataFactories before running.
$dataFactories = @(
    # e.g. @{ sub = '00000000-0000-0000-0000-000000000000'; name = 'adf-name'; rg = 'rg-name' }
)
$outputDir = ".\output"

$lastRunTime = (Get-Date).AddDays(-30).ToString("yyyy-MM-ddTHH:mm:ssZ")
$now = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ssZ")

$results = foreach ($f in $dataFactories) {
    az account set --subscription $f.Sub | Out-Null
    $raw = az datafactory pipeline-run query-by-factory `
        --factory-name $f.Name `
        --resource-group $f.RG `
        --last-updated-after $lastRunTime `
        --last-updated-before $now `
        --output json 2>&1
    if ($raw -match '^\{') {
        $runs = ($raw | ConvertFrom-Json).value
        $runs | Group-Object pipelineName | ForEach-Object {
            $group       = $_.Group
            $total       = $group.Count
            $failed      = ($group | Where-Object { $_.status -eq 'Failed' }).Count
            $failRate    = if ($total -gt 0) { [math]::Round($failed / $total * 100, 1) } else { 0 }
            $lastRun     = $group | Sort-Object runEnd -Descending | Select-Object -First 1
            [PSCustomObject]@{
                Factory      = $f.Name
                Pipeline     = $_.Name
                RunCount     = $total
                FailedRuns   = $failed
                FailureRate  = "$failRate%"
                LastStatus   = $lastRun.status
                LastRunEnd   = $lastRun.runEnd
            }
        }
    } else {
        [PSCustomObject]@{
            Factory = $f.Name; Pipeline = "ERROR"; RunCount = 0
            FailedRuns = 0; FailureRate = "N/A"; LastStatus = ($raw | Out-String).Trim(); LastRunEnd = ""
        }
    }
}

$results | Sort-Object Factory, @{E='FailureRate'; Descending=$true}, Pipeline | Format-Table -AutoSize
$results | Export-Csv "$outputDir\data-factory-pipeline-runs.csv" -NoTypeInformation
