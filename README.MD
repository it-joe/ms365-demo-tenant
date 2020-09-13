# MS365DemoTenant
Author: [it-joe](https://github.com/it-joe)

> Configures an existing tenant for demo purposes. Includes rich, demo-ready sample content (document libraries, emails, OneDrive contents, Yammer posts, etc.). 

## Prerequisites 

* Configure your Office 365 trial subscription:<br>
https://docs.microsoft.com/en-us/microsoft-365/enterprise/lightweight-base-configuration-microsoft-365-enterprise#phase-1-create-your-office-365-e5-subscription
* Add a Microsoft 365 E5 trial subscription:<br>
https://docs.microsoft.com/en-us/microsoft-365/enterprise/lightweight-base-configuration-microsoft-365-enterprise#phase-3-add-a-microsoft-365-e5-trial-subscription
* Install the Azure Active Directory PowerShell for Graph:
    ``` PowerShell
    PS> Install-Module AzureAD
    ```
* Install the Microsoft Azure Active Directory Module for Windows PowerShell:
    ``` PowerShell
    PS> Install-Module MSOnline
    ```
* Install the 64-bit version of the Microsoft Online Services Sign-in Assistant:<br>
https://go.microsoft.com/fwlink/p/?LinkId=286152

> **Note:**<br>
PowerShell Core does not support the Microsoft Azure Active Directory Module for Windows PowerShell module and cmdlets with Msol in their name.<br>
Therefore, please use Windows PowerShell 5.1 for installing above modules and to run the MS365DemoTenant module.

## Installing

### Import the module

Once cloned, you can import the module using:

``` PowerShell
PS> Import-Module <PathToRepo>\MS365DemoTenant
```
