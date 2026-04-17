---
layout: post
title: Passkeys in Microsoft Authenticator
date: 2024-08-07 08:48:49.000000000 +02:00
categories:
- How To Guides
tags:
- Entra ID
- Passwordless
- Phishing Resistant
- Security
permalink: "/passkeys-in-microsoft-authenticator/"
excerpt: Learn how to enhance your security with Passkeys in Microsoft Authenticator.
  This guide covers the setup process, benefits, and how to use passkeys for phishing-resistant
  authentication. Perfect for IT professionals looking to improve their security measures.
---
## Introduction

I am consistently interested in exploring new solutions to enhance the security of your work environment. I have been following developments in the FIDO2 standard for some time, but I have not yet had the opportunity to test it. All the time you required a physical FIDO2 device like a [yubikey](https://www.yubico.com/solutions/passwordless/) which I don't have. However, [Passkey](https://fidoalliance.org/how-fido-works/) is a new technology that allows users to securely store their private keys on their mobile phones. Microsoft has incorporated this new technology into its products as of [May 2024](https://techcommunity.microsoft.com/t5/microsoft-entra-blog/public-preview-expanding-passkey-support-in-microsoft-entra-id/ba-p/4062702), and I have now had the opportunity to test it. This guide will provide an overview of why phishing-resistant authentication is important and of the options currently available. It will then guide you through the process of enabling the authentication method in Entra ID, registering your device, and authenticating on a website with a passkey in Microsoft Authenticator.

## Phishing Resistant Authentication

There's a difference between passwordless and phishing-resistant. You might enable phone sign-on in your Microsoft Authenticator app to sign in with a number matching MFA on your mobile phone, but this isn't safe. Your token can be abused by an attacker. The best solution is to go passwordless **and** phishing-resistant. At the time of writing, there are the following options in Entra ID:

- Windows Hello for Business
- Platform Credential for macOS
- Certificate-based Authentication (CBA)
- FIDO2 Security keys
- Microsoft Authenticator Passkey (Preview)

Each option has some prerequisites, like having a Windows device for Hello for Business or purchasing a dedicated FIDO2 security key. Since you only need a smartphone with the Microsoft Authenticator Passkey (which is still in preview) to use it, I think it's worth testing out.

Here's a great comparison of the phishing-resistant MFA basics:
[Phishing-resistant MFA basics. This blog explains the basics of… | by Derk van der Woude | Jul, 2024 | Medium](https://derkvanderwoude.medium.com/phishing-resistant-mfa-basics-cb59d41406f3)

I've also found a pretty detailed guide that explains how an AiTM attack works and how to protect yourself with Microsoft technology:
[Protect against AiTM/ MFA phishing attacks using Microsoft technology (jeffreyappel.nl)](https://jeffreyappel.nl/protect-against-aitm-mfa-phishing-attacks-using-microsoft-technology/)

## Passkey in Microsoft Authenticator

When you use a passkey in Microsoft Authenticator, your FIDO2 security key is stored on your mobile device for authentication.
Here's a detailed overview of the process:
https://learn.microsoft.com/en-us/entra/identity/authentication/concept-authentication-passwordless#passkeys-fido2

You need a "physical" connection between your device (Windows or Mac) and your mobile device that's done via Bluetooth. So one important thing you need for this process is that your mobile phone can set up a Bluetooth connection to your device.
[List of Requirements](https://learn.microsoft.com/en-us/entra/identity/authentication/how-to-enable-authenticator-passkey#requirements)

![]({{ '/assets/wordpress-import/2024/08/image-22.png' | relative_url }})

from [Microsoft](https://learn.microsoft.com/en-us/entra/identity/authentication/concept-authentication-passwordless#passkeys-fido2)

## Enable Passkey Support in Entra ID

Before you get started, you'll need to move your authentication methods from the legacy per user MFA portal to the new authentication portal.
[How to migrate to the Authentication methods policy - Microsoft Entra ID | Microsoft Learn](https://learn.microsoft.com/en-us/entra/identity/authentication/how-to-authentication-methods-manage)

First, you'll need to enable and configure the authentication method:

![]({{ '/assets/wordpress-import/2024/08/image-1024x585.png' | relative_url }})

Enable Passkey:

![]({{ '/assets/wordpress-import/2024/08/image-1-1024x480.png' | relative_url }})

Configure the method as shown here:

![]({{ '/assets/wordpress-import/2024/08/image-3-1024x669.png' | relative_url }})

The Authenticator App GUIDs (AAGUID) are for the Android or iOS App:

  - **Authenticator for Android:** &nbsp;de1e552d-db1d-4423-a619-566b625cdc84
  - **Authenticator for iOS:** &nbsp;90a3ccdf-635c-4729-a248-9b709135078f

## Passkey registration

I've already set up the Authenticator App for MFA for my user. I just need to add an additional account to the authenticator app.

![]({{ '/assets/wordpress-import/2024/08/image-6-1024x1024.png' | relative_url }}) ![]({{ '/assets/wordpress-import/2024/08/image-7-1024x1024.png' | relative_url }})

Next, you'll need to log in to your account using your username and password:

![]({{ '/assets/wordpress-import/2024/08/image-8-1024x1024.png' | relative_url }})

Since I've enabled MFA for this user, I get a pop-up asking me to authenticate the process by entering a number. This will happen on the device. Finally, the authenticator app asks me to set the app as my preferred app for passkeys (in German, "Hauptschlüssel"):

![]({{ '/assets/wordpress-import/2024/08/image-9-1024x1024.png' | relative_url }}) ![]({{ '/assets/wordpress-import/2024/08/image-10-1024x1024.png' | relative_url }})

Once you've got everything set up the way it should be, you'll see a confirmation and the final window will show you that the Passkey (Hauptschlüssel) is enabled:

![]({{ '/assets/wordpress-import/2024/08/image-11-1024x1024.png' | relative_url }}) ![]({{ '/assets/wordpress-import/2024/08/image-12-1024x1024.png' | relative_url }})

After checking the account in the Microsoft Authenticator app, I can see that the passkey (hash key) is activated:

![]({{ '/assets/wordpress-import/2024/08/image-13-1024x1024.png' | relative_url }}) ![]({{ '/assets/wordpress-import/2024/08/image-14-1024x1024.png' | relative_url }})

You're all set to authenticate your account with the passkey!

## Authenticate with Passkey

Before you get started, make sure that Bluetooth is enabled on your mobile phone as well as on your device and that your mobile phone has an active internet connection. To authenticate with Passkey, just browse to the intended site. In my case, it is https://admin.microsoft.com. I've selected my account here:

![]({{ '/assets/wordpress-import/2024/08/image-15-1024x768.png' | relative_url }})

Now I have to choose an "other way to sign in":

![]({{ '/assets/wordpress-import/2024/08/image-16-1024x768.png' | relative_url }})

I can choose between my recently configured Passkey or the Authenticator app. I go with "security key," which is basically Passkey:

![]({{ '/assets/wordpress-import/2024/08/image-17-1024x768.png' | relative_url }})

You'll see a pop-up asking where you want to take the passkey from. In this case, you can choose to take it from your phone:

![]({{ '/assets/wordpress-import/2024/08/image-18-1024x768.png' | relative_url }})

Next, you'll need to open the camera app on your phone and scan the QR code shown:

![]({{ '/assets/wordpress-import/2024/08/image-19-1024x768.png' | relative_url }})

On your phone you must tap on "logon with passkey":

![]({{ '/assets/wordpress-import/2024/08/image-20-1024x768.png' | relative_url }})

Then you'll be redirected to the Microsoft Authenticator app, where you can authorize the authentication:

![]({{ '/assets/wordpress-import/2024/08/image-21-1024x768.png' | relative_url }})

Once you've done that, you just have to authorize the process with Face ID and you're all set :-)

## Conclusion

I think Microsoft Authenticator passkeys will be available globally soon, so it's a great time to give it a try! It's a secure, free option to make your administrator authentication more secure (free as long as they have a smartphone). Every company should start their passwordless journey and focus on authentication methods that are phishing resistant. Phishing is still one of the most used attacks.

Hope you liked the article!
