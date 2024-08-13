using module RangeControl
$sections = @('SYS-255-01','SYS-255-02','SYS-255-03')

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
    $rangecontrol.DeployClones("server.2019.gui.f22.base","ad01")
    $rangecontrol.DeployClones("windows.10.ltsc.f22.v2","wks01  ")
    $rangecontrol.DeployClones("centos7.2022.v2","dhcp01")
    $rangecontrol.DeployClones("pf2.5.2.2022.base.rs2","fw01")
    
    # Week 06 deployment
    #$rangecontrol.DeployClones("server.2019.gui.f22.base","ad-assessment")
    #$rangecontrol.DeployClones("windows.10.ltsc.f22.v2","wks-assessment")
    #$rangecontrol.DeployClones("centos7.2022.v2","dhcp-assessment")
    #$rangecontrol.DeployClones("pf2.5.2.2022.base.rs2","fw-assessment")

    # Week 07 deployment
    #$rangecontrol.DeployClones("server.2019.core.f22","fs01")

    # Week 08 deployment
    #$rangecontrol.DeployClones("centos7.2022.v2","web01")

    # Week 10 deployment
    #$rangecontrol.DeployClones("centos7.2022.v2","blog01")
    #$rangecontrol.DeployClones("centos7.2022.v2","clone01")
    #$rangecontrol.DeployClones("centos7.2022.v2","clone02")
    #$rangecontrol.DeployClones("centos7.2022.v2","clone03")
    #$rangecontrol.DeployClones("centos7.2022.v2","clone04")
}
