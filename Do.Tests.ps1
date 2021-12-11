Describe 'Smoke Tests' {
    It 'passes empty params' {
        .\Do.ps1 | Should -Not -BeNullOrEmpty
        $? | Should -Be $true
    }
    It 'passes smoke test' {
        $source = "$PSScriptRoot\tests\smoke\tasks.json"
        Write-Verbose "source:$source"
        #.\Do.ps1 az $source -Verbose  | Should -Not -BeNullOrEmpty
        $? | Should -Be $true
        #az group delete -n 'smoke-test'
    }
    It 'passes az test' {
        $source = "$PSScriptRoot\tests\az\tasks.json"

        $results = .\Do.ps1 az $source -Verbose | Should -Not -BeNullOrEmpty
        $results | Should -Not -BeLike '*error*'
        $? | Should -Be $true
    }
    #It 'passes folder update' {
    #    $source = "$PSScriptRoot\tests\smoke"

        #Copy-Item $source -Destination "tests/smoke-test-update" -Force -Recurse
        #.\Do.ps1 "tests/smoke-test-update" | Should -Not -BeNullOrEmpty
        #$? | Should -Be $true
    #}
}