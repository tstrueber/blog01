---
layout: post
title: Amazon Simple Email Service (SES)
date: 2024-09-26 07:36:44.000000000 +02:00
categories:
- How To Guides
tags:
- Amazon
- AWS
- E-Mail
- Exchange Online
- SMTP
permalink: "/amazon-simple-email-service-ses/"
excerpt: Learn how to set up Amazon Simple Email Service (SES) for cost-effective
  email marketing and transactional emails. Discover the technical and pricing benefits
  for small businesses and enterprises.
---
## Introduction

The question of how to send email from applications when a customer moves to the cloud is a common one. As a result, I've covered this topic in [several posts](https://strueber-it-consulting.de/why-you-need-a-3rd-party-smtp-relay-service/). I have implemented [SendGrid](https://strueber-it-consulting.de/how-to-set-up-sendgrid-smtp-relay-service/) for some customers, but recently I was looking for a better alternative. I think Amazon Simple Email Service (SES) has some advantages over other services, especially for smaller companies. So here is a guide that covers the most important topics and I will show you how to set up the service.

## The service

Amazon Simple Email Service is a cost-effective way to send marketing or transactional emails. You only pay for what you use. You can use either the API or the SMTP relay service to send email.

An advantage of the service is that you can choose in which region your Simple Email Service will be hosted. Here you can choose a German region like Frankfurt am Main. This is different from other services like SendGrid where the servers are hosted in america or Mailjet where the servers are hosted in france. if you need to comply with regulatory requirements like hosting the service in german datacenters then this is a service to look into.

## Pricing

[Amazon Simple Email Service Pricing | Cloud Email Service | Amazon Web Services](https://aws.amazon.com/ses/pricing/)

[Create estimate: Configure Amazon Simple Email Service (SES) (calculator.aws)](https://calculator.aws/#/createCalculator/SES)

For the first year you will receive 3,000 emails per month for free. After that, the following pricing applies:

![]({{ '/assets/wordpress-import/2024/09/image-43-2048x662.png' | relative_url }})

This distinguishes the AWS service from other providers, where you usually have a free tier that you can use to set up the service, but after that you have to pay about 20-30€ per month to get a usable service. So the AWS service is especially cheaper for small businesses, but also if you are a big company sending thousands of emails:

| | **Amazon SES** | **Twilio SendGrid** | **Mailjet** |
| 1000 mails per month (3MB each) | 0,46 $ | 19,95 $ | 17$ |
| 300.000 mails per month (3MB each) | 135 $ | 249 $ | 250 $ |

## Setup Amazon Simple Email Service

First select the region in which you want to deploy the service - in my case, I select Frankfurt am Main:

![]({{ '/assets/wordpress-import/2024/09/image-49-2048x1017.png' | relative_url }})

Then select the service you want to deploy - just type "ses" and it will display the service:

![]({{ '/assets/wordpress-import/2024/09/image-42.png' | relative_url }})

Click on "get started" to set up the service:

![]({{ '/assets/wordpress-import/2024/09/image-44-2048x928.png' | relative_url }})

First, you need to enter an address to verify. This should be an address from the domain you want to verify:

![]({{ '/assets/wordpress-import/2024/09/image-45-2048x1015.png' | relative_url }})

Now you need to add your sending domain. For better deliverability, the service recommends defining a mail from domain that is a subdomain of your primary domain. In my case, I choose "mail" as subdomain. In case of an MX error, we choose to reject the message:

![]({{ '/assets/wordpress-import/2024/09/image-46-2048x1710.png' | relative_url }})

The virtual deliverability manager is a paid add-on service that we do not need:

![]({{ '/assets/wordpress-import/2024/09/image-47-2048x1331.png' | relative_url }})

You get the final overview and are ready to "get started":

![]({{ '/assets/wordpress-import/2024/09/image-48-2048x1678.png' | relative_url }})

You will receive an email at the address you entered with a link to verify your request. Your address will then be verified:

![]({{ '/assets/wordpress-import/2024/09/image-50-2048x913.png' | relative_url }})

Now you need to set up your sending domain, so go to the Amazon SES service and click on "Get DNS Records":

![]({{ '/assets/wordpress-import/2024/09/image-51-2048x1433.png' | relative_url }})

You will see a list of the required DNS records that you need to set up:

![]({{ '/assets/wordpress-import/2024/09/image-54-2048x1337.png' | relative_url }})

Once you have set up all the DNS records, the window will automatically disappear and the task will be marked as completed:

![]({{ '/assets/wordpress-import/2024/09/image-55-2048x1615.png' | relative_url }})

Since the account is currently in the sandbox state, we need to request production access to remove the restrictions that are currently in place:

![]({{ '/assets/wordpress-import/2024/09/image-56-2048x1241.png' | relative_url }})

You must choose whether you want to send marketing or transactional emails and provide a link to your homepage:

![]({{ '/assets/wordpress-import/2024/09/image-57-1874x2048.png' | relative_url }})

The request is under review and will hopefully be approved within the next 24 hours:

![]({{ '/assets/wordpress-import/2024/09/image-58-2048x526.png' | relative_url }})

You will receive an email requesting some additional information about your use case.

![]({{ '/assets/wordpress-import/2024/09/image-59.png' | relative_url }})

I have received an NDR in response to this message. So please go to the Support Center and reply to the case here:

![]({{ '/assets/wordpress-import/2024/09/image-65-2048x732.png' | relative_url }})

After a few days, my request is approved and my service is moved from the sandbox to the production environment:

![]({{ '/assets/wordpress-import/2024/09/image-69-2048x1867.png' | relative_url }})
## Send an E-Mail

It is important to set up the intended recipient as a verified identity while you are still in sandbox mode with your service. You set up the identity and verify it by clicking on a link in the email you receive:

![]({{ '/assets/wordpress-import/2024/09/image-68-2048x726.png' | relative_url }})

You can send a test E-Mail directly from the portal:

![]({{ '/assets/wordpress-import/2024/09/image-61-2048x812.png' | relative_url }}) ![]({{ '/assets/wordpress-import/2024/09/image-60-1577x2048.png' | relative_url }})

The other option is to create an SMTP user and send an email via SMTP:

![]({{ '/assets/wordpress-import/2024/09/image-62-2048x863.png' | relative_url }})

You will get a randomly generated username, which is fine for me, so just click "Create User":

![]({{ '/assets/wordpress-import/2024/09/image-63-2048x1558.png' | relative_url }})

You will see a summary of the credentials you created that you need to obtain. Store the credentials in a secure location. You can use the same credentials when you move the service into production:

![]({{ '/assets/wordpress-import/2024/09/image-64-2048x1060.png' | relative_url }})

You can then use this PowerShell script to send an e-mail, for example:

    #send via SMTP
    # Define username and password
    $smtpUserName = '<username>'
    $smtpPassword = ConvertTo-SecureString '<password>' -AsPlainText -Force

    # Convert to SecureString
    [pscredential]$credential = New-Object System.Management.Automation.PSCredential ($smtpUserName, $smtpPassword)

    # Send Email - change the values if needed.
    Send-MailMessage -Credential $credential `
        -useSSL `
        -smtpServer 'email-smtp.eu-central-1.amazonaws.com' `
        -port 587 `
        -from 'amazonSES@strueberit.de' `
        -to 'timo.strueber@outlook.com' `
        -subject 'Email via Amazon SES SMTP Endpoint' `
        -body 'Email via Amazon SES SMTP Endpoint'

The smtp server details can be found here:

![]({{ '/assets/wordpress-import/2024/09/image-66-2048x1088.png' | relative_url }})

In my case, the email was successfully delivered and met all of my defined DMARC requirements:

![]({{ '/assets/wordpress-import/2024/09/image-67-2048x1495.png' | relative_url }})
## Conclusion

Amazon Simple Email Service is as easy to set up as the other services, but it has the advantage of a flexible pricing model and the ability to host the service in any region you want. I thought about checking out Microsoft's High Volume Email Service as well, but [Tony Redmond's review of the service](https://practical365.com/exchange-online-hve/) showed me that the service is still not working properly and has some serious limitations that I don't want in a service like this.

I hope you enjoyed this article!
