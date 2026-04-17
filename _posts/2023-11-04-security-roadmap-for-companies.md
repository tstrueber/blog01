---
layout: post
title: Security Roadmap for Companies
date: 2023-11-04 14:09:46.000000000 +01:00
categories:
- Podcast Insights
tags:
- EDR
- Entra ID
- Identity
- Microsoft 365
- Security
- Zero Trust
permalink: "/security-roadmap-for-companies/"
---
I have just been listening to a very good Practical 365 podcast series about Cyber Security:

[![Screenshot](/assets/wordpress-import/2023/10/Bildschirmfoto-2023-10-31-um-07.11.03.png)](https://spotify.link/6T26Waup8Db)

They are discussing the following topics:

1. GA of the new Teams
2. Exchange October 2023 Security Updates
3. Roundtable: Cyber Security

Especially the roundtable with Alex Weinert, VP Director of Identity Security at Microsoft is quite interesting. They talk about Storm 0558 and what Microsoft has learned about this breach. Additionally Alex Weinert mentions the recently released Microsoft Digital Defense Report that you can download here:

[Microsoft Digital Defense Report 2023 (MDDR) | Microsoft Security Insider](https://www.microsoft.com/en-us/security/security-insider/microsoft-digital-defense-report-2023)

The report gives a overview of the current attack landscape and gives recommendations how to improve the security level.

## Enable MFA

Alex shares some steps that he would recommend a customer to take to increase their security posture. The first step is quite common - enable MFA for every user. He also gives insights into the percentage of logins in Entra ID that were protected with MFA last year (2022). Only 40% of all logins in Entra ID were protected. Yes - he gets into detail that there may be some service accounts that might not be able to do MFA but nevertheless - 40% is terrifying. The digits are not even better for privileged accounts - here are only about 50% MFA protected. For me as a consultant this figure shows that my first step in any M365 project or when I get in touch with a new customer will be to talk about enabling MFA for every user.

## Separate privileged Accounts in Active Directory

Active Directory is the central identity service for most companies. There are some key principles around that can help to make this central service more secure. Most importantly you should separate your normal user accounts from your administrative accounts. Additionally you should create admin accounts following the least privilege concept. For example do not logon to an application server with a domain admin account. A domain admin account is only used for specific administrative tasks on a domain controller. For everything else you grant the needed permissions accordingly. This may sound hard in the first place but there are many ways to implement and tools to assist you.

[https://learn.microsoft.com/en-us/security/privileged-access-workstations/security-rapid-modernization-plan#separate-accounts-on-premises-ad-accounts](https://learn.microsoft.com/en-us/security/privileged-access-workstations/security-rapid-modernization-plan#separate-accounts-on-premises-ad-accounts)

Additionally you should deploy privileged access workstations for separation of the Active Directory administration tasks. On your clients and servers you should deploy unique local admin passwords -\> LAPS.

[Windows LAPS overview | Microsoft Learn](https://learn.microsoft.com/en-us/windows-server/identity/laps/laps-overview)

The above mentioned article is part of a rapid modernization plan (RAMP) from Microsoft that helps to adopt a privileged access strategy.

[Developing a privileged access strategy | Microsoft Learn](https://learn.microsoft.com/en-us/security/privileged-access-workstations/privileged-access-strategy)

Every company should make their central identity service as secure as possible.

## Eliminate Passwords

It may sound hard but when you have been dealing with the first two steps - enabling MFA for every user and the separation of privileged accounts in Active Directory the next step that Alex mentions is to eliminate passwords at all and go for a passwordless authentication deployment.

[Plan a passwordless authentication deployment in Microsoft Entra ID | Microsoft Learn](https://learn.microsoft.com/en-us/entra/identity/authentication/howto-authentication-passwordless-deployment)

I would recommend starting with implementing passwordless authentication for the administrative accounts. Normally these accounts do not have so many dependencies like regular user accounts. As a second step I would try moving forward with normal user accounts starting with priority accounts like executives.

## Implement an EDR solution

With an EDR solution you get insights about what is happening on your clients. When a company is within the Microsoft ecosystem you might choose Defender for Business for protecting your endpoints and you will get a perfect integration with your cloud identities in Entra ID and your M365 cloud apps. Because most attacks are happening on normal users - still mostly via E-Mail - you must have protection & detection functionality on your endpoints.

## Additional recommendations from the Podcast

1. use strong passwords
  - store the passwords in a password management solution
  - it is important to secure the password management solution!
  - Apply Zero trust principles
    - one example is to implement a Privileged Identity Management (PIM) solution for administrative accounts
    - Update your systems

## Conclusion

The headline of this article is "Security Roadmap for Companies" because I think that is what companies should try to set up. The mentioned Microsoft Digital Defense report is a very good starting point to get insights about the current attack landscape. The article gives as well recommendations on what a company should implement to be secure from 99% of current running attacks. It is not realistic that a company can implement all required countermeasures in a short time. It is important to understand current threats, identify the current security status of the companies environment and prioritize the countermeasures that need to be implemented. The result of this analysis should be a Security Roadmap.

If you are interested in getting insights about your environment and need help to define your Security Roadmap feel free to get in touch with me!

I hope you enjoyed this article.
