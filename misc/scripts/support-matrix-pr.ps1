$repoUrl = "https://api.github.com/repos/ruyisdk/support-matrix/pulls?state=closed"
$headers = @{
    "User-Agent" = "PowerShellScript"
}
$response = irm -Uri $repoUrl -Headers $headers -Method Get
$mergedPrs = $response | ? { $_.merged_at -ne $null } | sort -Property number
foreach ($pr in $mergedPrs) {
    $title = $pr.title
    $prUrl = $pr.html_url
    echo "- [$title]($prUrl)"
}