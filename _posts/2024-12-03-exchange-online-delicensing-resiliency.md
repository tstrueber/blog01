---
layout: post
title: Exchange Online Delicensing Resiliency
date: 2024-12-03 09:38:46.000000000 +01:00
categories:
- News
tags:
- Exchange Online
- Microsoft 365
- Powershell
permalink: "/exchange-online-delicensing-resiliency/"
excerpt: Learn about Exchange Online Delicensing Resiliency, a new feature by Microsoft
  that helps prevent accidental mailbox deletions by introducing a 30-day grace period.
---
## Introduction

In my work as a modern workplace consultant, I've seen a lot of cases where companies accidentally lose important data because they mess up their licensing. One recurring issue involves delicensing Exchange Online mailboxes. A customer might intentionally remove a license from a user by unassigning it and making it available for a new user. This is a procedure I have often seen because for example the old user did not log on in the last 90 days. With this procedure a company can reduce the number of licenses it needs and therefore reduce costs. Another example is that a license is accidentially removed during routine changes or restructuring, only to discover later that the mailbox — and its data — was permanently deleted. These losses can be disruptive and costly, not to mention the frustration of trying to recover what’s gone.

Fortunately, Microsoft has taken steps to address this risk. In a [recent announcement](https://techcommunity.microsoft.com/blog/exchange/introducing-exchange-online-delicensing-resiliency-to-protect-against-unintended/4082759), they introduced _Exchange Online Delicensing Resiliency_, a feature designed to protect organizations from unintended mailbox deletions due to delicensing.

## What Is Exchange Online Delicensing Resiliency?
This resiliency feature introduces a grace period that temporarily preserves the mailbox completely after a license is removed. When a user’s mailbox is delicensed, instead of being soft deleted immediately, it stays active for 30 days. During this time, administrators have the opportunity to reassign the license and the mailbox stays active even after the new 30-day grace period is over. After the new grace period the mailbox will we soft deleted and the default grace period of 30 days starts. In the soft deleted state the user cannot access the mailbox anymore. E-mails to the mailbox will result in non-delivery reports (NDRs). By reassigning the license during this period the mailbox becomes active again. When the default 30-day grace period expires the mailbox gets deleted and cannot be recovered.

### Default behavior
![Screenshot](/assets/wordpress-import/2024/12/Delic01.jpg)

Illustration by Microsoft

### Behavior with Exchange Online Delicensing Resiliency feature enabled
![Screenshot](/assets/wordpress-import/2024/12/Delic02.jpg)

Illustration by Microsoft

The primary goal of this feature is to provide an additional safety net for organizations, minimizing the potential for accidental data deletion. This is especially useful for businesses that frequently manage license assignments, such as during mergers, acquisitions, or seasonal workforce adjustments.

## How to enable the feature

Microsoft has released a guide how to enable the feature:

[https://learn.microsoft.com/en-us/Exchange/recipients-in-exchange-online/manage-user-mailboxes/exchange-online-delicensing-resiliency](https://learn.microsoft.com/en-us/Exchange/recipients-in-exchange-online/manage-user-mailboxes/exchange-online-delicensing-resiliency)

The first thing to note is that this feature requires more than 10.000 non-trial licenses in your tenant. Unfortunately this is a major hurdle.
If your tenant is eligible, you can activate the feature with a simple one-liner in the Exchange Powershell:

    Set-OrganizationConfig -DelayedDelicensingEnabled:$true

After that you should look into admin notifications and you might as well enable user email notifications. Both features are enabled automatically but you might want to opt out. The above mentioned article gives good examples about the processes.

## Why This Matters
For IT professionals managing Exchange Online, this feature is a game-changer. It reduces the risk of accidental data loss and provides a buffer against human error—an all-too-common factor in IT operations. Additionally, the feature aligns with Microsoft’s broader strategy of enhancing data resiliency across its services.

## Best Practices for Managing Delicensing Resiliency
**Establish Clear License Management Policies**
Ensure that your IT team understands the workflows for assigning and removing licenses, and train them on the implications of delicensing.

**Monitor Suspended Mailboxes**
Use the admin tools or write a powershell script to regularly check for mailboxes in the suspension state and address any issues promptly.

**Document Procedures**
Maintain clear documentation for managing license changes to reduce the likelihood of errors.

## Closing Thoughts
As someone who has seen firsthand the consequences of accidental mailbox deletions, I believe Exchange Online Delicensing Resiliency is a welcome addition to Microsoft’s toolkit. It’s a reminder that while technology continues to advance, the human element in IT operations still requires safeguards. This feature offers peace of mind and a practical solution to a common problem.

Have you had challenges with delicensing mailboxes? I’d love to hear your thoughts or stories in the comments below!
