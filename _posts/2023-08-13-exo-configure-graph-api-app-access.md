---
layout: post
title: Exchange Online Configure Graph API Application Access
date: 2023-08-13 15:08:07.000000000 +02:00
categories:
- How To Guides
tags:
- Azure AD
- Exchange Online
- Graph API
- Microsoft 365
- Powershell
permalink: "/exo-configure-graph-api-app-access/"
excerpt: How to create an Azure AD App Registration to access a shared mailbox in
  Exchange Online with the Graph API interface.
image:
  path: "/assets/wordpress-import/featured/2023/08/2023-08-13-15_04_00-Microsoft-Whiteboard.jpg"
  alt: Exchange Online Configure Graph API Application Access
---
## Introduction

This is Part 1 of 2. In this article I describe how to create an App Registration in Azure AD with Graph API permissions to access a shared mailbox in Exchange Online. The application will access the mailbox with application authentication.

In the next article (not yet pubilshed) I will describe how to test access to the shared mailbox with Powershell. We will authenticate as an application and then we will receive & send an E-Mail.

## Difference between delegated & application access

For accessing a mailbox through an application we basically differenciate between delegated access and app-only access. When using delegated access you "access the mailbox on behalf of a user" so you need a real user with username & password to authenticate to. In addition due to security reasons you will also need to provide an additional factor for secure authentication (MFA with Authenticator for example). Because this is not suitable for an application that will run in the background we have the second option. That option is called app-only access! In this case the application can authenticate and interact with the mailbox with its own identity without a signed in user.

![Screenshot](/assets/wordpress-import/2023/08/2023-08-13-14_17_12-Microsoft-Whiteboard-1024x383.jpg)

If you are interested in reading more about the different access szenarios you may read on here:
[https://learn.microsoft.com/en-us/graph/auth/auth-concepts#access-scenarios](https://learn.microsoft.com/en-us/graph/auth/auth-concepts#access-scenarios)

## Prepare the mailbox & distribution group

In this example we want to access a shared mailbox in Exchange Online that will be used for receiving invoices. To later limit the access of the App registration to only the mailbox we must create an additional mail-enabled security group. This is due to the fact that you can only target an application access policy to a mail-enabled security group. The shared mailbox is added to the distribution group.

| **shared mailbox** | Invoices |
| **mail-enabled distribution group** | Invoices-Access |

object names

We are creating the mailbox and the mail-enabled distribution and then we are adding the mailbox to the distribution group with Powershell:

    Connect-ExchangeOnline
    # create shared mailbox
    New-Mailbox -Shared -Name "Invoices" -Alias Invoices
    # create mail-enabled distribution group
    New-DistributionGroup -Name "Invoices-Access" -Alias "Invoices-Access" -Type "Security"
    # add mailbox to the distritution group
    Add-DistributionGroupMember -Identity Invoices-Access -Member Invoices

This process is suitible for a cloud only environment. When you have a hybrid Exchange deployment you must follow the guidelines and create a remote mailbox from the onPrem Exchange server etc. for the routing to work correctly!

## Create an Azure AD App Registration

We are creating the Azure AD App Registration for accessing the shared mailbox using the Azure Portal (because for me it is easier that way).
[Link to App Registration in Azure](https://portal.azure.com/#view/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/~/RegisteredApps)

![Screenshot](/assets/wordpress-import/2023/08/image-4-1024x682.png)

Give the App Registration a useful recognizable name. In my example I include the following:
1. "Graph API" -\> the interface used
2. "Exchange Mailbox Access" -\> what the App registration is used for
3. "Invoices" -\> The mailbox that is accessed through this App Registration
The rest can be left as is:

![Screenshot](/assets/wordpress-import/2023/08/image-5-1024x829.png)
## Assign the needed permissions

Now you must first remove the default permission as we dont need it for our access scenario. The default permission gives the application the permission to read the user profile information of the signed in user.
I recommend only granting the permissions you really need:

![Screenshot](/assets/wordpress-import/2023/08/image-6-1024x583.png)

Afterwards you must add the needed Graph API permissions. As we want to logon to the mailbox with an application we must choose "Application permissions" as described in the beginning of this article. For this test we want to be able to read and edit E-Mails in the mailbox (Mail.ReadWrite) and send E-Mails from the mailbox (Mail.Send). So we add the following permissions:

![Screenshot](/assets/wordpress-import/2023/08/image-7-1024x605.png)

For the granted permissions to become active you must grant tenant-wide admin consent. This is due to the fact that the application will be able to interact with all mailboxes in the tenant. As we just want the application to interact with the Invoice mailbox we will later limit the permissions with an Application Access Policy in Exchange Online.
You need a user with one of the following roles assigned (Global Administrator / Priviliged Role Administrator / Cloud Application Administrator or Application Administrator) for this operation:

![Screenshot](/assets/wordpress-import/2023/08/image-8-1024x578.png)

If you would like to read more about granting tenant-wide admin consent to an application, please click here:
[Grant tenant-wide admin consent to an application - Microsoft Entra | Microsoft Learn](https://learn.microsoft.com/en-us/azure/active-directory/manage-apps/grant-admin-consent?pivots=portal)

After granting admin consent the status for the permissions will change to "Granted" - if the operation was successfull:

![Screenshot](/assets/wordpress-import/2023/08/image-9-1024x281.png)
## Create client secret

You can use either a certificate or a client secret to authenticate to the created application. For this test we will choose a client secret (because it is easier) but in a production environment it is recommended to go with a certificate because it is more secure!
You must give the client secret a name and define how long it is valid for:

![Screenshot](/assets/wordpress-import/2023/08/image-10-1024x608.png)

Copy the secret you have created and store it in a secure location, such as a password safe.
We will need the secret later for authenticating to the application.

![Screenshot](/assets/wordpress-import/2023/08/image-11-1024x301.png)

Now switch to the Overview page of the app registration and take a note of the application (client) ID and the Directory (tenant) IT:

![Screenshot](/assets/wordpress-import/2023/08/image-12-1024x424.png)
## Create an Application Access Policy

If you had taken a closer look at the API permissions granted, you would have seen that the application has **access to all mailboxes** and can **send mail as any user** :

![Screenshot](/assets/wordpress-import/2023/08/image-13-1024x272.png)

Since you will most likely be restricting the application's permissions to the mailbox we created in the first place, you must create an application access policy in Exchange Online. Please verify the current granted permissions before policy creation. You'll have access to any mailbox in the tenant. We'll verify access to the user mailbox named "meganb". To test an Application Access Policy, we require the AppId, the identity of the target mailbox and the cmdlet Test-ApplicationAccessPolicy.

    Connect-ExchangeOnline
    # Application (client) ID
    $AppId = "324b9727-62c5-9b1b-4f37-4005be8e6562"
    Test-ApplicationAccessPolicy -AppId $AppId -Identity "meganb@M365x77044157.onmicrosoft.com"

The output shows "Gewährt" = "granted" when the access is possible like in the screenshot below:

![Screenshot](/assets/wordpress-import/2023/08/image-14.png)

We must create the Application Access Policy to limit access to the shared mailbox we've created. We require a unique identifier for the group, (in this case, we will use the Primary SMTP address) as well as the Application ID (client) that you recently noted. We'll also provide a brief description for the Application Access Policy.

    Connect-ExchangeOnline
    # Address of the mail-enabled security group
    $group = "Invoices-Access@M365x77044157.onmicrosoft.com"
    # Application (client) ID
    $AppId = "324b9727-62c5-9b1b-4f37-4005be8e6562"

    New-ApplicationAccessPolicy -AppId $AppId `
        -PolicyScopeGroupId $group `
        -AccessRight RestrictAccess `
        -Description "This App has only access to the members of this group"

![Screenshot](/assets/wordpress-import/2023/08/image-15-1024x227.png)

We can now retest access to the "MeganB" mailbox. The output displays "Rejected" as the application access policy has now restricted access from the application to members of the mail-enabled distribution group only:

![Screenshot](/assets/wordpress-import/2023/08/image-18.png)

We're finally testing access to the 'Invoices' mailbox that we created initially. Access is still possible because the mailbox is part of the mail-enabled distribution group:

![Screenshot](/assets/wordpress-import/2023/08/image-17.png)
## Summary

This article describes how to create an Azure AD App registration with permissions to access a mailbox via the Graph API interface. After that, I described how to restrict the permissions of the created application to only the intended mailbox instead of the entire tenant. Finally, a brief test of the created policy was conducted with a cmdlet from Microsoft.

The next article will cover how to access the mailbox through the Graph API to read and send emails.
