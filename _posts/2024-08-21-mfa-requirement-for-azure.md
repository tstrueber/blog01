---
layout: post
title: MFA Requirement for Azure
date: 2024-08-21 07:50:54.000000000 +02:00
categories:
- News
tags:
- Entra ID
- Identity
- Microsoft 365
- Powershell
- Security
permalink: "/mfa-requirement-for-azure/"
excerpt: Learn about the upcoming mandatory multi-factor authentication (MFA) for
  Azure admins starting October 15, 2024. Ensure your admin accounts are secure and
  compliant with Microsoft’s new security measures.
image:
  path: "/assets/wordpress-import/featured/2024/08/ed-hardie-RMIsZlv8qv4-unsplash-scaled.jpg"
  alt: MFA Requirement for Azure
---
## The Change

In today's article, we'll be taking a look at a new change that Microsoft is rolling out:
[MC862873 - Take action: Enable multifactor authentication for your tenant before October 15, 2024 | Microsoft 365 Message Center Archive (merill.net)](https://mc.merill.net/message/MC862873)

After October 15, 2024, Microsoft will require admins to use multifactor authentication when signing in to the Azure Portal, the Entra Admin Center, or the Microsoft Intune admin center. This change won't affect normal user accounts that don't have any privileged roles.

In addition there is a techcommunity article getting into more detail about the change:
[Update on MFA requirements for Azure sign-in - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/update-on-mfa-requirements-for-azure-sign-in/ba-p/4177584?WT.mc_id=M365-MVP-9501)

![Screenshot](/assets/wordpress-import/2024/08/image-30-1024x1024.png)

[Image by storyset on Freepik](https://www.freepik.com/free-vector/two-factor-authentication-concept-illustration_12892978.htm#fromView=search&page=1&position=1&uuid=782f7a3a-9cd8-4bcf-9b29-d592f6821eb4)

## What to do?

If you haven't already, now's the time to make sure you're securing your admins when they log in to admin portals. It's a good idea to roll out MFA for the affected admin accounts. It's also a good idea to check your "break glass" accounts. Most of them are probably currently secured with a long, complex password, and there are some monitoring techniques in place to keep an eye on them. These accounts must to be updated to be secured with MFA. I'd suggest enabling passwordless authentication with a FIDO2 key like the [Yubikey](https://www.yubico.com/de/product/security-key-series/security-key-c-nfc-by-yubico-black/) right away. You might as well use passkeys if you don't mind that they're still in preview, but I wouldn't recommend them yet. You can keep the Yubikey in a safe place like your company's safe.

If you are a big organization and you might not be able to prepare yourself for the change you can [postpone the change](https://aka.ms/managemfaforazure).

If you're wondering who might be affected by the change, there's a [Powershell module](https://www.powershellgallery.com/packages/MSIdentityTools/2.0.68) that helps you identify users with the cmdlet Export-MsIdAzureMfaReport.

## You did not hear about the change?

Then now is the time to implement a process in your organization to [stay up to date](https://strueber-it-consulting.de/evergreen-management/) about the changes Microsoft is rolling out. This might be implementing a process to sync message center notifications into a planner board and deal with them in a structured way or to follow for example [entra.news](https://entra.news/p/this-week-in-entra-57).

## Conclusion

It's still a big worry that admin accounts aren't protected with MFA. Microsoft said that [99.9% of the accounts that got hacked weren't protected with MFA](https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/microsoft-will-require-mfa-for-all-azure-users/ba-p/4140391). Now is the time to step up your security!

If you have any questions about this change or need help, please don't hesitate to [reach out to me](https://strueber-it-consulting.de/how-to-get-in-touch-with-timo-struber/)!
