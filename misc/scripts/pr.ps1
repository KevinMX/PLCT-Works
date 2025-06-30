param (
    [Parameter(Mandatory=$true)]
    [string]$RepoUrl
)

# Extract owner and repo-name from the input URL
if ($RepoUrl -match "github.com/([^/]+)/([^/]+)") {
    $owner = $matches[1]
    $repoName = $matches[2]
} else {
    Write-Error "Invalid GitHub repository URL format. Please use the format: https://github.com/owner/repo-name"
    exit
}

# Construct the GitHub API URL for pull requests
$apiUrl = "https://api.github.com/repos/$owner/$repoName/pulls?state=closed"

$headers = @{
    "User-Agent" = "PowerShellScript"
}

try {
    # Make the API request
    $response = Invoke-RestMethod -Uri $apiUrl -Headers $headers -Method Get

    # Filter for merged PRs and sort by number
    $mergedPrs = $response | Where-Object { $_.merged_at -ne $null } | Sort-Object -Property number

    if ($mergedPrs.Count -gt 0) {
        Write-Host "--- Merged Pull Requests for $owner/$repoName ---"
        foreach ($pr in $mergedPrs) {
            $title = $pr.title
            $prUrl = $pr.html_url
            Write-Host "- [$title]($prUrl)"
        }
    } else {
        Write-Host "No merged Pull Requests found for $owner/$repoName."
    }
}
catch {
    Write-Error "An error occurred while fetching data from GitHub. Please check the repository URL and your internet connection."
    Write-Error $_.Exception.Message
}