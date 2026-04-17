---
layout: post
title: FIDO2 Authentication Break Glass Account
date: 2024-09-13 08:28:58.000000000 +02:00
categories:
- How To Guides
tags:
- Entra ID
- Identity
- MFA
- Microsoft 365
- Passwordless
- Security
permalink: "/fido2-authentication-break-glass-account/"
excerpt: Learn how to enable and enforce FIDO2 authentication for your break glass
  accounts in Microsoft 365. Follow this step-by-step guide to be prepared for an
  upcoming change from Microsoft!
---
## Introduction

Microsoft is enforcing MFA for administrative accounts accessing Azure (including Entra ID) as of 10/15/2024. I wrote about this change in a [separate article](https://strueber-it-consulting.de/mfa-requirement-for-azure/). It is important to have a second factor for your Break Glass accounts - otherwise you will no longer be able to use them. In today's article, I will walk you through the steps necessary to enable FIDO2 authentication in your tenant, enforce it for your break glass account with a conditional access policy, and register the key.

## Enable FIDO2 authentication

First, you should verify that you have already migrated from per-user MFA to authentication methods policies by clicking Manage Migration in the authentication methods policies. The status should be "migration complete":

![Screenshot](/assets/wordpress-import/2024/09/image.png)

If this is not the case, I recommend following the guideline and migrating to the new portal:
[How to migrate to the Authentication methods policy - Microsoft Entra ID | Microsoft Learn](https://learn.microsoft.com/en-us/entra/identity/authentication/how-to-authentication-methods-manage)

To enable FIDO2 authentication, click on Passkey (FIDO2):

![Screenshot](/assets/wordpress-import/2024/09/image-1.png)

Here you must enable support for this authentication method:

![Screenshot](/assets/wordpress-import/2024/09/image-2.png)

And then check the configuration and you can enable "enforce attestation". This will verify that your FIDO2 key is genuine and comes from a legitimate vendor. If you are currently trying Passkey authentication, you will have to turn off this setting as Passkey currently do not support attestation:

![Screenshot](/assets/wordpress-import/2024/09/image-3.png)
## Enforce FIDO2 Authentication

First, we need to create a new authentication strength for FIDO2:

![Screenshot](/assets/wordpress-import/2024/09/image-4.png)

Here we select FIDO2. In the advanced options we have to specify the AAGUID of the security key we are going to use:

![Screenshot](/assets/wordpress-import/2024/09/image-23.png)

The AAGUID can be obtained from the manufacturer of the security key, in my case Yubico:
[YubiKey Hardware FIDO2 AAGUIDs – Yubico](https://support.yubico.com/hc/en-us/articles/360016648959-YubiKey-Hardware-FIDO2-AAGUIDs)

Since there are two different IDs for different firmware versions and I don't know which firmware is on my stick, I add both:

![Screenshot](/assets/wordpress-import/2024/09/image-24.png)

Now you can save the authentication strength, and then create a Conditional Access Policy that forces our Break Glass account to use the newly created FIDO2 authentication strength. We will restrict it to the break glass account only:

![Screenshot](/assets/wordpress-import/2024/09/image-6.png)

This requirement will apply to all cloud applications:

![Screenshot](/assets/wordpress-import/2024/09/image-7-967x1024.png)

And in the Grant access control, choose to require the FIDO2 authentication strength you just created:

![Screenshot](/assets/wordpress-import/2024/09/image-8.png)

I also recommend setting a low sign-in frequency and disabling persistent browser sessions:

![Screenshot](/assets/wordpress-import/2024/09/image-9.png)

You can enable the policy right away because it is scoped to your break glass account only.

## Register the FIDO2 key

I recommend waiting at least 15 minutes before proceeding, as it takes this time for the FIDO2 authentication method to become available.
To register a FIDO2 key, you must log in to the account with a second factor. To accomplish this for the Break Glass account, I recommend creating a temporary access pass (TAP) for this purpose. You can add a TAP under Authentication Methods in a user's settings:

![Screenshot](/assets/wordpress-import/2024/09/image-12.png)

Copy the provided access pass because you will need it later:

![Screenshot](/assets/wordpress-import/2024/09/image-25.png)

To register the FIDO2 key, please log in with your break glass account. After entering your username, you will be asked for the temporary access pass created:

![Screenshot](/assets/wordpress-import/2024/09/image-13-1024x947.png)

You will then need to register a new factor:

![Screenshot](/assets/wordpress-import/2024/09/image-14-945x1024.png)

The wizard will guide you to create a passkey in the authenticator application, but we don't want to do that, so we select "I want to set up a different method":

![Screenshot](/assets/wordpress-import/2024/09/image-15-1024x722.png)

Then select "Passkey":

![Screenshot](/assets/wordpress-import/2024/09/image-16-1024x906.png)

Here you can see a hint that we can only use a passkey with one of the defined AAGUIDs:

![Screenshot](/assets/wordpress-import/2024/09/image-27-1024x774.png)

Next, click "Set up passkey using another device":

![Screenshot](/assets/wordpress-import/2024/09/image-26-1024x757.png)

A new window will pop up, asking you to scan the QR code with your phone, but at the bottom you will see a message telling you to insert the USB security key and touch it:

![Screenshot](/assets/wordpress-import/2024/09/image-30-872x1024.png)

Since this is the first time I am using this security key, I am forced to set a PIN for it:

![Screenshot](/assets/wordpress-import/2024/09/image-19-1024x789.png)

Now I have to touch the security key to complete the process:

![Screenshot](/assets/wordpress-import/2024/09/image-20-1024x811.png)

Finally, I have to confirm that login.microsoft.com has access to the security key:

![Screenshot](/assets/wordpress-import/2024/09/image-21-1024x765.png)

To distinguish between different passkeys, you must enter a name for the one you have just registered:

![Screenshot](/assets/wordpress-import/2024/09/image-22-1024x691.png)

The passkey is now created and can be used to log in:

![Screenshot](/assets/wordpress-import/2024/09/image-28-1024x614.png) ![Screenshot](/assets/wordpress-import/2024/09/image-29-1024x584.png)

If we check the security information afterwards, we can see the registered security key:

![Screenshot](/assets/wordpress-import/2024/09/image-39.png)

From an admin perspective, you can also see the registered security key - click on the three dots on the right to get more details:

![Screenshot](/assets/wordpress-import/2024/09/image-40.png)

Here you can see the exact model and the AA Guid - you can use it here to adjust the authentication strength we configured a few steps earlier:

![Screenshot](/assets/wordpress-import/2024/09/image-41-980x1024.png)
## Logon with the FIDO2 key

The login process is very simple. You enter your username and then choose to log in with a security key:

![Screenshot](/assets/wordpress-import/2024/09/image-31-1005x1024.png)

You will then see a popup asking you to select "Security Key" again:

![Screenshot](/assets/wordpress-import/2024/09/image-32-771x1024.png)

The wizard will then ask you to insert and touch the USB security key. Once inserted, it will start flashing:

![Screenshot](/assets/wordpress-import/2024/09/image-36-842x1024.png)

Now you need to verify with your defined PIN:

![Screenshot](/assets/wordpress-import/2024/09/image-34-1024x714.png)

And you have to touch the security key again to confirm the request:

![Screenshot](/assets/wordpress-import/2024/09/image-35-1024x757.png)

Then you are logged in! If you check the logs, you will see that the logon was successful and that the MFA requirement was met by a multi-factor device:

![Screenshot](/assets/wordpress-import/2024/09/image-37.png)

Under authentication details we can see that we used our "Break Glass Yubikey":

![Screenshot](/assets/wordpress-import/2024/09/image-38.png)
## Conclusion

In this article, I covered how to enable FIDO2 support in your tenant. Then I showed you how to create a conditional access policy that forces your break-glass account to log in with a specific FIDO2 key. Finally, I showed the process of enrolling the FIDO2 key.

We are only a month away from Microsoft enforcing the MFA requirement, so now is the time to get some FIDO2 keys and set them up for your break glass accounts!
If you need any help or have any questions, feel free to reach out to me!

I hope you enjoyed this article!
