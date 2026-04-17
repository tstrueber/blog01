---
layout: post
title: Disable Microsoft 365 Copilot Self-Service purchase
date: 2024-12-17 09:05:16.000000000 +01:00
categories:
- News
tags:
- AI
- Artificial Intelligence
- Copilot for Microsoft 365
- Microsoft 365
- Powershell
permalink: "/disable-microsoft-365-copilot-self-service-purchase/"
excerpt: Learn how to disable Microsoft 365 Copilot self-service purchase to maintain
  control over AI tool implementation in your organization. Follow our step-by-step
  guide to ensure data protection and compliance.
---
As from the beginning of October, your customers will have the option of buying Microsoft 365 Copilot directly. Microsoft announced this new feature in [MC899941](https://mc.merill.net/message/MC899941). When it comes to tech like AI, it's really important to get your IT department on board. They can help you figure out what you need and get the green light from the right people in your company. When it comes to Microsoft 365 Copilot, it's important to first look into [Information Protection](https://strueber-it-consulting.de/how-to-use-copilot-for-microsoft-365-securely/) to make sure there's no data leakage. This technology also needs to be checked and approved by your workers council and data protection team.

You can disable the self-service purchase functionality in the [Microsoft 365 admin center](https://admin.microsoft.com/Adminportal/Home?#/manageselfservicepurchase):

![]({{ '/assets/wordpress-import/2024/12/image-3.png' | relative_url }})

If you want to disable all other products too, I'd suggest using the PowerShell module. It's compatible with PowerShell 7 at the moment.
Here's a short script with all the required commands:

    # Install the required module
    Install-Module -Name MSCommerce -Scope AllUsers
    # Connect -> Auth in Browser
    Connect-MSCommerce
    # Get a list of all products
    $products = Get-MSCommerceProductPolicies -PolicyId AllowSelfServicePurchase
    $products # output the list
    foreach ($product in $products)
    {
        Update-MSCommerceProductPolicy `
            -PolicyId AllowSelfServicePurchase `
            -ProductId $product.ProductID `
            -Value "Disabled"
    }
    # Check status after change
    Get-MSCommerceProductPolicies -PolicyId AllowSelfServicePurchase

Initial state:

![]({{ '/assets/wordpress-import/2024/12/image-4.png' | relative_url }})

After executing the script:

![]({{ '/assets/wordpress-import/2024/12/image-5.png' | relative_url }})

I want to be clear that I'm pro-Copilot. I love getting things done more efficiently with the use of AI tools. My view is that implementation has to happen in a structured way, rather than being down to users doing it themselves.

Feel free to get in touch with me if you are interested in implementing Microsoft 365 Copilot!
