---
layout: post
title: Key requirements to be Copilot ready
date: 2024-04-17 08:24:36.000000000 +02:00
categories:
- How To Guides
tags:
- AI
- Artificial Intelligence
- Copilot for Microsoft 365
- Microsoft 365
- Microsoft Information Protection
permalink: "/key-requirements-to-be-copilot-ready/"
excerpt: A quick summary of the main things a company should think about before they
  start using Copilot for Microsoft 365.
image:
  path: "/assets/wordpress-import/featured/2024/04/Key-requirements-to-be-Copilot-ready.png"
  alt: Key requirements to be Copilot ready
---
## Introduction

Everyone's talking about Copilot these days. I've heard a lot of people talking about the need to have information protection in place to be ready for Copilot and let it crawl your data securely. My [blog series](https://strueber-it-consulting.de/copilot-blog-series/) started with [first impressions](https://strueber-it-consulting.de/do-i-need-copilot-for-microsoft-365/) and then I gave some practical [use cases](https://strueber-it-consulting.de/copilot-for-microsoft-365-use-cases/) with Copilot for Microsoft 365, but now I want to focus more on the technical aspects for implementing the service. In this post, I'll share the main things a company needs to do to get ready for Copilot for Microsoft 365.

## The Requirements

### Data Management

The big deal with Copilot for Microsoft 365 is that it can access your data and create responses based on your actual data, not just information from the internet. So one thing a company should think about is **data inventory**. You need to know where your data is and what kind of data you have. For this, you should get **relevant stakeholders** from different departments across your company to help you get good results. This is also a good time to think about **getting rid of old data** you don't need and investing in **training your users** in good data management practices.

### Information Protection

With a tool like Copilot for Microsoft 365 that crawls your whole company's data, your administrators are facing new challenges regarding **safeguarding sensitive information**. Not all of the technologies provided by Microsoft for securing data are also supported by Copilot. [Azure RMS](https://learn.microsoft.com/en-us/azure/information-protection/what-is-azure-rms) is fully supported, so the takeaway here is to use [Information Protection](https://learn.microsoft.com/en-us/purview/information-protection) & [Purview Message Encryption](https://learn.microsoft.com/en-us/purview/ome) to protect your data! This means you should start labeling and encrypting your sensitive data for protection. If you've got file access controls in place when encrypting data with a sensitivity label, Copilot might not be able to work with it. The label assigned to a document has to give the user VIEW & EXTRACT usage rights.

I'll go into this in more detail in a future article, so stay tuned!

### Data Loss Prevention

It's important to have data loss prevention policies in place to protect your sensitive data. One thing to think about is **preventing oversharing**. For example, sharing a file with the wrong group of users. If there's no protection on the file, the wrong group might be able to view or access it.

### Availability of Microsoft 365 Apps

You'll need to have Microsoft 365 Apps available and have a required license plan (e.g., E3 / E5 / Business Standard / Business Premium). Your update channel should be on Current Channel or the Monthly Enterprise Channel. To access the Copilot service, you'll need to unblock [WebSocket connections](https://learn.microsoft.com/en-us/copilot/microsoft-365/microsoft-365-copilot-requirements?WT.mc_id=M365-MVP-6771#network-requirements) from your users' endpoints. To leverage cross-app intelligence experiences, you'll need to enable the Copilot Teams plugin. For some Copilot features to work, your users will need OneDrive storage. For the full experience, your users will also need to use New Teams & New Outlook.

### Copilot Licenses

To get access to Copilot for Microsoft 365, you have to purchase the required licenses and assign them to your users. Microsoft has made it easier by [removing the limitation of purchasing 300 licenses](https://blogs.microsoft.com/blog/2024/01/15/bringing-the-full-power-of-copilot-to-more-people-and-businesses/) right away. Just keep in mind that there is still a difference between the Copilot licenses and the others because they're subscribed on a [yearly basis](https://www.microsoft.com/en-us/microsoft-365/enterprise/copilot-for-microsoft-365#note1) instead of a monthly. Because of the cost, it's a good idea to create a list of job roles that are likely to benefit from using Copilot and plan the test phase accordingly.

### User Adoption

If you want Copilot to be a success, you've got to get your users on board. Plan your user adoption accordingly, including mandatory training to help them get the most out of the tool.

### Measure the success

It's also a good idea to think about how you're going to measure the success of your Copilot implementation. You could do a user survey, but it might also be worth taking a look at the [dashboard](https://learn.microsoft.com/en-us/viva/insights/org-team-insights/copilot-dashboard)that Microsoft provides. This will give you a better understanding of how your users use Copilot.

## Conclusion

I think it's important to go over the points in this article to make sure you get the most out of Copilot for Microsoft 365. Besides technical things like Information Protection, which will keep your data safe, it's also important to focus on user adoption. My first experience with Copilot wasn't so good because I didn't get any useful training before I got the license. That would have been really helpful to know before I started using it.

Hope you enjoyed this article - stay tuned for more!

## Additional Links

[https://practical365.com/securing-copilot-for-microsoft-365](https://practical365.com/securing-copilot-for-microsoft-365)

[https://alberthoitingh.com/2023/11/02/copilot-and-sensitivity-labeled-documents](https://alberthoitingh.com/2023/11/02/copilot-and-sensitivity-labeled-documents)

[https://www.linkedin.com/pulse/7-key-requirements-microsoft-365-copilot-ready-elantisinc-ydkec](https://www.linkedin.com/pulse/7-key-requirements-microsoft-365-copilot-ready-elantisinc-ydkec)

[How to prepare for Microsoft 365 Copilot - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/copilot-for-microsoft-365/how-to-prepare-for-microsoft-365-copilot/ba-p/3851566)
