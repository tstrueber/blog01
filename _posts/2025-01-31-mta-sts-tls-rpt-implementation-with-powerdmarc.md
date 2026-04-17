---
layout: post
title: MTA-STS &amp; TLS-RPT Implementation with PowerDMARC
date: 2025-01-31 10:54:10.000000000 +01:00
categories:
- How To Guides
tags:
- Exchange Online
- Security
permalink: "/mta-sts-tls-rpt-implementation-with-powerdmarc/"
excerpt: Learn how to enhance your email security with MTA-STS and TLS-RPT using PowerDMARC.
  This guide covers the benefits, setup process, and best practices to ensure your
  emails are protected from interception and tampering.
---
## Introduction

SPF, DKIM, and DMARC are fundamental to email security—but they alone are not enough to fully protect your emails. Without additional measures like **MTA-STS** (Mail Transfer Agent Strict Transport Security) and **TLS-RPT** (SMTP TLS Reporting), attackers can still exploit weaknesses in email encryption and delivery. In this post, I’ll explain these security mechanisms and give you a guide how to implement them with [PowerDMARC](https://powerdmarc.com/hosted-mta-sts-services/). If you are interested in PowerDMARC check out my last blog post about [how to implement the service](https://strueber-it-consulting.de/powerdmarc-implementation/).

## What is MTA-STS?

**MTA-STS** (Mail Transfer Agent Strict Transport Security) is an email security standard that enforces **TLS encryption** for emails in transit. It helps prevent **Man-in-the-Middle (MitM) attacks** by ensuring that emails sent to your domain are always encrypted and not downgraded to unencrypted connections due to attacks or misconfigurations.

### Security Benefits of MTA-STS
1. **Prevents Downgrade Attacks:**
  - Without MTA-STS, an attacker could trick email servers into falling back to unencrypted SMTP (known as an **SMTP downgrade attack** ).
  - MTA-STS enforces encryption, ensuring that emails are only transmitted securely.
  - **Mitigates Man-in-the-Middle Attacks:**
    - Attackers could intercept and alter emails if encryption is not properly enforced.
    - MTA-STS ensures that emails are only delivered if a secure TLS connection can be established with the recipient’s mail server.
    - **Enhances Email Security Posture:**
      - It works alongside **SPF, DKIM, and DMARC** to provide an extra layer of protection.
      - MTA-STS secures the **transmission** of emails, while SPF, DKIM, and DMARC protect against **spoofing and phishing**.
      - **Improves Compliance & Trust:**
        - Many security frameworks and best practices recommend the use of TLS encryption.
        - Enforcing MTA-STS demonstrates a commitment to email security and data protection.

By implementing MTA-STS, you significantly **reduce the risk of email interception and tampering** , ensuring that your emails remain secure in transit.

### Video explaining MTA-STS

There is a good YouTube video that explains the process and benefits of MTA-STS in more detail:

https://www.youtube.com/watch?v=W-n0cPKxSw0
## What is TLS-RPT?

**TLS-RPT (SMTP TLS Reporting)** is a standard that provides visibility into **email transport security issues** by generating reports on **failed and successful** encrypted email transmissions. When enabled, mail servers send structured reports (typically in JSON format) to a designated email address, detailing issues with **TLS encryption, certificate validation, and MTA-STS enforcement**.

### Why Is TLS-RPT an Important Addition to MTA-STS?

          1. **Detects Misconfigurations & Failures**
            - Without TLS-RPT, enforcing MTA-STS can lead to silent email delivery failures if something is misconfigured.
            - TLS-RPT provides immediate feedback, helping administrators troubleshoot TLS and MTA-STS issues.
            - **Monitors Active Attacks**
              - If attackers attempt **downgrade attacks** or manipulate TLS connections, TLS-RPT can reveal patterns of suspicious activity.
              - This allows for proactive security measures before significant damage occurs.
              - **Improves Email Deliverability**
                - If legitimate emails fail due to **certificate mismatches** or **TLS negotiation failures** , you receive reports instead of losing emails without notice.
                - Helps ensure that emails are reaching their destination securely.
                - **Complements MTA-STS for End-to-End Security**
                  - MTA-STS **enforces encryption** , while TLS-RPT **provides insight** into whether that enforcement is working as expected.
                  - Together, they strengthen email security by ensuring both policy enforcement and visibility into transport-layer issues.

### Conclusion

Implementing **MTA-STS without TLS-RPT** is like setting up a security system without monitoring alerts—you won’t know if something is failing. **TLS-RPT gives you the visibility needed to ensure your email security policies are working** , helping to detect and fix issues before they impact communication.

## Enabling MTA-STS

Here I assume that you are already a customer of PowerDMARC. If not you might want to check out my guide [how to set up the service](https://strueber-it-consulting.de/powerdmarc-implementation/).

You select the hosted MTA-STS service (2), then you select your domain (3) and you get shown the needed DNS record for setting up MTA-STS and TLS-RPT.

![]({{ '/assets/wordpress-import/2025/01/image-26.png' | relative_url }})

After you have created the required CNAME records in your DNS zone you click on Validate -\> if everything is fine you get the confirmation that the hosted service can be deployed in PowerDMARC's backend. This will publish a MTA-STS policy file with a valid certificate. I will get into detail about this later.

![]({{ '/assets/wordpress-import/2025/01/image-27.png' | relative_url }})

You'll get a confirmation and info that it'll take up to 48 hours to create the records. I only waited about 15 minutes for my activation.

After that, I got a screen that said the DNS records have been published correctly and point to the PowerDMARC service. You can see below that the MTA-STS policy file is accessible and the certificate is valid. The initial mode is set to "Testing", which means that compatible systems will use MTA-STS when sending emails to your domain. If the process fails, they can fall back to less secure communication.

![]({{ '/assets/wordpress-import/2025/01/image-28.png' | relative_url }})

Just click on the link under 'Store Policy file manually' to check your MTA-STS policy file.

![]({{ '/assets/wordpress-import/2025/01/image-33.png' | relative_url }})

This will show your current policy file, which will be used by sending servers that support MTA-STS:

    version: STSv1
    mode: testing
    max_age: 86400
    mx: strueberit-de.mail.protection.outlook.com

Just a heads-up that you should leave the service in 'Testing' mode until you've checked the TLS-RPT reports to make sure MTA-STS is working fine. I had to wait a few days for a report to be delivered and made available in the portal. It's really important to set the date (3) correctly, as in my case it was set to a week in the past and no report showed. As you can see at (4), the Googlemail policy is in testing mode. If you click on 'Download' (5), you'll be able to take a look at the JSON file.

![]({{ '/assets/wordpress-import/2025/01/image-29.png' | relative_url }})

But the JSON isn't formatted very well.

![]({{ '/assets/wordpress-import/2025/01/image-30.png' | relative_url }})

But Github Copilot can help :-)

![]({{ '/assets/wordpress-import/2025/01/image-31-2048x1299.png' | relative_url }})

Here you can see the full JSON.

Next, you need to set the policy mode to "Enforce":

![]({{ '/assets/wordpress-import/2025/01/image-32.png' | relative_url }})

This will change your MTA-STS policy file to "mode: enforce":

    version: STSv1
    mode: enforce
    max_age: 86400
    mx: strueberit-de.mail.protection.outlook.com

So, you've gone ahead and implemented MTA-STS & TLS-RPT, and you've shifted from testing mode to enforcing mode.

This means I've got an A+ rating from the PowerDMARC perspective. :-)

![]({{ '/assets/wordpress-import/2025/01/image-34.png' | relative_url }})

You might also want to take a look at the free tool for a quick check of your domains' email security status:

[Kostenloses Domänenanalysetool | PowerAnalyzer](https://powerdmarc.com//de/analyzer/)

## Conclusion

So, if you really want to boost your email security beyond SPF, DKIM and DMARC, you've got to think about implementing MTA-STS and TLS-RPT. MTA-STS makes sure your emails are encrypted and prevents downgrade attacks, while TLS-RPT gives you visibility into potential issues, so you can keep an eye on and troubleshoot any misconfigurations or security threats.

Using a hosted service like PowerDMARC makes setting up MTA-STS and TLS-RPT a lot easier, getting rid of the hassle of manual configuration while making sure you're following the best security practices. Investing in these protocols improves email deliverability, data integrity, and protection against interception, making them essential for any organisation that values secure email communication.

If this article was useful, please let me know by leaving a comment.
If you have any questions about MTA-STS or email security in general, please [get in touch](https://strueber-it-consulting.de/how-to-get-in-touch-with-timo-struber/). I'm happy to help!
