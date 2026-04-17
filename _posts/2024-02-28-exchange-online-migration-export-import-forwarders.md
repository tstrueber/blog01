---
layout: post
title: Exchange Online Migration - Export / Import Forwarders
date: 2024-02-28 09:33:23.000000000 +01:00
categories:
- How To Guides
tags:
- Exchange Online
- Microsoft 365
- Powershell
permalink: "/exchange-online-migration-export-import-forwarders/"
excerpt: How to export forwarders from onPrem Exchange Mailboxes prior to a migration
  to Exchange Online. Second how to import the forwarders to Exchange Online mailboxes
  after the migration.
---
## Introduction

When migrating mailboxes from Microsoft Exchange onPrem to Exchange Online, there are several factors to consider. Recently, a customer reported that the forwarding they had set up prior to the migration was no longer functioning. Upon reviewing the migrated mailbox configuration, I found that no forwarding had been set up. I conducted a test using a test mailbox, configured forwarding, and then migrated the mailbox. However, the forwarding was not migrated! I searched for an official statement from Microsoft but was unable to find any - also not on other official sites, blogs, or elsewhere. Now, I can share this information with you.

## Types of forwarding and what to consider

There are two options for configuring forwarding: specifying another user in your organization (ForwardingAddress) or specifying an SMTPaddress to forward to, which may also be an external address (ForwardingSmtpAddress). Additionally, you can configure whether to only forward a message or to also deliver it to the intended mailbox (DeliverToMailboxAndForward).

When examining the example below, it is important to handle the ForwardingAddress differently. This is because it points to a user in Active Directory in a format that cannot be used in Exchange Online.

![]({{ '/assets/wordpress-import/2024/02/image-15-1024x110.png' | relative_url }})
## Export the forwarders

First, I export all the forwarders configured in the on-premises Exchange environment. The procedure depends on how you migrate the mailboxes. I suggest exporting the forwarders for a migration batch that you start.

    $AllMailboxes = Get-Mailbox -ResultSize Unlimited
    $InternalForwarders = $AllMailboxes | where-object { $_.ForwardingAddress -ne $null }
    $GenericForwarders = $AllMailboxes | where-object { $_.ForwardingSmtpAddress -ne $null }

    write-host "Internal Forwarders: " $InternalForwarders.Count
    write-host "SMTP Address Forwarders: " $GenericForwarders.Count

    $AllForwarders = $InternalForwarders + $GenericForwarders

    $export = @()
    foreach($forwarder in $AllForwarders)
    {
        $psobject = New-Object -TypeName psobject

        $resolvedForwardingAddress = $null
        $resolvedForwardingAddress = (Get-Recipient $forwarder.ForwardingAddress).primarysmtpaddress

        $psobject | Add-Member -MemberType NoteProperty -Name PrimarySmtpAddress -Value $forwarder.PrimarySmtpAddress
        $psobject | Add-Member -MemberType NoteProperty -Name ForwardingAddress -Value $forwarder.ForwardingAddress
        $psobject | Add-Member -MemberType NoteProperty -Name resolvedForwardingAddress -Value $resolvedForwardingAddress
        $psobject | Add-Member -MemberType NoteProperty -Name ForwardingSmtpAddress -Value $forwarder.ForwardingSmtpAddress
        $psobject | Add-Member -MemberType NoteProperty -Name DeliverToMailboxAndForward -Value $forwarder.DeliverToMailboxAndForward
        $export += $psobject
    }
    $date = get-date -f yyyy-MM-dd
    $filename = $date + "_forwarders.json"
    $export `
        | Select-Object PrimarySmtpAddress,ForwardingAddress,resolvedForwardingAddress,ForwardingSmtpAddress,DeliverToMailboxAndForward -Unique `
        | ConvertTo-Json | out-file "C:\temp\$filename"

In line 16, I resolve the ForwardingAddress to the PrimarySmtpAddress of the configured user for easier importing.

## Import the forwarders

After migrating the mailboxes, I import the forwarders from the JSON file.

    Connect-ExchangeOnline

    $forwarders = `
        get-content "C:temp\forwarders.json" `
        | ConvertFrom-Json

    foreach($forwarder in $forwarders)
    {
        if($forwarder.ForwardingSmtpAddress -ne $null)
        {
            # when forwarding smtp address is set
            set-mailbox $forwarder.PrimarySmtpAddress `
                -ForwardingSmtpAddress $forwarder.ForwardingSmtpAddress `
                -DeliverToMailboxAndForward $forwarder.DeliverToMailboxAndForward
            Write-Host "Forwarding" $forwarder.PrimarySmtpAddress "to" $forwarder.ForwardingSmtpAddress "- DeliverToMailboxAndForward:" $forwarder.DeliverToMailboxAndForward
        }
        else
        {
            # when forwarding to a specific object is set
            set-mailbox $forwarder.PrimarySmtpAddress `
                -ForwardingSmtpAddress $forwarder.resolvedForwardingAddress `
                -DeliverToMailboxAndForward $forwarder.DeliverToMailboxAndForward
            Write-Host "Forwarding" $forwarder.PrimarySmtpAddress "to" $forwarder.resolvedForwardingAddress "- DeliverToMailboxAndForward:" $forwarder.DeliverToMailboxAndForward
        }
    }

## Conclusion

One important lesson I learned besides from testing planned procedures is the importance of engaging with the customer. It is impossible to know every specialty they have configured in their environment, so there may be topics that you will miss.

I hope you enjoyed this article.

As always, here are the links to the scripts on GitHub:

[M365Public/Exchange/Export-Forwarders.ps1 at main · tstrueber/M365Public (github.com)](https://github.com/tstrueber/M365Public/blob/main/Exchange/Export-Forwarders.ps1)

[M365Public/Exchange/Import-Forwarders.ps1 at main · tstrueber/M365Public (github.com)](https://github.com/tstrueber/M365Public/blob/main/Exchange/Import-Forwarders.ps1)

You might as well check out other Exchange migration related articles:

[Bulk change AD User's UPN (strueber-it-consulting.de)](https://strueber-it-consulting.de/change-ad-users-upn-prep-sync-to-azure-ad/)

[Exchange Online Configure Graph API Application Access (strueber-it-consulting.de)](https://strueber-it-consulting.de/exo-configure-graph-api-app-access/)
