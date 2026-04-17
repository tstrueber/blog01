---
layout: post
title: Storm-0558, Cryptojacking and the importance of Security Awareness Training
date: 2023-09-21 07:44:18.000000000 +02:00
categories:
- Podcast Insights
tags:
- Azure
- Exchange Online
- Podcast
- Security
- Security Awareness
permalink: "/storm-0558-cryptojacking-and-the-importance-of-security-awareness-training/"
excerpt: My key takeaways from a recent Practical 365 Podcast regarding Storm-0558,
  Cryptojacking and the importance of Security Awareness Training.
---
## The recent Practical 365 Podcast

I often listen to podcasts while driving or at the gym. Yesterday I listened to the following fantastic podcast from Practical 365 with Steve Goodman and Paul Robichaux:

[https://spotify.link/7Y7fz0yQfDb](https://spotify.link/7Y7fz0yQfDb)

Here is a brief overview of the topics covered in the podcast:

1. Storm-0558 - a recent China-orginated cyber attack against Exchange Online
2. an explanation of the current hacking thechnique Cryptojacking and why it is important to monitor your Azure environment
3. The new Outlook and why it is important in connection to Microsoft Copilot
4. The current major cyber attack in Las Vegas targeting the casino and hotel company MGM Resort

If you want to learn more about the Storm-0558 breach, you can read a detailed article on the Practical 365 blog:

https://practical365.com/storm-0558-snafus/

Microsoft recently released the results of their investigation into the security breach:

[https://msrc.microsoft.com/blog/2023/09/results-of-major-technical-investigations-for-storm-0558-key-acquisition/](https://msrc.microsoft.com/blog/2023/09/results-of-major-technical-investigations-for-storm-0558-key-acquisition/)

## My key takeaways on the security topics discussed in the podcast

For me, it was very interesting that the source of the recent Microsoft breach through Storm-0558 had it's original source in 2018. Looking at the current default login and audit log retention in Entra ID of 30 days, it seems to me very important to implement solutions that (of course in addition to analyzing them) store these logs where they are retained for a longer period. In addition, reviewing the above article by Paul Robichaux, it is an important action to extend your auditing to include the MailItemsAccessed event. In the Storm-0558 breach, one company did this and was able to detect the breach.

Another takeaway is thinking about the security threat Cryptojacking where hackers get access to your Azure subscription. After that they open a support ticket at Microsoft to remove the quotas for rolling out high performance compute resources. Finally they deploy high performance virtual machines with Nvidia GPUs and start to mine cryptucurrency. Microsoft gives some recommendations how to protect yourself from being attacked and how to monitor your environment:

[https://www.microsoft.com/en-us/security/blog/2023/07/25/cryptojacking-understanding-and-defending-against-cloud-compute-resource-abuse/](https://www.microsoft.com/en-us/security/blog/2023/07/25/cryptojacking-understanding-and-defending-against-cloud-compute-resource-abuse/)

Again, there are basic countermeasures that every administrator should consider. Separating normal and admin accounts and implementing MFA and conditional access policies. In addition, it is recommended that you limit quotas in your Azure subscription to your needs and monitor for unexpected quota increases.

In the recent Las Vegas cyber attack, hackers obtained personal information about an employee from LinkedIn. As a second step, they gained access to the employee's work account with a simple phone call to the company's help desk. This demonstrates the importance of security awareness in every organization. There are many solutions for companies to start training their employees and raising their awareness of security risks. This is not a one-time action - companies need to make this a recurring task in their security strategy and prioritize it. I am now considering SMS or phone calls as an additional phishing simulation path to follow if you want to prepare for the current attack landscape.
