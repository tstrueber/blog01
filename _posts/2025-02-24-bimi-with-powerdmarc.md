---
layout: post
title: BIMI with PowerDMARC
date: 2025-02-24 22:22:39.000000000 +01:00
categories:
- How To Guides
tags:
- E-Mail
- Marketing
- PowerDMARC
permalink: "/bimi-with-powerdmarc/"
excerpt: Learn how to implement BIMI with PowerDMARC to enhance your email marketing
  strategy. This guide covers creating SVG files, obtaining VMC certificates, and
  testing your BIMI logo for better brand visibility.
image:
  path: "/assets/wordpress-import/featured/2025/02/Designer-2.png"
  alt: BIMI with PowerDMARC
---
## Introduction

BIMI, or Brand Indicators for Message Identification, is another feature that might come up when you're working as an email admin.While other features like SPF, DKIM, and [DMARC](https://modernworkplacediaries.de/powerdmarc-implementation/)help secure your domain from spoofing and email manipulation, BIMI aims to boost the chances that your customers will click on your emails, especially those marketing emails. It does this by showing a brand logo next to the email, making customers more likely to identify with your brand and open it.You can find more info about BIMI on the [Orgs website](https://bimigroup.org/).

## Create the SVG File

If you want to put the logo in the emails you send to your customers, you've got to make an SVG file that works with it. I followed this guide, and it worked like a charm. I converted my logo (a PNG file) and exported the SVG file with Inkscape. Then, I used the [Tiny SVG Converter from the BIMI group](https://bimigroup.org/svg-conversion-tools-released/).

https://www.youtube.com/watch?v=mANDP\_lSaK8

Then you just need to log in to the PowerDMARC portal, upload the SVG file, and save the BIMI record:

![Screenshot](/assets/wordpress-import/2025/02/image.png)

Go ahead and create the required CNAME record in your public DNS zone and validate the record:

![Screenshot](/assets/wordpress-import/2025/02/image-1.png)

After that, I hit "Refresh" and saw the result:

![Screenshot](/assets/wordpress-import/2025/02/image-4-2048x1223.png)
## VMC Certificate

The next step is to get a VMC certificate and upload it to PowerDMARC. The price for a certificate like this is between 850 and 1,500 euros per year. The cheapest option I found is from the PSW group, and the certificate will be issued by DigiCert:

[DigiCert VMC - EV Zertifikat - PSW GROUP](https://www.psw-group.de/verified-mark-zertifikate/digicert-verified-mark-certificate-a011361/)

If you don't have a valid VMC certificate, your BIMI logo probably won't show up anywhere. So, if you're serious about this, you'll need to get one.

## Test your BIMI Logo

If you want to test your BIMI logo, you can run a test on this site:

[BIMI Inspector - BIMI Group](https://bimigroup.org/bimi-generator/)

If you've got a VMC, your logo will pop up in one of these email services:

- Googlemail
- Yahoo
- GMX
- Web.de
- Apple Mail
- ...

You can find a full list here:

[BIMI Support by Mailbox Provider - BIMI Group](https://bimigroup.org/bimi-infographic/)

You can see that Microsoft 365 doesn't support BIMI, and I haven't found any record of it on their roadmap...

## Summary

Implementing BIMI is pretty straightforward, as long as you follow this guide. I couldn't get my logo to show up in any email service I tested, like Apple Mail, Gmail, and Yahoo. So, if you want your BIMI logo to appear, you'll need a valid VMC certificate. I checked my Gmail app, and it looks like PayPal, InnoNature, and Dr. Flex have BIMI set up and their logos are showing (see the screenshot).

![Screenshot](/assets/wordpress-import/2025/02/image-6.png)

So, if your target audience is made up of private users, then BIMI will probably have the most positive effect. But if you're a company and you want your logo to show up in other Microsoft 365 mailboxes, sorry, that's not possible right now. On the other hand, if you work with a bunch of other companies that use Google Suite, you'll get something out of it too.

So, if you're planning to boost the visibility of your marketing emails to your customers using private mail accounts, this is a solid service. If you need any help, feel free to reach out. I'm here to help!
