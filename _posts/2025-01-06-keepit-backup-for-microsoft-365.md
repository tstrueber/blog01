---
layout: post
title: Keepit Backup for Microsoft 365
date: 2025-01-06 18:00:42.000000000 +01:00
categories:
- How To Guides
tags:
- Backup
- Entra ID
- Microsoft 365
permalink: "/keepit-backup-for-microsoft-365/"
excerpt: Discover how to implement Keepit Backup for Microsoft 365 to ensure data
  protection and compliance. Learn about the benefits, setup process, and key features
  of this cloud-native backup solution.
image:
  path: "/assets/wordpress-import/featured/2025/01/12953603_Data_security_15-scaled.jpg"
  alt: Keepit Backup for Microsoft 365
---
## Introduction

Today's article is a little bit longer and covers the implementation of Keepit Backup for Microsoft 365.

### Why Is a Backup in Microsoft 365 Important?

While Microsoft 365 offers robust infrastructure and redundancy, its primary focus is ensuring service availability—not comprehensive data protection. Microsoft operates under a "[shared responsibility model](https://learn.microsoft.com/en-us/azure/security/fundamentals/shared-responsibility)," meaning that while they safeguard the platform, the responsibility for data management, retention, and recovery often falls on the user. Accidental deletions, ransomware attacks, and compliance requirements are common scenarios where relying solely on Microsoft's native tools may fall short. A dedicated backup solution ensures your data is recoverable and protected, offering peace of mind and reducing the risk of costly downtime or compliance breaches.

### What Differentiates a Backup from an Archive?

Backups and archives serve different purposes. A **backup** is a copy of data created to restore information in case of accidental deletion, corruption, or disaster. It is designed for short-term, frequent access and quick recovery. Conversely, an **archive** is a long-term storage solution aimed at preserving information for compliance, legal, or historical purposes. Archives are typically optimized for search and retrieval rather than restoration, and they often involve policies to retain data for extended periods. A backup ensures data recoverability, while an archive ensures information preservation.

In addition to Keepit Backup you can implement an archiving solution in Microsoft 365 using [retention policies](https://learn.microsoft.com/en-us/purview/data-lifecycle-management).

### What Is Keepit Backup for Microsoft 365?

[Keepit Backup for Microsoft 365](https://www.keepit.com/services/backup-microsoft-365/) is a comprehensive, cloud-native backup solution tailored for protecting data across Microsoft 365 services like Exchange, Teams, OneDrive, and SharePoint. Keepit provides automated, immutable backups, ensuring your data is always recoverable, even in scenarios like accidental deletions or ransomware attacks. Its user-friendly interface allows for granular recovery, letting you restore specific items or entire datasets with ease. Additionally, Keepit emphasizes compliance and security, offering features like encryption and role-based access control to meet regulatory requirements while safeguarding your business-critical information.

As you'll see in the following guide, Keepit is easy to implement and affordable (currently 33€ per user per year for up to 50 users). You can also choose the data center where your backups will be processed and stored, which is important for some companies because they have to comply with regulatory requirements.

## Implementation

### Prerequisites

Before we get started on the implementation, you'll need to purchase a license for Keepit. I went with the Backup and Recovery Business Essential M365 license in my example and got it from Software Express.

[keepit-240801 | Backup and Recovery Business Essential M365 Preise | Software-Express](https://www.software-express.de/hersteller/keepit/alle-produkte/keepit-240801-keepit-240801/)

Second, you'll need a licensed service account for Keepit Backup to process the data in your tenant. To keep costs down, I bought a Microsoft 365 Business Basic license for that purpose.

### Create a Service Account

Go ahead and create a service account and assign a license.

![Screenshot](/assets/wordpress-import/2024/12/image-6.png)

Just log in with the service account to set up MFA, and you're all set.

### Create an app registration

Keepit will authenticate to your Microsoft 365 environment using a managed identity and certificate. To do that, you'll need to create an app registration first.

Follow this guide: [Create an app registration in Entra ID : Help Center](https://help.keepit.com/support/solutions/articles/6000271640)

![Screenshot](/assets/wordpress-import/2024/12/image-7.png) ![Screenshot](/assets/wordpress-import/2024/12/image-8.png) ![Screenshot](/assets/wordpress-import/2024/12/image-9.png) ![Screenshot](/assets/wordpress-import/2024/12/image-10.png)

Add Redirect URLs from the guide above until it looks like this:

![Screenshot](/assets/wordpress-import/2024/12/image-11.png)

Create a certificate for secure authentication.

[Generate a certificate for your Entra ID app registration : Help Center](https://help.keepit.com/support/solutions/articles/6000274922)

Download & run the provided script and it will create a \*.cer file for you.

Upload the certificate for authentication.

![Screenshot](/assets/wordpress-import/2024/12/image-12.png)

Add the listed permissions to the app registration & grant admin consent:

![Screenshot](/assets/wordpress-import/2024/12/image-13.png)
### Add a M365 Connector

Now we will connect Keepit to your Microsoft 365 environment.

Logon to the Keepit portal with your account:

[Keepit | Dashboard](https://de-fr.keepit.com/desktop/overview)

Add a Microsoft 365 Connector:

![Screenshot](/assets/wordpress-import/2024/12/image-14.png) ![Screenshot](/assets/wordpress-import/2024/12/image-15.png)

Sign in with your service account and approve the requested permissions:

![Screenshot](/assets/wordpress-import/2024/12/image-18.png)

For me, the first try didn't work out, but I clicked "Try again" and it went through.

![Screenshot](/assets/wordpress-import/2024/12/image-17.png)
### Configure Backup

I also turned on "Teams Chats." To start the backup, you'll need to add the app registration.

![Screenshot](/assets/wordpress-import/2024/12/image-19.png)

Obtain the App ID from the app registration in the Entra ID portal:

![Screenshot](/assets/wordpress-import/2024/12/image-20.png)

Now you can click next in the Keepit wizard:

![Screenshot](/assets/wordpress-import/2024/12/image-21.png)

Go ahead and enter the App ID, then upload the certificate file and the private key. We created both of these with the script we ran a few steps ago.

![Screenshot](/assets/wordpress-import/2024/12/image-22.png)

The app will ask for extra permissions from your service account, which you'll need to accept:

![Screenshot](/assets/wordpress-import/2024/12/image-23.png)

When everything is fine you can click on Configure:

![Screenshot](/assets/wordpress-import/2024/12/image-24.png)

You can check the settings for each service, but it should be on for all users by default. If you want to exclude some users, you can do that here. Finally, you can start the backup.

![Screenshot](/assets/wordpress-import/2024/12/image-25.png)

You can check on the status of your backup in the "Job Monitor" pane.

![Screenshot](/assets/wordpress-import/2024/12/image-26-2048x720.png)

At last, I suggest getting rid of the global admin role from the backup service account since it's not needed anymore.

![Screenshot](/assets/wordpress-import/2024/12/image-27.png)
## Summary

Today's article is all about why having a backup solution in Microsoft 365 is so important and how to set up Keepit Backup. If you have any questions about this or need help setting it up, [just let me know](https://modernworkplacediaries.de/how-to-get-in-touch-with-timo-struber/). I'd be happy to help!
