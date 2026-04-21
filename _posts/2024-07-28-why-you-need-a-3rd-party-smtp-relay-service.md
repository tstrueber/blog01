---
layout: post
title: Why you need a 3rd Party SMTP Relay Service
date: 2024-07-28 11:24:45.000000000 +02:00
categories:
- Architecture
tags:
- E-Mail
- Exchange Online
- Microsoft 365
- SMTP
permalink: "/why-you-need-a-3rd-party-smtp-relay-service/"
excerpt: Discover why your company might need a 3rd party SMTP relay service for sending
  emails from applications. Explore options like SendGrid, MailJet, and Azure Communications
  Service to overcome Exchange Online limitations.
image:
  path: "/assets/wordpress-import/featured/2024/07/wooden-desk-with-mouse-scaled.jpg"
  alt: Why you need a 3rd Party SMTP Relay Service
---
## Introduction

If your company uses Exchange Online, you'll probably think about how to send emails from your applications at some point. This could be a multifunction printer that can send a scanned document via email or a cloud-based web service like a website that needs to send out status emails. The first thing you might think to do is send those emails over Exchange Online directly. Surely there's an easy way to connect? There are a few options out there, but they probably won't meet all your needs. SMTP relay services like SendGrid are a great solution here. In this article, I'll show you why you might need a service like that and run through the options I know.

## Exchange Online Mail Relay Options

In Exchange Online, you've got a few different ways to send emails from your apps. Microsoft breaks it down in this article:
[How to set up a multifunction device or application to send emails using Microsoft 365 or Office 365 | Microsoft Learn](https://learn.microsoft.com/en-us/exchange/mail-flow-best-practices/how-to-set-up-a-multifunction-device-or-application-to-send-email-using-microsoft-365-or-office-365)

The options are decent for certain use cases, but they all have their drawbacks.

1. SMTP client submission
This option lets you log in to a mailbox in Exchange Online using basic authentication. So, you'll need a licensed mailbox and you'll have to enable an authentication mechanism that isn't safe for a mailbox in your tenant.
2. Direct send
Your application will relay to your EOP endpoint, which is the same endpoint your MX records point to. You'll need to extend your SPF record with the IP addresses from the application where the emails are coming from. This option won't let you relay to the internet, so you'll have to look for a separate option when you need this.
3. SMTP relay
You can set up a connector in Exchange Online to accept emails from a particular IP address. Just make sure your application has a static IP address. No authentication is needed for this option.

All three options have some pretty specific limitations, like SMTP client submission only allowing 30 emails per minute, and so on.

Here is a good comparison of the three options:
[https://learn.microsoft.com/en-us/exchange/mail-flow-best-practices/how-to-set-up-a-multifunction-device-or-application-to-send-email-using-microsoft-365-or-office-365#compare-the-options](https://learn.microsoft.com/en-us/exchange/mail-flow-best-practices/how-to-set-up-a-multifunction-device-or-application-to-send-email-using-microsoft-365-or-office-365#compare-the-options)

In short, Exchange Online isn't designed for sending large numbers of emails from applications.

## Exchange Online Limitations

Microsoft is putting some limits on Exchange Online to keep it from being used for sending out bulk email or even spam. This ensures that the service is not put on a spam blacklist which makes it a more reliable and better option as a regular email service. Back in 2018, they put in place the first limitation, which was [10,000 recipients per day](https://techcommunity.microsoft.com/t5/exchange-team-blog/changes-coming-to-the-smtp-authenticated-submission-client/ba-p/607825) for emails sent with SMTP authentication. At the start of 2025, they'll be introducing a new throttling mechanism called the [External Recipient Rate (ERR) Limit](https://techcommunity.microsoft.com/t5/exchange-team-blog/exchange-online-to-introduce-external-recipient-rate-limit/ba-p/4114733). This will limit external recipients to 2,000 every 24 hours. While this probably won't impact regular users, it will force companies that are currently sending emails from applications over Exchange Online to look for alternatives.

## High Volume Email (HVE) Service

Microsoft has a new service that's currently in public preview and is better for sending out mass emails. You can get additional information here:
[Manage high volume emails for Microsoft 365 in Exchange Online Public preview | Microsoft Learn](https://learn.microsoft.com/en-us/exchange/mail-flow-best-practices/high-volume-mails-m365)

The only downside to this service is that it's mainly for internal mass communications, so it's not suitable if you want to send emails to external recipients:

![Screenshot](/assets/wordpress-import/2024/07/image-36-1024x552.png)
## 3rd Party SMTP Relay Services

If you want to send mass emails to internal and external recipients without any limits, you'll need an external SMTP relay service that's designed for that purpose. I know of three options that might be worth comparing:

  1. Twilio SendGrid
[E-Mail-API | Twilio](https://www.twilio.com/de-de/sendgrid/email-api)
  2. MailJet
[Free SMTP Server - Scalable Email Relay Service with Mailjet | Mailjet](https://www.mailjet.com/de/produkte/email-api/smtp-relay/)
  3. Azure Communications Service
[Overview of Azure Communication Services email - An Azure Communication Services concept article | Microsoft Learn](https://learn.microsoft.com/en-us/azure/communication-services/concepts/email/email-overview)

I've used SendGrid and MailJet for some customers. Azure Communications Service looks good too. SendGrid is a solid choice if you're okay with the service running in US data centers. If that's a problem, you might want to check out MailJet, which runs in EU data centers.

## Conclusion

Exchange Online is a service that's designed for users. Receiving won't be limited to today, but if you want to send mass emails, look for solutions that are specialized for that purpose. There are some options out there. If you have a service like that, it's a good idea to check if you'll be impacted by the upcoming [2025 limitation](https://techcommunity.microsoft.com/t5/exchange-team-blog/exchange-online-to-introduce-external-recipient-rate-limit/ba-p/4114733).

In the next article, I'll explain how to set up the Twilio SendGrid service. If you're interested, stay tuned!
