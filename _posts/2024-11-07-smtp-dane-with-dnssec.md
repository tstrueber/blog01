---
layout: post
title: SMTP DANE with DNSSEC
date: 2024-11-07 08:29:07.000000000 +01:00
categories:
- Architecture
tags:
- Exchange Online
- Microsoft 365
- Security
permalink: "/smtp-dane-with-dnssec/"
excerpt: Learn how to enhance your email security with SMTP DANE and DNSSEC. This
  article covers the basics, implementation steps, and benefits of using these technologies
  in Exchange Online.
---
## Introduction

A few days ago, Microsoft announced that [Inbound SMTP DANE with DNSSEC for Exchange Online is now generally available](https://techcommunity.microsoft.com/t5/exchange-team-blog/announcing-general-availability-of-inbound-smtp-dane-with-dnssec/ba-p/4281292). This technology can help make your email communication more secure using two standards:
DANE = DNS-based Authentication of Named Entities
DNSSEC = Domain Name System Security Extension
In this article, I'll give you an overview of these technologies. Once I've tested the implementation, I'll write a follow-up article to describe it.

## SMTP DANE and DNSSEC

When I'm learning about new technologies, I find it really helpful to look for good YouTube videos that explain them in an easy-to-understand way. I came across a great video from Cisco that's about five years old. It explains the technology really well and also goes over the risks of not implementing it:

https://youtu.be/l3\_12ea2npE?si=tkVVzmikKSKB14EX

**DNSSEC** is a way of making sure that DNS queries are safe from tampering. It does this by adding cryptographic signatures to the records that are queried. DNS queries are protected from tampering by adding cryptographic signatures, which verify that the queried records are correct. This method is a solid defense against attacks like DNS spoofing, so you can be sure the information is unaltered and reliable.

**DANE for SMTP** : DNSSEC is used to securely share TLS certificates for email servers via the TLSA DNS record. This means that email servers can make sure that communication over SMTP is encrypted and only connect to servers with verified certificates.

Just a heads-up: Microsoft recently announced that the technology is now available for inbound communications. Exchange Online has been able to do outbound SMTP DANE for a while now.

## Enable Inbound SMTP DANE with DNSSEC in Exchange Online

There's a great Microsoft Learn article that will walk you through enabling inbound SMTP DANE with DNSSEC in Exchange Online.

[https://learn.microsoft.com/en-us/purview/how-smtp-dane-works](https://learn.microsoft.com/en-us/purview/how-smtp-dane-works)

### Prereq 1: DNSSEC

The first thing you should look at is whether DNSSEC is turned on for your domain. You can find out what the current status is on this site:

[https://en.internet.nl](https://en.internet.nl)

Just enter your domain name and click "Test."

![Screenshot](/assets/wordpress-import/2024/10/image-2048x1058.png)

I won't go into the specifics of how to enable DNSSEC here. Once you're all done, you can move on to the next part of the guide.

### Prereq 2: Check connectors with smart host configuration

The second thing you need to do is check if you've got any connectors that are linked to your exchange org with a smart host configuration. If that's the case, the connector needs to use this syntax: tenantname.mail.protection.outlook.com.

### Change

It looks like it'll be pretty straightforward to implement. All we need to do is create some DNS records and make a few changes to the Exchange online configuration with PowerShell. You can follow Microsoft's guide or wait for my next post :-)

## Conclusion

These days, it's standard practice to have SPF, DKIM and DMARC in place. Otherwise, you'll probably end up with a bad reputation and your emails might end up in the recipient's spam folder. Another way to make your email communication more secure is to use SMTP DANE with DNSSEC. In future articles, I'll be looking at other email security technologies like MTA-STS, so keep an eye out for that!
