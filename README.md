# Azure App Service Plan and App Service Environment in different subscriptions

This repository contains Terraform and Bicep code to deploy an Azure App Service Plan (ASP) and link it to an Azure Service Environment (ASE) across different Azure subscriptions. It is designed for developers and DevOps engineers who need to deploy scalable and isolated environments for web applications in Azure. 

A common use case for this is having a platform team that owns and maintains the ASE, while delivery teams use their own subscriptions to create ASPs for their apps and functions.

## Overview

The codebase includes two main files (Terraform and Bicep):

- `appServicePlan.tf` or `appServicePlan.bicep`: This file defines the resources needed to create an App Service Plan and a Linux web app within an Azure Resource Group. It leverages an existing App Service Environment by linking the ASP to the ASE using the ASE's ID.
- `aseDeployAspRbacRole.tf` or `aseDeployAspRbacRole.bicep`: This file creates a custom role definition in Azure that permits an App Service Plan to join an App Service Environment. This role is crucial for scenarios where the ASP and ASE reside in different Azure subscriptions, requiring specific permissions to associate the two resources securely and allowing the delivery teams to join their ASP to the ASE independently of the platform team.

## Prerequisites

Before using this repository, ensure you have the following:

- An Azure account with active subscriptions for both the ASP and ASE.
- Terraform installed on your local machine.
- Basic knowledge of Terraform syntax and Azure Resource Management.

