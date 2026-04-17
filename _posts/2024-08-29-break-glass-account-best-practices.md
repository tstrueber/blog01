---
layout: post
title: Break Glass Account Best Practices
date: 2024-08-29 08:52:55.000000000 +02:00
categories:
- How To Guides
tags:
- Conditional Access
- Entra ID
- Microsoft 365
- Security
permalink: "/break-glass-account-best-practices/"
excerpt: Learn the best practices for creating and maintaining Break Glass Accounts
  in Microsoft 365. Ensure your tenant’s security with these recommendations.
---
## Introduction

Break Glass Accounts are special accounts in a Microsoft 365 tenant that you can use if you lose access to your tenant with your regular administrative account. They're not meant for everyday admin tasks. The authentication info is stored in a safe spot. In this article, I'll go over the steps I suggest when creating and maintaining those accounts. There's no one-size-fits-all approach here. Feel free to tweak the procedures to suit your needs.

## Best Practices Creating Break Glass Accounts

### Have two break glass accounts

My first recommendation is that you have two break glass accounts. This is important because one account might be compromised or you might lose the authentication information. Having two accounts gives you a fallback plan in case of any issues.

### Have a Cloud Only Account

It's best not to sync the break glass account from your on-premise Active Directory to your tenant. This could leave the account vulnerable, because an attacker might be able to compromise your local Active Directory and then also compromise your tenant with the break glass account.

### Use the onmicrosoft domain

Just use the onmicrosoft domain for the UPN of the two break glass accounts. That way, they'll be safe in case your custom domain gets taken over and you can't log in anymore.

### Use a normal account naming convention

I've seen some people online suggesting that you use a random username with a password manager to make your account less "guessable." I don't think that's a good idea, though. It'll make your account look like it's special, which could make it more vulnerable. I recommend setting a normal-looking username for the account, following your defined naming convention.

### Create a complex password & store it safely

It's important to create a strong password for the account and keep it somewhere safe. You can create a password with up to [256 characters](https://learn.microsoft.com/en-us/entra/identity/authentication/concept-sspr-policy#microsoft-entra-password-policies) in Entra ID. I suggest creating a password this long. Be sure to store it somewhere safe. If you use a password safe solution, limit access to a small group of admins. Some password managers also have a seal you can enable to protect the account. It can only be broken with a justification for the access. If the seal is broken, the other admins will be notified.

### Protect the accounts with a strong second factor

Beginning October 15 Microsoft will tighten their security measures to [force every administrative account to use multi factor authentication](https://strueber-it-consulting.de/mfa-requirement-for-azure/). So you must protect the two break glass accounts with a second factor as well. I really like the idea of protecting your break-glass accounts with FIDO2 keys, as Merill Fernando suggests. You will get a passwordless & phishing resistant authentication solution for the accounts that [only depends on the Entra Authentication service](https://learn.microsoft.com/en-us/entra/architecture/resilience-in-credentials).

If you have not yet checked out Merill's [entra.news](https://entra.news/p/this-week-in-entra-57) page and get the newsletter now is the time to subscribe!

So start ordering two FIDO2 keys to get started - I can recommend the security keys from Yubico:
[Security Key C NFC by Yubico black](https://www.yubico.com/de/product/security-key-series/security-key-c-nfc-by-yubico-black/)

![Screenshot](/assets/wordpress-import/2024/08/image-31-660x1024.png)
### Create a group for the accounts & Protect it with Admin Units

I suggest you create a group in Entra ID that includes both break glass accounts. You'll want to exclude this group from all normal conditional access policies so you can still log in with those accounts in case you make a mistake in your daily configuration of conditional access policies and you might lock yourself out. You'll also want to protect this group from being manipulated by other admin accounts with r[estricted management administrative units](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/admin-units-restricted-management). This is still a preview feature, but I recommend it anyway. The alternative option is to exclude the break glass accounts directly in all conditional access policies.

### Secure the break glass accounts with a conditional access policy

I also recommend creating a special conditional access policy to protect the break glass accounts. You will require / enforce the following:

1. phishing resistant authentication strength
[Overview of Microsoft Entra authentication strength - Microsoft Entra ID | Microsoft Learn](https://learn.microsoft.com/en-us/entra/identity/authentication/concept-authentication-strengths)
2. set a short sign in frequency of 4 hours for example
https://learn.microsoft.com/en-us/entra/identity/conditional-access/concept-conditional-access-session#sign-in-frequency
3. disable persistent browser sessions
https://learn.microsoft.com/en-us/entra/identity/conditional-access/concept-conditional-access-session#persistent-browser-session

You should not exclude your break glass accounts from the conditional access policy that blocks device code flows to secure the accounts from this vulnerability:
[Block Device Code Authentication Requests with a CA Policy (office365itpros.com)](https://office365itpros.com/2024/05/13/device-code-authentication/)

## Best Practices Maintaining Break Glass Accounts

### Monitor Break Glass Accounts

It's a good idea to keep an eye on your break-glass accounts, the groups they're part of, and any changes to the conditional access policies. Daniel Chronlund has a great article with tips on how to monitor all this.
[Monitor your Azure AD Break Glass Accounts with Azure Monitor – Daniel Chronlund Cloud Security Blog](https://danielchronlund.com/2020/01/22/monitor-your-azure-ad-break-glass-accounts-with-azure-monitor/)

I suggest you send your Entra ID sign-in and audit logs to a Log Analytics Workspace so you can keep them for longer (180-365 days) and set up custom alert rules like Daniel talks about in his article.

### Test your break glass accounts regularly

This is a crucial step! Right after implementation, it's essential to test logging in with your break glass accounts and ensure that the monitoring is working as intended. It's also wise to test logging in with those accounts on a regular basis, just to be on the safe side. I suggest testing access every three months.

### Documentation

Once you've got everything set up, it's a good idea to create a full documentation of your break-glass accounts and the security measures you've put in place. Make sure you store this somewhere safe! You could use your password safe solution with an encrypted area, or you could put it on a USB stick and store it with your FIDO2 keys.

## Conclusion

That's all for today. I've shared my current best practices for setting up and maintaining break-glass accounts in a Microsoft 365 tenant. The Microsoft security area is always changing, so my current best practices might not be the best in the long run. That is why you should always [stay informed about changes Microsoft is implementing](https://strueber-it-consulting.de/evergreen-management/).

I hope you liked the article!
