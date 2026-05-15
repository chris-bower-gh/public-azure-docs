# Azure Environment Review Methodology
## MSP Runbook - Modular Delivery Model

**Version:** 1.1  
**Date:** May 2026  
**Audience:** Internal Delivery and Consulting Teams  
**Last Updated:** May 15, 2026

---

## 1. Purpose

This runbook defines a simplified and modular way to run Azure environment reviews using Microsoft Azure Review Checklists.

The method is designed so only relevant checklist areas are assessed for each customer.

**Optional Enhancement:** Supplement checklist findings with comprehensive resource inventory and utilisation data. See [03_Resource_Audit_Guide.md](03_Resource_Audit_Guide.md) for details.

### Core principles
- Read-only assessment only
- Microsoft-native tools only
- Customer-approved scope before execution
- Data minimization and least privilege access
- Modular selection: include only applicable checklist modules

---

## 2. Delivery Model

Every engagement uses:

1. **Core Module (mandatory)**
2. **Optional Modules (selected per customer profile)**

This replaces a one-size-fits-all assessment.

### 2.1 Core Module (always in scope)

The Core Module establishes baseline governance and evidence quality:

- Subscription and scope validation
- RBAC and access confirmation (Reader or equivalent)
- Tagging and inventory baseline
- Basic security and backup posture checks
- Documentation quality and operational ownership checks

### 2.2 Optional Modules (selected per customer)

Optional modules are only added when the relevant resource type or practice area is present and material to the customer. They are grouped below by category to simplify selection.

---

#### Category A — Platform Foundations

| Module | Use when | Checklist file |
|---|---|---|
| Landing Zone | Customer has multiple subscriptions, weak governance, or is remediating platform foundations | `alz_checklist.en.json` |
| Well-Architected (WAF) | Customer needs a cross-pillar architecture maturity review | `waf_checklist.en.json` |
| Cost Optimization | Customer has budget controls, FinOps goals, or cost pressure | `cost_checklist.en.json` |
| Identity | Entra ID, RBAC, or privileged access concerns are in scope | `identity_checklist.en.json` |
| Security | Security posture, Defender, or compliance review required | `security_checklist.en.json` |
| Resiliency | Customer needs availability/DR review beyond WAF coverage | `resiliency_checklist.en.json` |

---

#### Category B — Compute and App Services

| Module | Use when | Checklist file |
|---|---|---|
| App Service | Customer runs web apps or APIs on App Service / App Service Plan | `appsvc_checklist.en.json` |
| Azure Functions | Customer uses serverless/event-driven workloads | `azfun_checklist.en.json` |
| AKS | Customer runs production or strategic AKS workloads | `aks_checklist.en.json` |
| Container Apps | Customer uses Azure Container Apps for microservices | `container_apps_checklist.en.json` |
| Azure Spring Apps | Customer has Spring-based Java workloads | `azurespringapps_checklist.en.json` |
| Azure Red Hat OpenShift | Customer runs ARO clusters | `aro_checklist.en.json` |
| Service Fabric | Customer uses Service Fabric clusters | `servicefabric_checklist.en.json` |

---

#### Category C — Data and Storage

| Module | Use when | Checklist file |
|---|---|---|
| Azure SQL DB | Customer has Azure SQL Database workloads | `sqldb_checklist.en.json` |
| SQL (Managed Instance) | Customer uses SQL Managed Instance | `sql_checklist.en.json` |
| MySQL | Customer runs MySQL Flexible Server | `mysql_checklist.en.json` |
| PostgreSQL | Customer runs PostgreSQL Flexible Server | `postgreSQL_checklist.en.json` |
| Cosmos DB | Customer uses Cosmos DB for globally distributed data | `cosmosdb_checklist.en.json` |
| Azure Cache for Redis | Customer uses Redis caching layer | `redis_checklist.en.json` |
| Storage | Customer has significant Azure Storage account usage | `azure_storage_checklist.en.json` |
| Databricks | Customer runs Databricks analytics workloads | `databricks_checklist.en.json` |
| Synapse Analytics | Customer uses Synapse for data warehousing or pipelines | `synapse_checklist.en.json` |
| Azure Data Factory | Customer uses ADF for ETL/data integration | `adf_checklist.en.json` |
| Stream Analytics | Customer processes real-time streaming data | `streamanalytics_checklist.en.json` |
| Data Security | Customer has data classification or sovereignty requirements | `datasecurity_checklist.en.json` |

---

#### Category D — Integration and Messaging

| Module | Use when | Checklist file |
|---|---|---|
| API Management | Customer exposes APIs via APIM | `apim_checklist.en.json` |
| Service Bus | Customer uses Service Bus for messaging | `servicebus_checklist.en.json` |
| Event Hubs | Customer uses Event Hubs for streaming ingestion | `eh_checklist.en.json` |
| Logic Apps | Customer has Logic Apps integrations or workflows | `logic_app_checklist.en.json` |

---

#### Category E — Networking

| Module | Use when | Checklist file |
|---|---|---|
| Azure Front Door | Customer uses AFD for global load balancing or WAF | `afd_checklist.en.json` |
| App Delivery / Load Balancing | Customer uses Application Gateway, Traffic Manager, or similar | `network_appdelivery_checklist.en.json` |
| DNS | Custom DNS, Private DNS Zones, or DNS security in scope | `dns_checklist.en.json` |

---

#### Category F — Security and Governance

| Module | Use when | Checklist file |
|---|---|---|
| Key Vault | Customer uses Key Vault for secrets, keys, or certificates | `keyvault_checklist.en.json` |
| Recovery Services Vault | Customer backup and site recovery posture needs review | `recoveryservicesvault_checklist.en.json` |
| Microsoft Purview | Customer requires data governance or cataloguing review | `purview_checklist.en.json` |
| Multitenancy | Customer operates shared or SaaS-style tenant patterns | `multitenancy_checklist.en.json` |
| AI Landing Zone | Customer is building or scaling AI/ML workloads | `ai_lz_checklist.en.json` |

---

#### Category G — Hybrid and Infrastructure

| Module | Use when | Checklist file |
|---|---|---|
| Azure Virtual Desktop | Customer runs AVD estates | `avd_checklist.en.json` |
| Azure VMware Solution | Customer is migrating or running VMware on Azure | `avs_checklist.en.json` |
| Azure Arc | Customer uses Arc for hybrid server or Kubernetes management | `azure_arc_checklist.en.json` |
| Azure Stack HCI | Customer runs HCI infrastructure | `hci_checklist.en.json` |
| SAP on Azure | Customer runs SAP workloads | `sap_checklist.en.json` |

---

#### Category H — Developer and DevOps Tooling

| Module | Use when | Checklist file |
|---|---|---|
| Azure Container Registry | Customer has significant container image management requirements | `acr_checklist.en.json` |
| Azure DevOps | Customer uses ADO for pipelines and project delivery | `ado_checklist.en.json` |

---

## 3. Module Selection Process

Apply the following gate before any technical execution.

### 3.1 Applicability Gate

For each optional module, classify as:

- **Applicable**: Include in assessment scope
- **Not Applicable**: Exclude with reason
- **Deferred**: Relevant but out of scope for this phase

### 3.2 Minimum selection artifacts

Record these in the engagement notes:

1. In-scope subscriptions and resource groups
2. Selected modules and rationale
3. Excluded modules and rationale
4. Known constraints (time, access, data sensitivity)

### 3.3 Example module decision table

| Category | Module | Decision | Reason |
|---|---|---|---|
| Core | Core | Applicable | Mandatory baseline |
| A — Platform | Landing Zone | Applicable | Multiple subscriptions and weak governance signals |
| A — Platform | Cost Optimization | Applicable | Customer flagged cost overruns |
| B — Compute | App Service | Applicable | Customer runs multiple production App Service apps |
| B — Compute | AKS | Not Applicable | No AKS resources found in scope |
| C — Data | Azure SQL DB | Applicable | Several Azure SQL Databases in scope |
| C — Data | Cosmos DB | Not Applicable | Not used |
| D — Integration | API Management | Deferred | APIM migration planned next quarter |
| G — Hybrid | AVD | Not Applicable | All desktops are on-premises |

---

## 4. Simplified Execution Flow

### Phase 1: Initiation and Scope (0.5 day)

1. Confirm signed engagement and read-only authorization
2. Validate access and subscription visibility
3. Finalize module selection

```powershell
# Access smoke test
az graph query -q "resources | limit 1"
```

### Phase 2: Evidence Collection (0.5-2 days depending on modules)

1. Run Core Module queries/checks
2. Run selected optional module checks only
3. Capture evidence in a standard findings format

```powershell
# Example: switch subscription
az account set --subscription "Customer-Subscription-ID"

# Example: basic inventory signal for missing cost tags
az graph query -q "resources | where isnull(tags.costCenter) | project id, name, type"
```

### Phase 3: Analysis and Prioritization (0.5-1 day)

1. Map findings to selected modules
2. Set status per item: Compliant, Non-Compliant, Not Applicable
3. Prioritize: Critical, High, Medium/Low

### Phase 4: Reporting (0.5 day)

1. Executive summary
2. Findings by selected module
3. Excluded/deferred module list for transparency
4. Recommended next-wave modules (if any)

---

## 5. Standard Findings Format

Use this structure for every finding:

- Module
- Checklist item reference
- Status
- Evidence
- Impact
- Recommendation
- Priority
- Effort estimate (S/M/L)

This keeps reports consistent even when module combinations differ between customers.

---

## 6. Data Handling and Tooling Constraints

### 6.1 Data and security
- No customer changes performed
- No secrets/keys exported
- Results handled as point-in-time snapshots
- RBAC controls determine visible resources

### 6.2 Allowed tools
- Azure Portal
- Azure Resource Graph
- Azure CLI
- Azure PowerShell modules
- Azure Monitor and Log Analytics (if customer-approved)

No third-party AI or external SaaS tools are used for customer tenant data processing.

---

## 7. Roles and Accountability

### Engagement Lead
- Confirms authorization, scope, and module decisions
- Owns customer communication

### Technical Assessor
- Executes Core and selected optional modules
- Captures defensible evidence

### Report Author
- Consolidates findings into customer-ready output
- Makes module applicability explicit

### Quality Assurance
- Checks finding accuracy, consistency, and prioritization quality

---

## 8. Quick Start

### Required setup
```powershell
# Azure CLI
winget install Microsoft.AzureCLI

# Azure PowerShell modules
Install-Module -Name Az -AllowClobber -Force

# Review checklists
git clone https://github.com/Azure/review-checklists.git
```

### Validation commands
```powershell
az account list --output table
az graph query -q "resources | limit 1"
```

---

## 9. Change Log

| Version | Date | Changes |
|---|---|---|
| 1.1 | May 2026 | Simplified structure and introduced modular Core plus Optional model |
| 1.0 | May 2026 | Initial version |

---

**Document Owner:** [Your Name/Team]  
**Next Review Date:** [Date + 12 months]  
**Questions/Updates:** [Internal contact info]
