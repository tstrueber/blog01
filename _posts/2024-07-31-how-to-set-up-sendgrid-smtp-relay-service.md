---
layout: post
title: How to set up SendGrid SMTP Relay Service
date: 2024-07-31 08:03:38.000000000 +02:00
categories:
- How To Guides
tags:
- E-Mail
- Exchange Online
permalink: "/how-to-set-up-sendgrid-smtp-relay-service/"
excerpt: This guide will show how to set up the SendGrid SMTP Relay Service. I'll
  walk you through everything from subscribing to the service to configuring DNS records
  and creating an API key.
image:
  path: "/assets/wordpress-import/featured/2024/07/sg-twilio-lockup.jpg"
  alt: How to set up SendGrid SMTP Relay Service
---
## Introduction

In my last article, I talked about [why you need a 3rd party SMTP relay service](https://strueber-it-consulting.de/why-you-need-a-3rd-party-smtp-relay-service/). Today, I want to go over how to set up the SendGrid SMTP Relay Service. There are [other options](https://strueber-it-consulting.de/why-you-need-a-3rd-party-smtp-relay-service/#3rd_Party_SMTP_Relay_Services) out there, but the process should be pretty similar to what I'm about to describe. First, you have to subscribe to the service. Then, you have to set up some DNS records for your custom domain. Finally, you need to know how to access the service.

## Subscribe to the SendGrid service

When I'm writing this article, there are a few different plans that Twilio SendGrid has that could be a good fit for you:

![Screenshot](/assets/wordpress-import/2024/07/image-37-1024x435.png)

[Pricing and Plans | SendGrid](https://sendgrid.com/en-us/pricing)

If you already have an Azure subscription, you can easily book the service from Azure and the costs will be charged to your Azure subscription. If you start with the free service, you don't have to enter any credit card information. I recently tried to register for the free service on the website directly, but that didn't work. I was able to register from Azure, though.

You can find SendGrid in the Azure marketplace:

![Screenshot](/assets/wordpress-import/2024/07/image-38-1024x419.png)

You'll need to enter the required info, choose a subscription and a resource group, and then you can create the service:

![Screenshot](/assets/wordpress-import/2024/07/image-39-1024x892.png)

You can find your new subscription in the Azure portal. Just click on "Open SaaS Account on publisher's site" it to get started:

![Screenshot](/assets/wordpress-import/2024/07/image-40-1024x450.png)
## Setup your first domain

Once you've created your domain, you'll need to authorize it. To send from any address in your domain, you'll need to authenticate the whole thing. I'll just go over this method in more detail:

![Screenshot](/assets/wordpress-import/2024/07/image-41-1024x704.png)

Just enter your DNS provider, and then you can click "Next."

![Screenshot](/assets/wordpress-import/2024/07/image-42-1024x686.png)

Just enter your domain name and then click "Next."

![Screenshot](/assets/wordpress-import/2024/07/image-43-1024x722.png)

Next, you'll see a list of all the DNS records you'll need to set up to use the service.

![Screenshot](/assets/wordpress-import/2024/07/image-44-1024x656.png)

Once you've got all the DNS records set up, you can also create a free Valimail account to get insights into your DMARC results.

## Create your API key

Once you've verified your domain, you'll need to create an API key to authenticate and send emails through the service.

![Screenshot](/assets/wordpress-import/2024/07/image-45-1024x685.png)

You'll need to set the permissions for the new API.

![Screenshot](/assets/wordpress-import/2024/07/image-46-1024x695.png) ![Screenshot](/assets/wordpress-import/2024/07/image-47-1024x698.png)

Once you've created your API key, you can only copy it once. Be sure to store it somewhere safe, like in a password manager.

## Relay E-Mails via the SendGrid service

You've got two ways to send emails through SendGrid. I'll show you both options here:

![Screenshot](/assets/wordpress-import/2024/07/image-48-1024x650.png)
### Web API

You can get guides to send emails via SendGrid from a variety of web services:

![Screenshot](/assets/wordpress-import/2024/07/image-49-1024x739.png)

Here is a example PowerShell Function I used to send a Test E-Mail:

[scriptinglibrary/Blog/PowerShell/Send-EmailWithSendGrid.ps1 at master · PaoloFrigo/scriptinglibrary · GitHub](https://github.com/PaoloFrigo/scriptinglibrary/blob/master/Blog/PowerShell/Send-EmailWithSendGrid.ps1)

### SMTP Relay

The other option is to send out the E-Mail via SMTP:

![Screenshot](/assets/wordpress-import/2024/07/image-50-1024x834.png)

You can access the service via smtp.sendgrid.net. Just authenticate with the username "apikey" and the API key you created in a recent step.

## Conclusion

In this guide, I've shown you how to subscribe to the Twilio SendGrid Service, set up your first custom domain, and send emails via the Web API or SMTP. You can try this service for free as long as you don't want to send more than 100 email a day.

Hope you liked the article!
