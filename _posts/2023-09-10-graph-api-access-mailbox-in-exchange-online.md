---
layout: post
title: Graph API Access Mailbox in Exchange Online
date: 2023-09-10 18:56:17.000000000 +02:00
categories:
- How To Guides
tags:
- Exchange Online
- Graph API
- Microsoft 365
- Powershell
permalink: "/graph-api-access-mailbox-in-exchange-online/"
excerpt: In this article I show you how you can access an Exchange Online Mailbox
  through the Graph API. We will list the messages in the mailbox.
image:
  path: "/assets/wordpress-import/featured/2023/09/2023-09-10-20_21_41-Microsoft-Whiteboard.jpg"
  alt: Graph API Access Mailbox in Exchange Online
---
### Introduction

This is the second article in this two part series. In the previous article, I explained how to create an Azure AD application to grant access to a mailbox. In this article, I will demonstrate how to access the mailbox via the Graph API and list messages. I will use the Invoke-RestMethod PowerShell cmdlet to send the Web requests to the Graph API.

### OAuth 2.0 Authentication

In this example, we will authenticate directly to the application using the application's identity. In the previous article, we opted for application authentication instead of delegated authentication during the application creation process (s. [article](https://modernworkplacediaries.de/exo-configure-graph-api-app-access/#Difference_between_delegated_application_access)).&nbsp;

Because we granted administrative consent to the application, there is no need for an additional request for consent. So here is the authentication procedure:

As a first step, the application sends a request to the Microsoft Identity Platform to authenticate using the client secret. Once the request is validated, the Identity Platform sends a token back to the application. The application can use this token for subsequent requests to the resource, by adding it to the authorization header. The resource validates the token, and upon successful validation, sends the secure data back to the application.

The image below illustrates the steps in the OAuth 2.0 client credentials flow:

![Screenshot](/assets/wordpress-import/2023/09/image-1024x737.png)

In the following Microsoft Learn article you can read more about the process:

[https://learn.microsoft.com/en-us/azure/active-directory/develop/v2-oauth2-client-creds-grant-flow#application-permissions](https://learn.microsoft.com/en-us/azure/active-directory/develop/v2-oauth2-client-creds-grant-flow#application-permissions)

### Request the Token

As a first step, I initialize all necessary variables for subsequent processing.

$mailbox = the UPN of the mailbox I want to access

$clientId = the client ID of the created Azure AD Application

$tenantId = the ID of the Azure AD Tenant

$clientSecret = The client secret created for authentication to the application.

(All UPNs IDs and Secrets are changed and not usable!)

    # mailbox UPN
    $mailbox = "Invoices-Access@M365x77044157.onmicrosoft.com"

    # set Application (client) ID, tenant Name and secret
    $clientId = "5eea066c-c08d-552e-9589-9ce602zc57ca"
    $tenantId = "3hc68a76-84d5-4bch-a7b7-872z6585f47f"
    $clientSecret = "aJy8Q~rtoMzSIH18~HqHDfxnEJHhHme3HBw5abuG"

For constructing the request body, I set the Grant\_type to "client\_credentials" because I am authenticating with a client secret. I have also set the scope to graph.microsoft.com/.default as I will be calling the Graph API. The parameters such as client\_id, tenantId, and client\_secret can be obtained from the Azure AD application. All these parameters are stored in an array variable called $ReqTokenBody.

    # build reqest body
    $ReqTokenBody = @{
        Grant_Type = "client_credentials"
        Scope = "https://graph.microsoft.com/.default"
        client_Id = $clientID
        Client_Secret = $clientSecret
    }

The following step is to request the token using the Invoke-RestMethod cmdlet. The request is sent to the Microsoft Identity Platform, which is identified by the URL login.microsoft.com. We include the ID of the Azure AD tenant in the URL. You use the POST method and include the constructed token body in the request with the -body parameter. Since we expect to receive a token in response to our request, we prepend a variable to which the response will be written.&nbsp;

    # get token
    $TokenResponse = $null
    $TokenResponse = Invoke-RestMethod `
        -Uri "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token" `
        -Method POST -Body $ReqTokenBody

Here you can read more about the process:

[https://learn.microsoft.com/en-us/azure/active-directory/develop/v2-oauth2-client-creds-grant-flow#first-case-access-token-request-with-a-shared-secret](https://learn.microsoft.com/en-us/azure/active-directory/develop/v2-oauth2-client-creds-grant-flow#first-case-access-token-request-with-a-shared-secret)

When the token is successfully returned, it will be stored in the variable and we can proceed with checking it:

![Screenshot](/assets/wordpress-import/2023/09/image-1-1024x267.png)

What we will need for our final request to the resource is the access token found within the $TokenResponse variable shown in the screenshot above.

### Send the Request to the Resource

For testing purposes, we will list the messages currently in the mailbox.

[https://learn.microsoft.com/en-us/graph/api/user-list-messages](https://learn.microsoft.com/en-us/graph/api/user-list-messages)

The request URL has the following structure:
GET /users/{id | userPrincipalName}/messages

We will send a web request to the created URL with the mailbox UPN stored in the $mailbox variable.

The access\_token will be included in the request header.

    # request and write the response to a variable
    $apiUrl = "https://graph.microsoft.com/v1.0/users/$mailbox/messages/"
    $Data = Invoke-RestMethod `
        -Headers @{ Authorization = "Bearer $($Tokenresponse.access_token)" } `
        -Uri $apiUrl -Method Get

### Working with the response

The response is not very pretty:

![Screenshot](/assets/wordpress-import/2023/09/image-2-1024x244.png)

But we can easily access the values we are interested in:

    # formated output of the mails
    $mails = $Data.Value
    $mails | select-object receivedDateTime,subject, `
        @{ label='sender'; expression={($_.sender.emailAddress.address)} }

![Screenshot](/assets/wordpress-import/2023/09/image-3.png)
### Summary

In this article, I cover the usage of the Graph API to list E-Mail messages within a mailbox in Exchange Online.
The received token also allows sending, or modifying messages but this is not covered in this article.

The complete script is available on GitHub:

[![Screenshot](/assets/wordpress-import/2023/09/image-4.png)](https://github.com/tstrueber/M365Public/blob/main/Exchange/ApplicationAccess/Graph-List-messages.ps1)
