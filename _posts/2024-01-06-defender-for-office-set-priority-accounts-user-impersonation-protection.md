---
layout: post
title: Defender for Office - Set Priority Accounts & User Impersonation Protection
date: 2024-01-06 19:39:07.000000000 +01:00
categories:
- How To Guides
tags:
- Defender for Office
- Exchange Online
- Microsoft 365
- Powershell
- Security
permalink: "/defender-for-office-set-priority-accounts-user-impersonation-protection/"
excerpt: I describe the Security Features Priority Accounts and User Impersonation
  Protection in Microsoft Defender for Office. Additionally I provide a script to
  activate the features for a specific group of users with a powershell script.
---
## Introduction

There are probably some users in your organisation that need more protection than others. The most likely targets for hackers are the most senior executives. This could be an attempt to brute-force their passwords, hopefully unsuccessful because they have Multi-Factor Authentication (MFA) enabled. It could also be an impersonation attack, where the hacker sends an email to an employee asking for sensitive information. In this case, the hacker might be using a public email service, such as Googlemail, where he has created an account with the first and last name of the company executive.

There are two technologies in the Microsoft 365 suite that you can use to better protect your executives, which I will describe in this article. Finally, I will provide a powershell script to automatically enable the features for members of a specific Entra ID group.

(I created the featured image with Bing chat that is based in Dall-E 3 with the phrase "User Impersonation Protection in Microsoft Defender for Office 365")

## Priority Account Protection

The first feature is named "priority account protection" and is available to Microsoft 365 tenants with Defender for Office Plan 2. A tag is applied to specific users who require priority account protection. In the background, these users benefit from additional heuristics that are specifically designed for company executives. According to Microsoft's data, the protection for these accounts is better suited to the mail flow patterns of company executives. If there is an incident in the defender portal and a priority account is affected, those accounts will be tagged for better visibility for your security operations center (SOC) team.

[Configure and review priority account protection in Microsoft Defender for Office 365 | Microso](https://learn.microsoft.com/en-us/microsoft-365/security/office-365-security/priority-accounts-turn-on-priority-account-protection?view=o365-worldwide)[ft Learn](https://learn.microsoft.com/en-us/microsoft-365/security/office-365-security/priority-accounts-turn-on-priority-account-protection?view=o365-worldwide)

If the feature is currently disabled, you need to enable it first. Usually, the feature is enabled by default. You can locate the configuration in the settings section of the Defender portal:

![]({{ '/assets/wordpress-import/2023/12/image-13-1024x485.png' | relative_url }})

The next step is to identify the priority accounts that require the feature's protection. The configuration can be found in the same section:

![]({{ '/assets/wordpress-import/2023/12/image-14-1024x654.png' | relative_url }})

Add the users you want to tag:

![]({{ '/assets/wordpress-import/2023/12/image-16-1024x364.png' | relative_url }})

To add the tag to the members of a specific group, use the script provided in the last section of this article. This is necessary because changes may occur to your priority accounts and it is not possible to specify a group in the web interface.

## User Impersonation Protection

The second feature for protecting priority accounts is "impersonation protection". This feature guards against attackers who attempt to impersonate employees of your organization. They may send an email from an external email service to another employee of your organization, pretending to be someone they're not.

For example, an attacker may pretend to be Alex Wilber, the CEO of the company, who has the email address **alex.wilber@contoso.com**.

Irvin Sayers, a new employee, received an email from **alex.wilber@gmail.com** requesting a transfer of funds to a specified bank account. The sender explains that he is using his personal email-account as he does not have access to his company mailbox at the moment.

However, Irvin is unsure if the email is genuinely from his CEO, Alex, as the email address and writing style seems suspicious. Anti-spam and anti-phishing technologies are not always effective in detecting impersonation attacks. However, with impersonation protection, users can be safeguarded against such attacks.

This technology is capable of identifying emails from external addresses that closely resemble those of your protected users. In the given example, the Gmail address is almost identical to Alex Wilber's company email address, except for the domain. Impersonation protection also checks for similar email addresses, such as **a.wilber@gmail.com** or **wilber@gmail.com** , to ensure user safety.

[https://learn.microsoft.com/en-us/microsoft-365/security/office-365-security/anti-phishing-policies-about?view=o365-worldwide#user-impersonation-protection](https://learn.microsoft.com/en-us/microsoft-365/security/office-365-security/anti-phishing-policies-about?view=o365-worldwide#user-impersonation-protection)

Impersonation protection can be enabled for up to 350 users in your tenant. The configuration can be found within the Defender for Office anti-phishing policies:

![]({{ '/assets/wordpress-import/2023/12/image-17-1024x697.png' | relative_url }})

Specify a display name and sender email address manually. These addresses can be internal or external:

![]({{ '/assets/wordpress-import/2023/12/image-19.png' | relative_url }}) ![]({{ '/assets/wordpress-import/2023/12/image-20.png' | relative_url }})

You cannot specify a group to automate protection for certain employees. At the end of this article, you will find a script to automate this process.

It is recommended to enable additional features to protect against impersonation attacks from an address connected to an unprotected user (the address is not specified in the user impersonation protection section). Microsoft offers a mailbox intelligence and impersonation protection feature that uses AI to distinguish between legitimate and impersonated senders, providing automatic protection. To enable this feature, both "Enable mailbox intelligence" and "Enable intelligence for impersonation protection" must be enabled:

![]({{ '/assets/wordpress-import/2023/12/image-18-1024x697.png' | relative_url }})
## Powershell Script

To protect your executives using the mentioned technologies, you would typically need to add them manually through the web interface. However, since there are changes to the list of executives from time to time, it becomes necessary to update the list. This process can become complicated, especially for larger companies with up to 200 users on each list, as it can be time-consuming to remove old users and add new ones.

I created a PowerShell script to solve a problem encountered in a recent customer project. The customer had an active directory group for top-level executives, where they added and removed users as needed. This group served as a good data source for my script.

The script should be run regularly, such as weekly, to add new users and remove old ones. To ensure protection against impersonation, it is recommended to leave the addresses of former executives on the list. This is particularly important for executives who have been with the company for a long time and are well-known. By including their addresses on the impersonation protection list, you can prevent any confusion or mistakes.

The script begins by defining variables and functions. Specify the phishing policy where you want to add users with impersonation protection. Also, specify the group that the executives are members of. Decide whether you want to only add new users with impersonation protection or remove the old ones as well.

    Connect-ExchangeOnline

    # define variables
    $phishingpolicyname = "Office365 AntiPhish Default"
    $exportfilepath = "c:\temp"
    $executivesgroup = "Executives@M365x73041155.OnMicrosoft.com"
    #set to false when you want to overwrite the impersonation users everytime you run the script
    #if set to true the script will add the current list of VIP flagged users to the impersonation users list
    #this way you continue to protect your users from impersonation of VIP users after they eventually left the company
    $addimpersonationusers = $true

    # function for setting VIP Tag to users
    function set-viptag($userlist)
    {
        foreach($user in $userlist)
        {
            set-user $user.alias -VIP $true -Confirm:$false
            $alias = $user.alias
            $displayname = $user.displayname
            write-host "Set VIP tag to user $displayname with alias $alias"
        }
    }

    # function for getting the current VIP user list and export the current list
    function get-vipuserlist
    {
        Param([switch]$export)
        $date = get-date -Format FileDateTime
        $vipusers = Get-User -IsVIP
        if($export -eq $true) { $vipusers | ConvertTo-Json | out-file "$exportfilepath\$date-vip-users.json" }
        return $vipusers
    }

We begin with the execution of the script. Firstly, I export the current list of VIP flagged users (priority accounts) and then remove the flag from the listed users. Although comparing the new and old user-lists would have been preferable, due to time constraints, I decided to remove all flags and then set them again.

    # get vip list, output and export
    get-vipuserlist -export | Sort-object DisplayName | `
        Select-Object DisplayName,WindowsEmailAddress,UserPrincipalName | `
        Format-Table -AutoSize

    # remove VIP tag from current list
    foreach($vipuser in $vipusers)
    {
        $vipuser | set-user -VIP $false -Confirm:$false
        $alias = $vipuser.alias
        $displayname = $vipuser.displayname
        Write-Host "removed VIP tag from user $displayname with alias $alias"
    }

We can now query the members of the executives group and set the VIP flag (priority account) for them. For documentation purposes, I export the current list again.

    # get new VIP user list from group
    $test = Get-DistributionGroup $executivesgroup | `
        foreach-object { Get-DistributionGroupMember $_.name }

    # set vip tags to users
    set-viptag -userlist $test

    # export the current list of vip users
    get-vipuserlist -export

To add the current list of priority accounts to the list of impersonation protection users, I export the current list and create a new list of users to add. The list must be separated by semicolons and include the display name and primary email address (in this case I use the user principal name).

    # work on user impersonation
    # export current user impersonation list
    $date = get-date -Format FileDateTime
    $TargetedUsersToProtect_Current = (Get-AntiPhishPolicy $phishingpolicyname).TargetedUsersToProtect
    $TargetedUsersToProtect_Current | Out-File "$exportfilepath\$date-impersonation-users.txt"
    $TargetedUsersToProtect_Current

    # get vip users
    $vipusers = get-vipuserlist
    # construct string from vip user list
    $TargetedUsersToProtect_New = $null
    $TargetedUsersToProtect_New = foreach ($vipuser in $vipusers) { $vipuser.DisplayName, $vipuser.UserPrincipalName -join ";" }
    $TargetedUsersToProtect_New

Finally, I must decide whether to add the users to the current list or overwrite it. If I choose to add the new list to the old one, I combine both lists and remove duplicates.

    if($addimpersonationusers -eq $true)
    {
        #add the new users to the protected users list
        $TargetedUsersToProtect_combined = $TargetedUsersToProtect_Current + $TargetedUsersToProtect_New
        #sort out duplicates
        $TargetedUsersToProtect = $TargetedUsersToProtect_combined | sort-object -Unique
        #set users to protect
        Set-AntiPhishPolicy -Identity $phishingpolicyname -TargetedUsersToProtect $TargetedUsersToProtect
        Write-Host "Adding the new users to protect from user impersonation to the curent list:"
        $TargetedUsersToProtect
    }
    else #overwrite the old list
    {
        #set users to protect
        Set-AntiPhishPolicy -Identity $phishingpolicyname -TargetedUsersToProtect $TargetedUsersToProtect_New
        Write-Host "overwriting the curent list of users to protect from user impersonation with the new one:"
        $TargetedUsersToProtect_New
    }

As always here is the link to the complete script on GitHub:

![]({{ '/assets/wordpress-import/2023/12/image-21-1024x604.png' | relative_url }})

[Script on GitHub](https://github.com/tstrueber/M365Public/blob/main/Exchange/Set-PriorityAccounts_and_Impersonation_Users.ps1)

I hope you enjoyed this article and found this script helpful!
