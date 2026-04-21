---
layout: post
title: Exchange SMTP Relay Report
date: 2024-04-10 08:53:06.000000000 +02:00
categories:
- How To Guides
tags:
- Exchange Online
- Exchange Server
- Powershell
permalink: "/exchange-smtp-relay-report/"
excerpt: How to report all systems that relay emails over a Microsoft Exchange Server
  with Log Parser 2.0 and normalize the list with PowerShell.
image:
  path: "/assets/wordpress-import/featured/2024/04/exchange-smtp-relay.png"
  alt: Exchange SMTP Relay Report
---
## Introduction

During a recent migration project, I had to migrate mailboxes to Exchange Online and then remove the local Exchange server. However, due to the customer's internal applications and multifunctional devices that relied on the Exchange servers to relay emails, we had to reconfigure the systems to a new SMTP Relay service. In this case, we opted for [MailJet](https://www.mailjet.com/products/email-api/smtp-relay/)as a cloud-based SMTP relay service. As there was almost no documentation available for the devices, I decided to review the SMTP receive logs on the Exchange server. This is where we can find all the relevant IP addresses of the sending systems. The challenge is to extract the necessary information to create a usable list.

## Check the Log files / enable verbose logging

The Exchange server does not log all SMTP connections by default. You must first activate verbose logging on the appropriate frontend receive connector.

    # check current Logging Level of the connector
    # if you have a custom connector that is used to receive mail then you have to enable verbose logging there as well!
    Get-ReceiveConnector "EXCHANGE\Default Frontend EXCHANGE" | select identity,ProtocolLoggingLevel
    # Set to Verbose Logging
    Get-ReceiveConnector "EXCHANGE\Default Frontend EXCHANGE" | Set-ReceiveConnector -ProtocolLoggingLevel Verbose

Afterwards the SMTP communications are logged in the following folder:

%ExchangeInstallPath%TransportRoles\Logs\FrontEnd\ProtocolLog\SmtpReceive

Here is an example of SMTP communication from a device:

    2024-03-13T09:01:18.723Z,EXCHANGE\Default Frontend EXCHANGE,08DC42C8FF236A1F,0,10.100.100.25:25,10.100.100.30:62136,+,,
    2024-03-13T09:01:18.723Z,EXCHANGE\Default Frontend EXCHANGE,08DC42C8FF236A1F,1,10.100.100.25:25,10.100.100.30:62136,>,"220 Exchange.contoso.com Microsoft ESMTP MAIL Service ready at Wed, 13 Mar 2024 10:01:17 +0100",
    2024-03-13T09:01:18.723Z,EXCHANGE\Default Frontend EXCHANGE,08DC42C8FF236A1F,2,10.100.100.25:25,10.100.100.30:62136,<,EHLO Backup-Veeam,
    2024-03-13T09:01:18.724Z,EXCHANGE\Default Frontend EXCHANGE,08DC42C8FF236A1F,3,10.100.100.25:25,10.100.100.30:62136,>,250 Exchange.contoso.com Hello [10.100.100.30] SIZE 37748736 PIPELINING DSN ENHANCEDSTATUSCODES STARTTLS X-ANONYMOUSTLS AUTH NTLM X-EXPS GSSAPI NTLM 8BITMIME BINARYMIME CHUNKING XRDST,
    2024-03-13T09:01:18.724Z,EXCHANGE\Default Frontend EXCHANGE,08DC42C8FF236A1F,4,10.100.100.25:25,10.100.100.30:62136,<,MAIL FROM:<veeam@contoso.com>,
    2024-03-13T09:01:18.724Z,EXCHANGE\Default Frontend EXCHANGE,08DC42C8FF236A1F,5,10.100.100.25:25,10.100.100.30:62136,*,08DC42C8FF236A1F;2024-03-13T09:01:18.723Z;1,receiving message
    2024-03-13T09:01:18.724Z,EXCHANGE\Default Frontend EXCHANGE,08DC42C8FF236A1F,6,10.100.100.25:25,10.100.100.30:62136,>,250 2.1.0 Sender OK,
    2024-03-13T09:01:18.724Z,EXCHANGE\Default Frontend EXCHANGE,08DC42C8FF236A1F,7,10.100.100.25:25,10.100.100.30:62136,<,RCPT TO:<edv@contoso.com>,
    2024-03-13T09:01:18.725Z,EXCHANGE\Default Frontend EXCHANGE,08DC42C8FF236A1F,8,10.100.100.25:25,10.100.100.30:62136,>,250 2.1.5 Recipient OK,
    2024-03-13T09:01:18.725Z,EXCHANGE\Default Frontend EXCHANGE,08DC42C8FF236A1F,9,10.100.100.25:25,10.100.100.30:62136,<,DATA,
    2024-03-13T09:01:18.725Z,EXCHANGE\Default Frontend EXCHANGE,08DC42C8FF236A1F,10,10.100.100.25:25,10.100.100.30:62136,>,354 Start mail input; end with <CRLF>.<CRLF>,
    2024-03-13T09:01:18.731Z,EXCHANGE\Default Frontend EXCHANGE,08DC42C8FF236A1F,11,10.100.100.25:25,10.100.100.30:62136,*,,Proxy destination(s) obtained from OnProxyInboundMessage event. Correlation Id:80a8d7bd-e6dd-4058-8844-aa629bb24674
    2024-03-13T09:01:18.838Z,EXCHANGE\Default Frontend EXCHANGE,08DC42C8FF236A1F,12,10.100.100.25:25,10.100.100.30:62136,>,"250 2.6.0 <e6c29c88-7479-4fee-9a7e-5ca909546317@Exchange.contoso.com> [InternalId=237172389052427, Hostname=Exchange.contoso.com] 11511 bytes in 0.102, 109,173 KB/sec Queued mail for delivery",
    2024-03-13T09:01:19.461Z,EXCHANGE\Default Frontend EXCHANGE,08DC42C8FF236A1F,13,10.100.100.25:25,10.100.100.30:62136,-,,Remote(ConnectionReset)

The connecting IP address is the relevant information for me. In the example communication above, it is 10.100.100.30. I need a list of all systems connecting to the Exchange server.

## Log Parser 2.0

A tool from Microsoft that I have used in the past is [Log Parser 2.0](https://www.microsoft.com/en-us/download/details.aspx?id=24659). It can be used to analyze log files and extract information from them. In this case, I used it to extract IP addresses from the log files. As it is a command-line tool, it must be started from the command line. Here is the command that worked for me and provided a valid list. Before executing the command, switch to the directory with the log files:

    cd "%ExchangeInstallPath%TransportRoles\Logs\FrontEnd\ProtocolLog\SmtpReceive"
    "C:\Program Files (x86)\Log Parser 2.2\LogParser.exe" "SELECT remote-endpoint,Count(*) as Hits from *.log WHERE data LIKE '%MAIL FROM%' GROUP BY remote-endpoint ORDER BY Hits DESC" -i:CSV -nSkipLines:4 -rtp:-1 > c:\temp\exchange.txt

The list includes the source TCP Port used to initiate the connection, resulting in multiple listings of the same IP address with different TCP Ports:

    remote-endpoint Hits
    10.100.101.100:64355 27
    10.100.101.100:52327 26
    10.100.101.100:60594 26
    10.100.101.48:64381 21
    10.100.101.100:64281 20
    10.100.101.100:60274 19
    10.100.101.48:52161 19
    10.100.101.100:60254 18
    10.100.101.100:55909 17
    104.47.7.168:57240 15
    10.100.101.48:65234 14
    104.47.11.168:30785 14
    104.47.7.168:29132 14
    10.100.101.48:62959 14
    ...

I wrote an article describing the process of using a PowerShell script to remove the port and summarize the hits. If you're interested in the process, feel free to check it out -\> [Article](https://modernworkplacediaries.de/powershell-scripting-with-copilot/)

The complete script can be found on [GitHub](https://github.com/tstrueber/M365Public/blob/main/Exchange/Report-SMTP-Senders.ps1). Please note that the steps in the script must be executed sequentially, and there is a manual step involved due to time constraints. Additionally, the author admits to occasional laziness ;-)

The final CSV file can be imported and converted in Excel.

![Screenshot](/assets/wordpress-import/2024/04/image.png)

The list can be used to update the systems to a new SMTP relay service before decommissioning the Exchange server. In this project, we used [MailJet](https://www.mailjet.com/products/email-api/smtp-relay/), but other services like [SendGrid](https://sendgrid.com/en-us/solutions/email-api/smtp-service), for example, can be purchased directly from an Azure Subscription for more convenience ([Azure Marketplace Link](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/sendgrid.tsg-saas-offer?tab=overview)).

## Conclusion

When dealing with topics such as uninstalling an Exchange server, it is important to have a well-structured plan. Exchange has been around for some time, resulting in deep integration with various systems. Many systems send emails, and the internal Exchange server is often used for this purpose. The approach used here was not the most efficient. In the past (about 10 years ago), I have used Log Parser for a similar task. Since I no longer have the documentation, I had to find a new approach. However, I enjoyed the process :-)

I hope you found this article enjoyable. If you have a more efficient approach, please feel free to share it with me.
