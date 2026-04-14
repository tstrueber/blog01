---
layout: post
title: "Remove visual marking label in Microsoft Information Protection"
date: 2023-07-10 00:00:00 +0200
categories: [Microsoft 365, Security]
tags: [Microsoft Information Protection, AIP, Sensitivity Labels, Word, PowerPoint]
description: "How to remove legacy visual markings in Word and PowerPoint during a migration to Microsoft Information Protection."
---

This post was originally published on my old blog and has been migrated here for archival purposes.

How to remove a visual label inside the header or footer of a Word document with the `WordShapeNameToRemove` function in the AIP Unified Labeling client.

![Article header image]({{ site.baseurl }}/assets/img/posts/mip-visual-marking/hero.jpeg)

## Introduction

In a recent customer project, documents had to be migrated from an older information protection solution named `Novapath` to Microsoft Information Protection. The project was part of a broader Microsoft 365 migration.

The classification level of the documents was stored not only in file metadata, but also visually in the footer of Word and PowerPoint documents. During the migration, those legacy visual markings needed to be removed when applying the new Microsoft Information Protection labels.

![Example of a legacy visual classification marking in Word]({{ site.baseurl }}/assets/img/posts/mip-visual-marking/classification-example.png)

## Show classification information

To inspect the existing classification information of a document, you have two options:

1. Extract the Office file with a tool like `7-Zip` and inspect the embedded metadata files.
2. Use PowerShell to read the custom document properties directly.

```powershell
$filename = "C:\Temp\Confidential Document.docx"
$zip = [System.IO.Compression.ZipFile]::Open($filename, 'Read')
$propsentry = $zip.GetEntry('docProps/custom.xml')

if ($propsentry -ne $null) {
    $stream = $propsentry.Open()
    $reader = New-Object System.IO.StreamReader $stream
    $content = $reader.ReadToEnd()
    $xmldoc = [xml]$content
    $xmldoc.Properties.property | Select-Object name, lpwstr
}

$zip.Dispose()
```

The output shows details such as the document ID, the classification client version, and the classification level.

![Example output showing classification metadata]({{ site.baseurl }}/assets/img/posts/mip-visual-marking/metadata-output.png)

## Custom configurations for the AIP unified labeling client

For the migration to Microsoft Information Protection, one important requirement was removing the legacy visual label. Microsoft provides functions in the Azure Information Protection Unified Labeling client for this purpose:

- [Word function `WordShapeNameToRemove`](https://learn.microsoft.com/en-us/azure/information-protection/rms-client/clientv2-admin-guide-customizations#wordshapenametoremove)
- [PowerPoint function `PowerPointRemoveAllShapesByShapeName`](https://learn.microsoft.com/en-us/azure/information-protection/rms-client/clientv2-admin-guide-customizations#powerpointremoveallshapesbyshapename)

### Remove label from Word documents

To use `WordShapeNameToRemove`, you first need to determine the name of the shape that contains the old label.

In Word, open the **Selection Pane** from the **Home** tab and then switch into the **Header & Footer** area if the label was inserted there. In my example, the relevant shape name was:

![Word selection pane showing where to inspect the inserted shape]({{ site.baseurl }}/assets/img/posts/mip-visual-marking/word-selection-pane.png)

```text
novaPathWDBox_1_0
```

![Word header and footer view showing the legacy shape name]({{ site.baseurl }}/assets/img/posts/mip-visual-marking/word-shape-name.png)

After checking documents with different classification levels, I found that the same shape name was used consistently. That meant the same setting could be applied across all affected documents.

To roll out this custom configuration, update the sensitivity label policy that is assigned to users:

```powershell
Connect-IPPSSession
$labelpolicy = "Global sensitivity label policy"
Set-LabelPolicy -Identity $labelpolicy -AdvancedSettings @{WordShapeNameToRemove="novaPathWDBox_1_0"}
```

When a user opens a document and applies the new Microsoft Information Protection label, the client removes the old visual marking automatically.

### Remove label from PowerPoint documents

The corresponding PowerPoint function is `PowerPointRemoveAllShapesByShapeName`. The approach is very similar.

In my case, the label was placed in the slide master, so I first identified the shape name used there. After that, I updated the same label policy with the PowerPoint-specific setting:

![PowerPoint slide master showing the legacy shape name]({{ site.baseurl }}/assets/img/posts/mip-visual-marking/powerpoint-shape-name.png)

```powershell
Connect-IPPSSession
$labelpolicy = "Global sensitivity label policy"
Set-LabelPolicy -Identity $labelpolicy -AdvancedSettings @{PowerPointRemoveAllShapesByShapeName="novaPathPPTBox"}
```

Once configured, applying a new sensitivity label in PowerPoint removes the old legacy marking in the same way as in Word.

## Check the rollout of the custom configuration on the Office client

After updating the policy, allow some time for the cloud configuration to propagate and for the Office client to download the updated settings.

To speed up testing on a client:

1. Close all Office applications.
2. Delete the locally cached policy file from:

```text
%LOCALAPPDATA%\Microsoft\Office\CLP
```

There is a user-specific policy file in that folder. After deleting it and starting Word again, the client downloads the latest configuration from the service.

In my case, it took around 10 minutes until the updated configuration was reflected on the client.

![Client-side policy cache showing the updated configuration]({{ site.baseurl }}/assets/img/posts/mip-visual-marking/client-policy-cache.png)

## Test the removal of the visual markings

To verify the result, I opened a Word document that still had the old `Internal` marking and then assigned a new sensitivity label such as `General` using the AIP Unified Labeling client.

![Word document before applying the new sensitivity label]({{ site.baseurl }}/assets/img/posts/mip-visual-marking/word-before.png)

After applying the new label, the old footer marking disappeared immediately.

![Word document after applying the new sensitivity label]({{ site.baseurl }}/assets/img/posts/mip-visual-marking/word-after.png)

PowerPoint behaved the same way: as soon as the new label was assigned, the legacy visual marking was removed.

![PowerPoint presentation before applying the new sensitivity label]({{ site.baseurl }}/assets/img/posts/mip-visual-marking/powerpoint-before.png)

![PowerPoint presentation after applying the new sensitivity label]({{ site.baseurl }}/assets/img/posts/mip-visual-marking/powerpoint-after.png)

## Limitations of the solution

1. The removal only works when assigning the label while the document is open.
2. Assigning the label in Windows Explorer with the AIP Unified Labeling client does not remove the visual marking.
3. You must use the AIP Unified Labeling client and ensure that it is actually enabled.

I initially ran into an issue where the client was installed, but not enabled correctly. In that case, the integrated labeling add-in was used instead, and the visual markings were not removed.

## Source

Original article:

- [Remove Header or Footer insert from other Labeling Solution in Microsoft Information Protection](https://strueberit.de/remove-header-or-footer-insert-from-other-labeling-solution-in-microsoft-information-protection/)
