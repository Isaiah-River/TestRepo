using module RangeControl
$sections = @('SEC-260-01')

$i = 0
foreach($section in $sections)
{
    Write-Host [$i] $section
    $i++
}

$section_selected = Read-Host "Pick a Section"

Write-Host "You Chose " $sections[$section_selected]
$roster = "..\rosters\{0}.txt" -f $sections[$section_selected]
$configuration_file = "..\configs\{0}.json" -f $sections[$section_selected]



$initialize_course = Read-Host "Do you want to initialize a course (y/n)"
if($initialize_course -eq 'y')
{
    initializeCourse -configuration_file $configuration_file
}

$rangecontrol = [RangeControl]::new($configuration_file,$roster)

$initialize_nets = Read-Host "Do you want to initialize student/group networks (y/n)"
if($initialize_nets -eq 'y')
{
    $rangecontrol.InitializeUserNetworks()
}


# Remember to create your Course Gateway or the VMs deployed will not be able to get to the internet.

$deploy_vms = Read-Host "Do you want to deploy the VMs (y/n)"
if($deploy_vms -eq 'y')
{
    #This is similar to the week 1 deploy for Systems Administration I
    # Week 01 deployment
    $rangecontrol.DeployClones("vyos.f22.v2","GW")
    $rangecontrol.DeployClones("kali.2022.4.f22","kali01")
    $rangecontrol.DeployClones("rocky.f22","rocky")
}
