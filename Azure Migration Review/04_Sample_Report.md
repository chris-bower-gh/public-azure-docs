



Delivery Partner        |        Example Client

Migration Readiness Assessment \- Azure

# Document Control

__Customer Name:__ Example Client

__Order Type:__ Cloud Adoption Framework Strategy

__Order Number:__ SAMPLE-ENG-0001

__Admin Provisioning Lead:__ Delivery Lead

__Technical Provisioning Lead:__ Technical Lead

## Revision History

__Version__

Date

Author

Change Detail

1\.0

25/04/2025

Technical Lead

Created Assessment

## Document Review/Approval

Reviewer

Position

Review Date

Table of Contents	

[Document Control	2](#_Toc196834261)

[Revision History	2](#_Toc196834262)

[Document Review/Approval	2](#_Toc196834263)

[Executive Summary	4](#_Toc196834264)

[Assessment	5](#_Toc196834265)

[Hypervisors	5](#_Toc196834266)

[Virtual Machines	5](#_Toc196834267)

[Core Estate	5](#_Toc196834268)

[Citrix Estate	5](#_Toc196834269)

[Applications	6](#_Toc196834270)

[Azure	7](#_Toc196834271)

[Tenant	7](#_Toc196834272)

[Tenant Licensing	7](#_Toc196834273)

[Subscriptions	7](#_Toc196834274)

[Resources	7](#_Toc196834275)

[Proposed Solution	9](#_Toc196834276)

[Modernisations	9](#_Toc196834277)

[Modern Application Presentation	9](#_Toc196834278)

[Applications	9](#_Toc196834279)

[Database	10](#_Toc196834280)

[Databases Targeted for Modernisation	10](#_Toc196834281)

[Databases Remaining on Virtual Machines	10](#_Toc196834282)

[Resources	12](#_Toc196834283)

[Network	12](#_Toc196834284)

[Compute	13](#_Toc196834285)

[Storage	20](#_Toc196834286)

[Estimated Monthly Cost Projection	23](#_Toc196834287)

# Executive Summary

Migration Readiness Assessment is Delivery Partner’s in\-depth assessment service, designed to capture client requirements and provide a clear, structured path to Azure eliminating unexpected costs, risks, and technical surprises\. This service includes a comprehensive evaluation of existing infrastructure, an assessment of cloud readiness for servers and applications, and a detailed breakdown of migration costs\. By providing businesses with a clear understanding of their cloud journey, Migration Readiness Assessment helps them make informed decisions and avoid common pitfalls\.

Example Client is shifting its focus toward becoming a tech\-driven legal services business\. The goal of this transformation is to create a modern platform that enables faster application development, supports the creation of valuable IP, and strengthens the company's position for future M&A activity\. By improving developer velocity, accelerating deployment cycles and delivering a better experience for both internal users and clients the organisation aims to build an IT foundation that not only supports day\-to\-day operations but actively drives business growth and value creation\.



# Assessment 

To ensure that the transition to Azure is as seamless as possible and the platform is well prepared existing infrastructure will be assessed for suitability and readiness, as part of this assessment the following service have been reviewed:

- On\-Premises Infrastructure
	- Virtual Machines
		- Web servers
		- SQL server
		- File services
		- Citrix hosts
- Cloud Platform
	- Azure
		- Tenant configuration
		- Existing infrastructure

## Hypervisors

As the existing infrastructure is hosted by a 3rd party, no access to the Hypervisor has been provided for review\.

## Virtual Machines

The following virtual machines have been included within this review:

### Core Estate

| Hostname | Purpose | OS | Cores | Memory |
|---|---|---|---|---|
| IF-DEV-AI | AI/ML Development Workload (GPU Compute) | Ubuntu 22.04 | 8 | 32 |
| IF-DEV-PROCDB | Development Progress Database (Proclaim Dev) | Windows Server 2019 DC | 6 | 15.8 |
| IF-DEV-SQL | Development SQL Server 2022 (internal apps) | Windows Server 2022 Std | 4 | 32 |
| IF-VM-AI | Production AI/ML Compute | Ubuntu 22.04 | 16 | 32 |
| FS-PROD-01 | Central Fileserver (user shares, structured storage) | Windows Server 2019 DC | 4 | 16 |
| DB-LOB-PROD-01 | Production Progress Database (Proclaim live) | Windows Server 2019 DC | 12 | 64 |
| APP-WORKER-PROD-01 | Application compute node (task/worker server) | Windows Server 2019 DC | 8 | 16 |
| APP-WORKER-PROD-02 | Application compute node (task/worker server) | Windows Server 2019 DC | 8 | 16 |
| DB-SQL-PROD-01 | Production Microsoft SQL Server 2016 (live DB) | Windows Server 2019 DC | 8 | 64 |
| WEB-PROD-01 | Production Web Application Server (IIS/PHP/Mongo) | Windows Server 2019 DC | 8 | 32 |
| WEB-DEV-01 | Development Web Application Server (Dev copy) | Windows Server 2019 DC | 8 | 32 |
| ID-DC-01 | Primary Domain Controller (Active Directory) | Windows Server 2019 DC | 2 | 8 |
| ID-DC-02 | Secondary Domain Controller (Active Directory) | Windows Server 2019 DC | 2 | 8 |
| APP-ACCESS-01 | Door Access Control Server (Physical building access system) | Windows Server 2022 Std | 4 | 8 |
| APP-OCR-DEV-01 | Development OCR Server (likely for document processing) | Windows Server 2022 Std | 4 | 16 |
| APP-OCR-PROD-01 | Production OCR Server (live document processing) | Windows Server 2022 Std | 12 | 32 |
| INF-PRINT-01 | Print Server (for corporate printer management) | Windows Server 2019 Std | 2 | 4 |
| SEC-MON-01 | Barracuda XDR Monitoring Agent VM | Barracuda XDR | 4 | 8 |

### Citrix Estate

| Host count | Purpose | OS | Cores | Memory(GB) |
|---|---|---|---|---|
| 35 | Virtual Desktop Environment | Windows 10 | 8 | 44 |

## Applications

| Website name | Web server type | Framework | Framework version | Port | Migration blockers |
|---|---|---|---|---|---|
| BRM Portal | IIS | PHP | Unknown | 443 | 1 |
| BRM Portal DEV | IIS | PHP | Unknown | 443 | 1 |
| calnet | IIS | PHP | Unknown | 56635 | 2 |
| calnet web service | IIS | PHP | Unknown | 56635 | 3 |
| DEV | IIS | PHP | Unknown | 56630 | 3 |
| intra | IIS | PHP | 8.3.19 | 88 | 3 |
| intranet | IIS | PHP | 8.3.19 | 80 | 3 |
| Introducer Portal | IIS | PHP | 8.3.19 | 443 | 2 |
| Utility Service | IIS | PHP | Unknown | 80 | 0 |
| portal | IIS | PHP | 8.3.19 | 443 | 4 |
| REST API | IIS | PHP | Unknown | 443 | 2 |
| REST API DEV | IIS | PHP | Unknown | 443 | 0 |
| SOAP API | IIS | PHP | Unknown | 443 | 2 |
| ThirdFortGen2 | IIS | PHP | Unknown | 56637 | 1 |
| zzTFDeprecated | IIS | PHP | Unknown | 56636 | 1 |

## Azure

As the organisation already has a tenant, we have reviewed the current state of Azure, and the resources deployed\.

### Tenant

| Property | Value |
|---|---|
| Tenant ID | f468cdb1-3320-4392-855d-baa9845e2a20 |
| Tenant Name | exampletenant.onmicrosoft.com |

#### Data Locations

| Service | Region |
|---|---|
| Exchange Online | European Union |
| Exchange Online Protection | European Union |
| Microsoft Teams | United Kingdom |
| OneDrive | United Kingdom |
| SharePoint | United Kingdom |
| Viva Connections | European Union |

#### Domains

| Domain |
|---|
| exampletenant.onmicrosoft.com (Default) |
| disputelegal.co.uk |
| example-client.com |
| portal.example-client.com |
| exampletenant.emea.microsoftonline.com |
| example-legal.com |

### Tenant Licensing

| Product Title | Total Licenses | Assigned Licenses |
|---|---|---|
| Enterprise Mobility + Security E3 | 89 | 86 |
| Exchange Online (Plan 1) | 4 | 4 |
| Exchange Online (Plan 2) | 19 | 19 |
| Microsoft 365 Business Basic | 9 | 8 |
| Microsoft 365 Business Premium | 300 | 299 |
| Microsoft 365 Business Standard | 3 | 3 |
| Microsoft Copilot Studio Viral Trial | 10000 | 1 |
| Microsoft Fabric (Free) | Unlimited | 48 |
| Microsoft Power Apps for Developer | 10000 | 1 |
| Microsoft Power Automate Free | 10000 | 174 |
| Microsoft Teams Exploratory | 1 | 1 |
| Office 365 E3 | 91 | 91 |
| Planner and Project Plan 3 | 1 | 1 |
| Power BI Pro | 20 | 20 |
| Visio Plan 2 | 9 | 9 |

### Subscriptions

| Subscription Name | Description |
|---|---|
| az-cus-management | bc8393ba-9d71-4fda-bb65-e47a1cc765bd |
| CUS-AZ-STORAGE-SUB | 6f85c9bb-7d32-4cb7-ae08-195e1e19f9d0 |
| Customer Name - az-cus-connectivity | 0a7bbd89-bdfc-4d8c-8bf1-f14862794473 |
| Customer Name - az-cus-ilz | 46fa80fe-0984-4843-9953-2c79a9a6f675 |
| Customer Name - az-cus-infrastructure | e38deb84-2715-4337-9c99-516ac4f9b523 |

### Resources

| Name | Type | Resource Group | Location |
|---|---|---|---|
| coolgenpurpv2proarchive | Storage account | CUS-STOR-PROCLAIM-ARCHIVE | UK South |
| csb1003000097c70016 | Storage account | cloud-shell-storage-westeurope | West Europe |
| d22b5bad-7391-4b44-adc3-68931845e522 | Azure Workbook | man-loga-rg | UK South |
| man-la-iitc | Log Analytics workspace | man-loga-rg | UK South |
| man-loga-sentinel | Log Analytics workspace | man-loga-rg | UK South |
| man-vnt-1-28 | Virtual network | man-network-rg | UK South |
| NetworkWatcher_uksouth | Network Watcher | NetworkWatcherRG | UK South |
| filesync-archive-01 | Storage Sync Service | CUS-STOR-PROCLAIM-ARCHIVE | UK South |
| SecurityInsights(man-loga-sentinel) | Solution | man-loga-rg | UK South |

# Proposed Solution

Based on the current estate and the requirements for availability and resiliency the following proposals have been provided\.

## Modernisation

This section outlines key services that are being targeted for modernisation as part of Example Client’ platform transformation\. These workloads will be reevaluated for compatibility with Azure\-native services and re\-architected where appropriate to align with microservices, CI/CD pipelines, and containerised delivery models\.

### Modern Application Presentation

With Azure App Service handling application hosting, Azure Front Door and API Management provide a modern, secure, and scalable way to present web apps and APIs to users and systems, globally and efficiently\.

#### Azure Front Door

Azure Front Door acts as a global, high\-performance content delivery and routing layer that brings your web applications and APIs closer to end users improving speed, availability and protection\.

Key Benefits:

- Global load balancing with instant failover between regions
- Smart routing \(based on latency, location, or path\)
- Built\-in WAF \(Web Application Firewall\) for threat protection
- Custom domains and HTTPS termination at the edge

*Used to serve static sites, React frontends, or entire web apps from multiple regions with a single, public endpoint\.*

#### Azure API Management \(APIM\)

Azure API Management provides a centralised gateway for exposing internal APIs securely to front\-end apps, external partners or third\-party consumers\.

Key Benefits:

- Secure API publishing with authentication, rate limiting, and IP filtering
- Version control and lifecycle management of APIs
- Analytics and monitoring to track usage and performance
- Transformations and caching at the API layer \(e\.g\., rewrite URLs, mask fields\)

*Used to expose microservices\-based APIs from REST API, SOAP API or internal systems like Proclaim in a clean, governed way\.*

### Applications

#### Applications Targeted for Modernisation

These applications have been identified as candidates for re\-platforming or redevelopment using microservices principles\. The goal is to improve scalability, streamline deployment processes, and better support development velocity through loosely coupled, independently deployable components\.

| Application | Tech | Type | Port | Backend | Target Platform |
|---|---|---|---|---|---|
| BRM Portal | React | Web Front | 443 | Proclaim / SQL | Azure App Service (Web App) |
| BRM Portal DEV | React | Web Front | 443 | Proclaim / SQL | Azure App Service (Web App) |
| calnet web service | C# | Internal API | 56635 | SQL | Azure App Service |
| intra | React | Web Front | 88 | SQL | Azure App Service (Web App) |
| intranet | React | Web Front | 80 | SQL | Azure App Service (Web App) |
| Introducer Portal | React | Web Front | 443 | SQL | Azure App Service (Web App) |
| portal | React | Web Front | 443 | SQL | Azure App Service (Web App) |
| REST API | NodeJS | API | 443 | SQL / MongoDB | Azure App Service |
| REST API DEV | C# | API | 443 | SQL | Azure App Service |
| SOAP API | C# | API (Legacy) | 443 | SQL | Azure App Service |

The below diagram illustrates at a high level an example of the above with an application hosted through Front Door with backend access to SQL and MongoDB:



This move to App Services away from traditional IIS brings with it a extensive array of benefits, the key ones for CUS in this case are:

- Built\-in DevOps support with native CI/CD integration
- No server maintenance required, no patching, no IIS configs, no OS\-level security management
- Automatic scaling \(up and out\) based on real\-time demand
- Out\-of\-the\-box security features, including TLS/SSL, identity providers, and access restrictions
- Zero\-downtime deployments for smoother updates
- Deployment slots for staging, testing, and canary releases
- Deep integration with Azure ecosystem: Key Vault, Application Insights, Managed Identity, APIM, Azure Monitor

#### Applications Marked for Decommissioning

The following applications have been reviewed and are no longer required for ongoing operations\. These workloads will be decommissioned to reduce technical debt, simplify the future platform footprint, and eliminate unnecessary maintenance or licensing costs\.

| Application | Port | Reason / Notes |
|---|---|---|
| calnet | 56635 | Legacy; tied to Web2 stack |
| DEV | 56630 | Deprecated |
| Utility Service | 80 | No longer required |
| ThirdFortGen2 | 56637 | ML project, not in use |
| zzTFDeprecated | 56636 | Superseded; retired legacy |

### Database

#### Databases Targeted for Modernisation

These servers and databases have been identified as prime candidates for re\-architecture moving to PaaS based services, this reduces the administrative overhead whilst providing improved HA and flexibility\. 

| VM | Databases | Purpose | Modernisation Plan |
|---|---|---|---|
| DB-SQL-PROD-01 | LineOfBusinessDB, ReportServer, ReportServerTempDB | Production Databases | Migrate to **Azure SQL Managed Instance (SQL MI)** |
| if-dev-sql | LineOfBusinessDB | Development Databases | Migrate to **Azure SQL Database** |

#### Databases Remaining on Virtual Machines

| VM | Purpose | Migration Type |
|---|---|---|
| DB-LOB-PROD-01 | Proclaim Progress DB (Prod) | Lift and shift to Azure VM |
| DB-LOB-DEV-01 | Proclaim Progress DB (Dev) | Lift and shift to Azure VM |
| APP-OCR-DEV-01 | OCR Services | Lift and shift to Azure VM |
| APP-OCR-PROD-01 | OCR Services | Lift and shift to Azure VM |
| APP-ACCESS-01 | Door Control | Lift and shift to Azure VM |

These workloads are either too sensitive to latency \(e\.g\. Progress DB\) or not yet aligned with Azure\-native DB services\. They'll be rehosted on Azure VMs using managed disks and integrated into the backup and monitoring frameworks\.

### Developer Experience

This section outlines the changes required to support a modern development workflow within Example Client\. The current development approach is based on local environments with limited use of Git or version control practices\. This restricts collaboration, slows down release cycles and increases the risk of inconsistency across environments\.

To align with CUS’s platform modernisation goals, a new development operating model will be introduced using Azure DevOps\. This change will provide the development team with powerful, scalable tools and processes that support secure, repeatable delivery, enabling faster innovation and tighter integration between infrastructure, applications and product development\.

- Centralised source control using Git\-based repositories in Azure DevOps
- Build pipelines for continuous integration and code validation
- Release pipelines with approval gates and stage\-based deployments \(Dev, Test, Prod\)
- Automated environment provisioning to ensure consistency and reduce configuration drift
- Secure secrets handling via Azure Key Vault integration
- Work item linking and traceability from backlog to deployment
- Deployment standardisation across App Service, container\-based services and APIs

This new approach not only improves development velocity and reliability, but also supports auditability, scalability, and a future shift toward microservices\. It empowers the team to deliver faster, more predictably, and with greater alignment to business goals\.



## Resources

### Network

The network foundation ensures secure and efficient connectivity between on\-premises and cloud resources, leveraging Microsoft's best practices for scalability and security\.

- __Virtual WAN \(UK South & North Europe\)__
	- Centralized global transit networking service
	- Integrated Azure Firewall Premium for enhanced security
	- Site\-to\-Site VPN connectivity for hybrid cloud solutions
	- Scalable user VPN connections
- __Azure Firewall__
	- Enterprise\-grade firewall protection with advanced threat intelligence
	- Enforces network security policies across workloads
- __Private Endpoints & Private DNS__
	- Secure access to Azure services over private connections
	- Name resolution for private IPs within the cloud environment
- __Network Security Groups \(NSGs\) & Peering__
	- Granular control of inbound and outbound traffic
	- Optimized performance for cross\-region communication
- __Web and API presentation__
	- Global entry point for web applications
	- TLS termination, path\-based routing, and edge acceleration
	- Optimised delivery of React portals and web UIs
	- Centralised gateway for internal and external APIs
	- Secures traffic with rate limiting, IP filtering, and identity integration

### Compute

The compute layer delivers high\-performance virtual machines \(VMs\) optimized for workload requirements, with cost\-effective reserved pricing\.

- __Azure Virtual Desktop \(AVD\)__
	- Fully managed desktop and application virtualisation for ~350 users
	- FSLogix integrated for user profile management
	- Role\-based access control \(RBAC\) applied for secure, multi\-user environments
	- Two tiers of session hosts:
		- Medium Profile \(8 users/host\)
		- Power Profile \(6 users/host\)
- __Virtual Machines__
	- D8ds v5 \(8 vCPU, 32GB RAM\) – Optimised for AVD session hosts and high\-performance workloads \(3\-year reserved\)
	- D2ds v5 \(2 vCPU, 8GB RAM\) – Lightweight VM for supporting services \(3\-year reserved\)
	- D4ds v5 \(4 vCPU, 16GB RAM\) – Balanced compute for monitoring, domain controllers, and support services \(3\-year reserved\)
	- E8ds v5 \(8 vCPU, 64GB RAM\) – Used for database hosting \(Proclaim Progress DB workloads\)
- __SQL Managed Instance__

### Storage

Highly available and resilient storage solutions to support application data, backups, and disaster recovery\.

- __Azure Files \(UK South\)__
	- Premium SSD with ZRS \(UK South\) for FSLogix profile storage and file shares
	- LRS \(North Europe\) secondary region used for disaster recovery replication
	- Profile Storage: 30 GB per user \(~350 users\), dual\-region replication for resilience
	- General Fileshare: Azure Files \(Standard tier\) retained for non\-profile company data
- __Azure Backup \(UK South\)__
	- Geo\-Redundant Storage \(GRS\) for backup and disaster recovery
	- Automated backup policies for virtual machines and file storage
	- Retention policies to meet regulatory compliance
- __Azure Site Recovery__
	- Key VMs are replicated to North Europe as the designated DR region
	- Uses Locally Redundant Storage \(LRS\) in the target region
	- Enables fast recovery for mission\-critical systems in the event of a UK South outage

# Cloud Adoption Plan

A Cloud Adoption Plan outlines the strategic, technical, and operational roadmap for migrating Example Client from their legacy hosted infrastructure \(managed by third-party hosting provider\) to a secure, scalable, and future\-ready Microsoft Azure platform\. The plan was developed by Delivery Partner as part of a structured Launchpad engagement, leveraging Microsoft’s Cloud Adoption Framework \(CAF\)\.

The plan includes:

- Strategy Definition:

Business motivations, outcomes, and justification for cloud adoption, prioritised by impact\.

- Organisational Alignment:

Roles and responsibilities for internal teams and Delivery Partner, and a phased skills enablement plan\.

- Project Planning:

Backlog of adoption activities, from landing zone design and AVD architecture to cost modelling and governance setup\.

- Cloud Adoption Strategy Evaluator \(CASE\):

Structured analysis across 5 readiness pillars, motivation, outcome clarity, technical readiness, risk posture, and financial planning\.
  
This document serves as the foundation for CUS's cloud transformation, aligning business goals with technical execution\. It enables controlled, insight\-driven adoption of Azure with clear milestones, stakeholder ownership, and measurable outcomes\.

# Estimated Monthly Cost Projection

The estimated monthly cost for the proposed solution is __£25,452\.92__, with a potential variance of __±5%__ based on usage fluctuations, resource scaling, billing adjustments and excludes network bandwidth estimations\. 

This projection is based on __reserved instance pricing__, which will take effect once the project is fully deployed and configured\. Until reservations are in place, initial costs may be higher due to pay\-as\-you\-go rates\. The final pricing reflects an optimized commitment to __three\-year reserved instances__ where applicable, ensuring long\-term cost efficiency\.

Costs may vary depending on factors such as data egress, VM usage patterns, and additional security or compliance requirements\. Our team will continuously monitor and optimize these resources to maximize performance while maintaining cost\-effectiveness\.







