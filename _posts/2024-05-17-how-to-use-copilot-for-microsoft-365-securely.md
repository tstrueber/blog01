---
layout: post
title: How to use Copilot for Microsoft 365 securely
date: 2024-05-17 14:51:08.000000000 +02:00
categories:
- How To Guides
tags:
- AI
- Artificial Intelligence
- Copilot for Microsoft 365
- Microsoft 365
- Microsoft Information Protection
permalink: "/how-to-use-copilot-for-microsoft-365-securely/"
excerpt: Details about the risk of implementing Copilot for Microsoft 365 without
  implementing sufficient data security controls in advance.
image:
  path: "/assets/wordpress-import/featured/2024/05/securing-copilot.jpeg"
  alt: How to use Copilot for Microsoft 365 securely
---
## Introduction

In almost every discussion about Copilot, people bring up the possibility that Copilot for Microsoft 365 might show users content that isn't meant for them. This could be Copilot giving an answer that includes confidential information, like referencing a file so the user can access the document. In today's article, I'll dive into the potential risks of using Copilot without implementing sufficient data security controls in advance. Also, I'll give you some tips on how to reduce the chance of confidential data being shown and how you can securely use Copilot for Microsoft 365 in your company.
This article is part of my [Copilot blog series](https://modernworkplacediaries.de/copilot-blog-series/). You can check out the other articles as well if you like!

## What is oversharing?

The term "oversharing" is used a lot in these discussions. It basically means that someone is sharing information that they didn't intend to share, which allows the receiver to access more information than they were supposed to.

I'll give you two examples:

The **first example** is when someone wants to share a file they've saved in OneDrive, but they accidentally share the folder where the file is located. This might not be a problem right now, but the person sharing the folder might add confidential documents that you'll also have access to.

sharing of the file

![Screenshot](/assets/wordpress-import/2024/05/image-7-1024x518.png)

sharing of the whole folder

![Screenshot](/assets/wordpress-import/2024/05/image-8-1024x508.png)

The **second example** is a confidential document that someone sent via email. This email can be forwarded or the document saved in a SharePoint site where more users have access than initially intended by the sender.

In both examples, users have access to confidential information that wasn't meant for them. This is oversharing, and we want to avoid it. Oversharing gets even more complex and critical when your users are using sharing links.

If you want to learn more about oversharing, check out [this article](https://www.orchestry.com/insight/copilot-readiness-what-is-oversharing-in-microsoft-365). It goes into the topic in more detail.

## What has Copilot to do with oversharing?

You might be wondering what Copilot has to do with the oversharing issue. Check out my article that explains [how Copilot for Microsoft 365 is working](https://modernworkplacediaries.de/copilot-for-microsoft-365/) to learn more. With oversharing, Copilot might create chapters of a word document or provide answers based on documents it has indexed. If you take the two oversharing examples above, it might take information from a shared folder you should not have access to and show you confidential information. This isn't a problem with Copilot for Microsoft 365. It's more a problem with bad or none data protection.

## How to avoid those issues?

To avoid any issues with Copilot for Microsoft 365 giving you confidential information that wasn't meant for you, there are a few things you can do.

**Define a more restricted sharing type in Sharepoint / OneDrive**
The default "anyone with a link" setting inevitably leads to oversharing because users won't [choose a more secure option](https://learn.microsoft.com/en-us/sharepoint/turn-external-sharing-on-or-off#file-and-folder-links). In the below Screenshot you see the default configuration. My recommendation is to set this to "Specific people (only the people the user specifies)":

![Screenshot](/assets/wordpress-import/2024/05/image-6.png)

**Implement Microsoft Information Protection (Azure RMS) to secure information**

![Screenshot](/assets/wordpress-import/2024/05/image-9.png)

Use sensitivity labels and data encryption to label and encrypt sensitive data with [Microsoft Information Protection](https://learn.microsoft.com/en-us/purview/information-protection). For protecting E-Mail content use [Purview Message Encryption](https://learn.microsoft.com/en-us/purview/ome). The recommendation here is to use [Azure RMS](https://learn.microsoft.com/en-us/azure/information-protection/what-is-azure-rms) because it is fully compatible with Copilot for Microsoft 365.

**Train your users to be cautious when sharing information**

This is probably even more important than the above two technical steps. It's really important that your users know about the risks of confidential information leaking and know how to protect the organization from an incident.

![Screenshot](/assets/wordpress-import/2024/05/big_data14-edited-scaled.jpg)
## Conclusion

If you're planning to use Copilot for Microsoft 365, it's a good idea to check your current Microsoft 365 tenant configuration regarding SharePoint / OneDrive sharing defaults and additionally think about implementing Information Protection (Azure RMS based). This will reduce the risk of a data protection incident a lot. Not only because you're planning to use Copilot for Microsoft 365 - it's always a good idea to think about implementing Information Protection.

I hope you enjoyed this article!
