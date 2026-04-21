---
layout: post
title: PowerDMARC Implementation
date: 2025-01-17 08:42:47.000000000 +01:00
categories:
- How To Guides
tags:
- E-Mail
- Security
permalink: "/powerdmarc-implementation/"
excerpt: Learn how to set up PowerDMARC to enhance your email security with SPF, DKIM,
  and DMARC. Follow this step-by-step guide to improve email deliverability and protect
  against phishing attacks.
image:
  path: "/assets/wordpress-import/featured/2025/01/erstell-ein-bild-welches-thema-e-mail-security-zeigt.jpg"
  alt: PowerDMARC Implementation
---
## Introduction

Since February 2014, email providers like Gmail and Yahoo have required email senders to have DMARC set up. DMARC is like an addition or enhancement of the well-established authentication methods SPF and DKIM. Every organization should have these three technologies set up correctly to make sure their emails aren't caught by the receivers' anti-spam service. I've seen a lot of emails in my junk folder recently because senders didn't set up the technologies. So it's important to set them up not just for security reasons, but also because it'll improve deliverability.

Here's a great article that explains all three technologies:
[SPF, DKIM und DMARC jetzt!](https://www.msxfaq.de/spam/spf_dkim_dmarc_jetzt.htm)

With DMARC set up, you can get a report from the receiver that'll tell you if they got the email and if there were any issues with your SPF record or your email's DKIM hash. To look at these reports, you need a service that can do it for you. One of those services is PowerDMARC. It also gives you extra tools like a SPF, DKIM & DMARC analyzer and a managed DMARC service.

The service is not for free - check out the pricing here:
[Best DMARC Prices Starting From 8$ Monthly | DMARC Analyzer](https://powerdmarc.com/power-dmarc-pricing-policy/)

In this article, I'll walk you through setting up the service.

## Registration

Just go to the website and sign up in the upper-right corner.
[Free DMARC Analyzer | DMARC Monitoring Service](https://powerdmarc.com/)

![Screenshot](/assets/wordpress-import/2025/01/image-12-2048x919.png)

I will create a account here and will not use my Microsoft account:

![Screenshot](/assets/wordpress-import/2025/01/image-13.png)

After entering your information and creating your password you will receive a verification email - click on the link in the email and you can logon to the service.

## DMARC Configuration

The setup wizard will guide you through the setup process:

![Screenshot](/assets/wordpress-import/2025/01/image-14-2048x1151.png)

I start with a policy type of "None".

![Screenshot](/assets/wordpress-import/2025/01/image-15.png)

Because I have SPF and DKIM in place and working I go with "Strict" alignment:

![Screenshot](/assets/wordpress-import/2025/01/image-16.png)

I do not change the forensic options because I want to get insights about every issue:

![Screenshot](/assets/wordpress-import/2025/01/image-17.png)

When publishing the DMARC CNAME record I get a hint that I shall remove the old record. This is right for me because I was using Valimail before.

![Screenshot](/assets/wordpress-import/2025/01/image-18.png)

After adding the CNAME record to my DNS zone I can click on "Complete setup" and I'm done:

![Screenshot](/assets/wordpress-import/2025/01/image-19-2048x1164.png)
## Move to the DMARC Reject Policy

Now you should wait a few days to see the reports coming in to your environment. You can check the reports in the portal and if everything is fine you can move forward to the "reject policy":

![Screenshot](/assets/wordpress-import/2025/01/image-20.png)

You can also use the provided tools to check if your records are setup correctly:

![Screenshot](/assets/wordpress-import/2025/01/image-21.png)

With the MailAuth Analyzer you can check if a sent email is correctly delivered. Just copy the target address (2) and send a test email from your mailbox. Afterwards click on "refresh" (3) to check the email DMARC Compliance status (4). For more details click on "View" (5):

![Screenshot](/assets/wordpress-import/2025/01/image-23.png)

This gives you a overview of all your e-mail security measures currently in place:

![Screenshot](/assets/wordpress-import/2025/01/image-24.png)

I have still some work to do regarding enabling MTA-STS, TLS-RPT and BIMI but I will cover those topics in separate articles.

## Summary

In this article, I showed you how to set up the PowerDMARC service, which lets you implement the basic email security services SPF, DKIM, and DMARC the right way. PowerDMARC also offers assistance with advanced services like TLS-RPT, MTA-STS, and BIMI. I'll go into more detail about those technologies in future articles, so stay tuned!

If you need help implementing SPF, DKIM, and DMARC, feel free to [reach out](https://strueber-it-consulting.de/how-to-get-in-touch-with-timo-struber/). I'm happy to help!
