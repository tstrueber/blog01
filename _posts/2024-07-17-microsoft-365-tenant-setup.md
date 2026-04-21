---
layout: post
title: Microsoft 365 Tenant First Steps
date: 2024-07-17 07:47:18.000000000 +02:00
categories:
- How To Guides
tags:
- Identity
- Microsoft 365
- Security
permalink: "/microsoft-365-tenant-setup/"
excerpt: Learn the essential first steps to set up a new Microsoft 365 tenant, including
  creating separate admin accounts, enabling MFA, and adding a custom domain. Ensure
  a secure and efficient IT environment with these best practices.
image:
  path: "/assets/wordpress-import/featured/2024/07/Flat-vector-illustration-of-stock-trader-working-on-computer-1-scaled.jpg"
  alt: Microsoft 365 Tenant First Steps
---
## Introduction

This is the second in the series on setting up a new Microsoft 365 tenant. In the [first article](https://modernworkplacediaries.de/create-a-microsoft-365-tenant/), I showed you how to create the tenant. This article will walk you through the first steps you need to take in a brand new tenant. First, we'll set up a separate admin account. Then, we'll get MFA up and running. Finally, we'll add our custom domain to the tenant.

## Why you should use separate administrative Accounts

It's really important to keep admin and normal user accounts separate when you're managing IT systems and networks. Here are some reasons why:

![created by pch.vector, downloaded from freepik.com](/assets/wordpress-import/2024/07/Engineer-working-with-server-equipment-and-switchboard-1024x890.jpg)
### 1. **Enhanced Security**

- **Least Privilege Principle** : Normal user accounts have limited privileges, reducing the risk of accidental or intentional changes that could affect the system's stability or security. Administrative accounts have full control, so restricting their use minimizes potential damage.
- **Minimized Attack Surface** : By limiting the use of administrative accounts, the potential entry points for attackers are reduced. Administrative accounts are prime targets for attackers because of their elevated privileges.

### 2. **Prevention of Accidental Changes**

- **Avoiding Unintended Modifications** : Normal users cannot make changes that could disrupt system operations or compromise security. This separation ensures that critical settings are only modified intentionally by authorized personnel.

### 3. **Improved Accountability and Monitoring**

- **Traceability** : Actions taken by administrative accounts are often logged and monitored more rigorously. This helps in tracking changes and identifying the source of issues or breaches.
- **Segregation of Duties** : Different users have different roles and responsibilities. By separating account types, it becomes easier to enforce policies and ensure that tasks are performed by the appropriate personnel. You should enforce more strict Conditional Access Policies to administrative accounts.

### 4. **Mitigation of Malware and Phishing Risks**

- **Reduced Impact of Compromised Accounts** : If a normal user account is compromised, the attacker has limited access and cannot easily escalate privileges or cause widespread harm. Conversely, compromising an administrative account would have severe consequences.
- **Controlled Access to Critical Systems** : Malware or phishing attacks often aim to gain administrative access. By limiting the number of accounts with such access, the risk is significantly reduced.

### 5. **Compliance with Regulations and Best Practices**

- **Adherence to Standards** : Many industry standards and regulations (e.g., ISO/IEC 27001, PCI DSS) require or recommend the separation of administrative and normal user accounts to ensure a secure operating environment.
- **Best Practices** : Following best practices in cybersecurity, such as those [recommended by NIST](https://csf.tools/reference/critical-security-controls/version-7-1/csc-4/csc-4-3/) (National Institute of Standards and Technology), includes separating user roles and privileges to enhance overall security.

### 6. **Operational Efficiency**

- **Streamlined Access Management** : By clearly defining roles and permissions, managing access becomes simpler and more efficient. Administrators can quickly identify who has what level of access and adjust permissions as necessary.
- **Focused Administrative Tasks** : Administrators can perform their duties without interference or distraction from routine user activities, ensuring that critical administrative tasks are handled with the necessary attention and care.

In summary, separating administrative and normal user accounts is fundamental for maintaining a secure, stable, and compliant IT environment. It minimizes risks, ensures proper access control, and enhances the overall security posture of an organization.

## Create separate administrative accounts

In my Tenant I changed the username of the initial created user account and removed his automatically assigned license. The admin account does not need to be licensed because it is only used for administrative purposes. Afterwards I created the first normal user account in the tenant and assigned a license:

![Screenshot](/assets/wordpress-import/2024/07/image-19-1024x406.png)
## Enable & Enforce Multi Factor Authentication

Next, we'll add Multi-Factor Authentication to the accounts we've already created. First, we need to set up a way for our currently logged-on administrative account to do MFA:

![Screenshot](/assets/wordpress-import/2024/07/image-18-1024x343.png)

I will add the Authenticator app because it has higher authentication strength than SMS:

![from Microsoft](/assets/wordpress-import/2024/07/image-32-1024x480.png)

[Authentication methods and features - Microsoft Entra ID | Microsoft Learn](https://learn.microsoft.com/en-us/entra/identity/authentication/concept-authentication-methods)

![Screenshot](/assets/wordpress-import/2024/07/image-11-1024x547.png)

The wizard will walk me through the process and finally I'll get the overview of my configured security information:

![Screenshot](/assets/wordpress-import/2024/07/image-12-1024x453.png)

Now I will enable and enforce MFA for all my users from a administrative perspective:

![Screenshot](/assets/wordpress-import/2024/07/image-15-1024x449.png)

You will be guided to the old per user MFA portal. At the moment we will use this portal to enable and enforce MFA but it is recommended to [migrate to the new Authentication Policies](https://learn.microsoft.com/en-us/entra/identity/authentication/how-to-authentication-methods-manage) because the old portal will be deprecated by the end of September 2025:

![Screenshot](/assets/wordpress-import/2024/07/image-16-1024x568.png)

Once you've enabled it, you can make MFA mandatory for your users (Enforce):

![Screenshot](/assets/wordpress-import/2024/07/image-17-1024x595.png)
## Add Custom Domain

Next, you'll want to add your custom domain to your tenant.

![Screenshot](/assets/wordpress-import/2024/07/image-20-1024x452.png)

The wizard will walk you through the process. First, you have to enter your domain name. Then, you'll need to verify that you're the owner of the domain. Some DNS providers have an interface where you can allow Microsoft to log on to your DNS provider and create the required TXT record. I wanted to have control over the process, so I chose to create a TXT record manually:

![Screenshot](/assets/wordpress-import/2024/07/image-21-1024x478.png)

You must copy that TXT value and create the DNS Record:

![Screenshot](/assets/wordpress-import/2024/07/image-22-1024x483.png)

In my case I have a domain at IONOS - here you create a new TXT-Record:

![Screenshot](/assets/wordpress-import/2024/07/image-23-1024x596.png)

And paste the copied value:

![Screenshot](/assets/wordpress-import/2024/07/image-24-1024x800.png)

Then you went back to the Microsoft 365 Admin center and verify your domain:

![Screenshot](/assets/wordpress-import/2024/07/image-25-1024x844.png)

The domain should now be successful verified :-)

## Add DNS Records for additional services

Once you've got everything verified, you'll need to add some extra DNS records so your services can work properly. These are for Exchange Online, Teams (Skype for Business), Intune and DKIM. I'd suggest adding them all at once so you don't forget anything. I'm going to add them manually:

![Screenshot](/assets/wordpress-import/2024/07/image-26-1024x409.png)

You'll get a few DNS records. Just follow the instructions and add them correctly:

![Screenshot](/assets/wordpress-import/2024/07/image-27-1024x737.png)

Once you've added all the records, just click on "Continue." If everything looks good, you'll get a confirmation:

![Screenshot](/assets/wordpress-import/2024/07/image-28-1024x394.png)

If anything is missing Microsoft gives you hints what needs to be corrected.

## Change Users primary Domain

At last, you'll need to switch over your regular user accounts to your new custom domain.

![Screenshot](/assets/wordpress-import/2024/07/image-29-1024x518.png) ![Screenshot](/assets/wordpress-import/2024/07/image-30-1024x375.png)

Select your custom domain:

![Screenshot](/assets/wordpress-import/2024/07/image-31-1024x526.png)

This'll switch the user's UPN and primary SMTP address over to the custom domain. The old address will be added as an alias.

## Summary

In this article, I've outlined why and how to create separate admin accounts. I've also covered how to set up Multi-Factor Authentication for your accounts and walked you through the registration process for a custom domain. These are just the basic steps you should take. The next steps depend a lot on the license you've purchased. In an upcoming article, I'll cover how to choose the right license.

I hope you liked this article. Stay tuned for more!
