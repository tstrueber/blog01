---
layout: post
title: Bulk change AD User's UPN
date: 2023-08-02 21:28:57.000000000 +02:00
categories:
- How To Guides
tags:
- Active Directory
- Azure AD
- Identity
- Microsoft 365
- Powershell
permalink: "/change-ad-users-upn-prep-sync-to-azure-ad/"
excerpt: How to bulk change Active Directory user's UPN to a new one for preparation
  of a synchronization to Azure Active Directory.
---
## Introduction

In a Teams implementation project I had the pleasure to start from scratch and do a fresh setup of a new M365 Tenant for a customer. After I set up the tenant I did the basic settings including implementing security best practices. Then the onPrem Active Directory Users must be synchonized to Azure Active Directory (Azure AD) using the service Azure AD Connect.

## Why changing the UPN?

Because the customer was using a domain as the UPN for his onPrem AD users that he did not own publicly, I had to change this first. I recommended to change the users UPN to match their E-Mail Address. The new UPN will also be used for the respective synchronized Azure AD user. This is on one hand a [recommended best practice from Microsoft](https://learn.microsoft.com/en-us/windows-server/identity/ad-fs/operations/configuring-alternate-login-id#what-is-alternate-login-id). On The other hand this helps to reduce the complexity for the users. This will result in one username for the user to remember - he can use his E-Mail address to logon to his computer as well as log on to the M365 services like Teams in this project.

**E-Mail Address = onPrem AD UPN = Azure AD UPN**

## Export all AD users

To have more control over the change I export the information about the users to a CSV file first. I will then work on the data in Excel. I did intentionally not include more attributes in this export because the customer was quite small (about 100 users).

    # export all AD users
    $allusers = Get-ADUser -filter * -Properties UserPrincipalName,mail -ResultSetSize $null
    $allusers | Export-Csv -NoTypeInformation -Delimiter ";" -Encoding Unicode -Path c:\temp\allusers.csv

## Import into Excel an manipulate

You must then imported the CSV file into Excel and manipulate it as needed. I prefere creating a new Excel file and then import the CSV file into the Excel file. This works in my experience better than opening the CSV file directly:

![Screenshot](/assets/wordpress-import/2023/08/image-1024x544.png)

You then have to change the separator to match the output csv file - in my example ";" or "Semikolon" in german:

![Screenshot](/assets/wordpress-import/2023/08/image-1.png)
## Add the new UPN to the table

After that you must add a new colum to the table where you will fill in the new UPN for each user:

![Screenshot](/assets/wordpress-import/2023/08/image-2-1024x133.png)

As we will use each user's E-Mail address as the new UPN we can copy over the address where it is correctly set. On some users there is still some manual work to do. I recommend involving the customer in working on the table or at least let him check it after completion.

## Export to CSV

When you are done you must export the Excel table to a CSV file again because you need this format to import it in Powershell:

![Screenshot](/assets/wordpress-import/2023/08/image-3-1024x512.png)
## Import the CSV file to Powershell and change the UPN as set in the table

Finally you import the CSV into Powershell again and change the UPN for the users as set in the table:

    # Import from CSV file
    $importusers = Import-Csv -Path C:\temp\upn-change.csv -Delimiter ";"
    # Filtering the users that need to be changed
    $newupnusers = $importusers | Where-Object {$_.newupn -notlike ""}
    foreach ($newupnuser in $newupnusers)
    {
        $oldupn = $newupnuser.userprincipalname
        $newupn = $newupnuser.newUPN
        Get-ADUser $newupnuser.ObjectGUID | Set-ADUser -UserPrincipalName $newupn
        write-host "changed $oldupn to $newupn"
    }

## Recommendations

As a best practice I recommend starting with one line in the CSV file for testing the script. This way you can test changing the UPN for one test user. After that you must check the result with Powershell (Get-ADUser) or use the tool "Active Directory Users and Computers". This way you will most propably not break anything.

You might also try altering the Set-ADUser Command and add a "-WhatIf" at the End. This way you can do a dry-run before the command changes anything.

Please also check the script execution for errors as they are not handled in the script!
There may be an issues like:

1. a UPN conflict because the desired UPN is already set for another user
2. there may be typos in the CSV file

When working on a larger set of users to change I recommend doing some kind of export prior to changing anything. Also the implementation of additional exception handling to the script is key. But in my case the number of users to change was quite small. So the described procedure was sufficient and faster to write.

## Link to complete script on GitHub
[![Screenshot](/assets/wordpress-import/2023/08/2023-08-02-21_21_24-Window-1024x389.jpg)](https://github.com/tstrueber/M365Public/blob/main/Change-UPN.ps1)

Thank you for reading!
