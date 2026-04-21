---
layout: post
title: Remove visual marking label in Microsoft Information Protection
date: 2023-07-10 20:58:38.000000000 +02:00
categories:
- How To Guides
tags:
- Microsoft 365
- Microsoft Information Protection
permalink: "/remove-header-or-footer-insert-from-other-labeling-solution-in-microsoft-information-protection/"
excerpt: How to remove a visual label inside the header or footer of an Word document
  with the function WordShapeNameToRemove in the AIP Unified Labeling client.
image:
  path: "/assets/wordpress-import/featured/2023/07/IMG_0359.jpeg"
  alt: Remove visual marking label in Microsoft Information Protection
---
## Introduction

In a recent customer project, the customer's documents must be migrated from an old information protection solution "Novapath" to Microsoft Information Protection. The project is part of a large Microsoft 365 migration project of the customer.

The classification level of the documents was stored not only on the metadata level of the files, but also on the visual level in the footer within Word and PowerPoint documents, as you can see here for example in a Word document:

![Screenshot](/assets/wordpress-import/2023/07/image-1-955x1024.png)
## Show classification information

To show the classification level of a document you have two options:

1. you can extract the office file for example with 7zip and dig into the extracted metadata files
2. you can use the following PowerShell script to show the classification information on the metadata&nbsp;level

    $filename = "C:\Temp\Confidential Document.docx"
    $zip = [System.IO.Compression.ZipFile]::Open($filename, 'Read')
    $propsentry = $zip.GetEntry('docProps/custom.xml')
    If ($propsentry -ne $null) {
        $stream = $propsentry.Open()
        $reader = New-Object System.IO.StreamReader $stream
        $content = $reader.ReadToEnd()
        $xmldoc = [xml]$content
        $xmldoc.Properties.property | Select-Object name,lpwstr
    }
    $zip.Dispose()

The output shows information like the document-ID, the classification client version and the classification level:

![Screenshot](/assets/wordpress-import/2023/07/image.png)
## Custom configurations for the AIP unified labeling client

For the migration of the documents to Microsoft Information Protection one part of the migration is the removal of the label on the visual layer. Microsoft provides a functionality in the Azure Information Protection (AIP) unified labeling client to remove those markings from Word and Powerpoint:

[Word function WordShapeNameToRemove](https://learn.microsoft.com/en-us/azure/information-protection/rms-client/clientv2-admin-guide-customizations#remove-headers-and-footers-from-other-labeling-solutions)

[PowerPoint function PowerPointRemoveAllShapesByShapeName](https://learn.microsoft.com/en-us/azure/information-protection/rms-client/clientv2-admin-guide-customizations#remove-all-shapes-of-a-specific-shape-name)

### Remove label from Word documents

For using the function mentioned in the above article "WordShapeNameToRemove" you must first find the name of the shape used for inserting the label. You must enable the "selection pane" within the editing section in the "Home" pane of Word:

![Screenshot](/assets/wordpress-import/2023/07/image-2-1024x356.png)

Because the label is inserted into the footer you must switch to the "Header & Footer" configuration pane where you will then find the corresponding shape - in this example "novaPathWDBox\_1\_0":

![Screenshot](/assets/wordpress-import/2023/07/image-3.png)

Checking documents with other classification level I noticed that they all use the same shape name. So I will be able to use the function "WordShapeNameToRemove" for documents of all classification levels.

To roll out the custom configuration for the AIP unified labeling client you must change the label policy rolled out to the client. This is the new policy that is used for setting the new classification level with Microsoft Information Protection. When setting the new classification level the client will remove the old visual marking while you have the document opened.

For changing the label policy you must connect to the Security & Compliance PowerShell and update the label policy:

    Connect-IPPSSession # connect to the Security & Compliance
    $labelpolicy = "Global sensitivity label policy" # set the name of the label policy to the variable
    Set-LabelPolicy -Identity $labelpolicy -AdvancedSettings @{WordShapeNameToRemove="novaPathWDBox_1_0"}

We will test the result in a later step!

### Remove label from PowerPoint documents

The function for removing the visual markings in PowerPoint documents used in this situation is called "PowerPointRemoveAllShapesByShapeName". It works in a similar way like the function for Word documents. In an example PowerPoint Presentation you must first find the shape that is used to insert the label. In my case the label was was set in the slide master of the documents:

![Screenshot](/assets/wordpress-import/2023/07/image-4-1024x605.png)

Then you can again adjust the custom configuration for the AIP unified labeling client in the label policy:

    Connect-IPPSSession # connect to the Security & Compliance
    $labelpolicy = "Global sensitivity label policy" # set the name of the label policy to the variable
    Set-LabelPolicy -Identity $labelpolicy -AdvancedSettings @{PowerPointRemoveAllShapesByShapeName="novaPathPPTBox"}

The removal of the visual marking works in the same way like it is with the word documents mentioned above. So when you have a PowerPoint Presentation with an old marking opened and you assign a new classification with the AIP unified labeling client it will remove the old visual marking.

## Check the rollout of the custom configuration on the office client

After changing the policy you must wait some time for the policy change to update in the cloud and the office client has to get the new configuration as well. To speed up the process on the client you are using you must first close all Office applications. Afterwards you must delete the current downloaded configuration file - you will find it in this folder on your client:
%LOCALAPPDATA%\Microsoft\Office\CLP
There is a policy file with your username that includes the custom configuration for your user. Please delete this file.

After starting Word your client will pull the new configuration from the cloud and create a new configuration file. Look for the following lines that will show the policy changes performed with PowerShell:

![Screenshot](/assets/wordpress-import/2023/07/image-6.png)

Maybe you have to repeat the removal and download of the configuration file a few times because it can take some time to populate the new configuration file. In my case it took about 10 minutes.

## Test the removal of the visual markings

Now I want to test the removal of the old label. I open a Word document with the "Internal" label set and assigning the new sensitivity label "General" with the AIP unified labeling client:

![Screenshot](/assets/wordpress-import/2023/07/image-7-1024x749.png)

After clicking on "General" the "Internal" marking in the footer of the document disappears:

![Screenshot](/assets/wordpress-import/2023/07/image-8-1024x744.png)

PowerPoint behaves exactly the same - after assigning the "General" label the "Internal" label diappears:

![Screenshot](/assets/wordpress-import/2023/07/image-9-1024x745.png) ![Screenshot](/assets/wordpress-import/2023/07/image-10-1024x745.png)
## Limitations of the solution

1. the removal only works when assigning the label while the document is opened
-\> assigning the label in the Windows Explorer with the AIP unified labeling client does not remove the visual marking!
2. You must use the AIP unified labeling client and make sure it is enabled!
-\> I first ran into the issue that I installed the client but did not enable it correctly what resulted in the integrated labeling AddIn was used and the removal of the markings did not work
