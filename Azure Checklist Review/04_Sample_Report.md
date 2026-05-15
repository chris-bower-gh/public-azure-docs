# Azure Environment Review — Sample Report

**Customer:** Contoso Ltd  
**Assessment Date:** May 2026  
**Prepared By:** [Assessor Name]  
**Modules in Scope:** Core, Landing Zone, Cost Optimization, App Service, Azure SQL DB  

---

## 1. Executive Summary

An Azure environment review was conducted across 3 subscriptions for Contoso Ltd using Microsoft Azure Review Checklists tooling. The assessment covered platform foundations, cost management, and two key workload resource types identified during scoping.

**Overall posture: Moderate.** The environment has solid baseline security but has notable gaps in governance, cost controls, and app platform configuration.

| Priority | Count |
|---|---|
| Critical | 2 |
| High | 5 |
| Medium / Low | 8 |

**Top 3 recommendations:**
1. Enable diagnostic settings on all App Service apps — currently missing on 6 of 9 apps.
2. Implement Resource Group tagging policy — cost allocation is not possible without consistent tagging.
3. Review Azure SQL DB backup retention — 4 databases are set to 7-day retention with no long-term backup policy.

---

## 2. Modules Assessed

| Module | Decision | Reason |
|---|---|---|
| Core | Assessed | Mandatory baseline |
| Landing Zone | Assessed | Multiple subscriptions with limited management group structure |
| Cost Optimization | Assessed | Customer flagged cost overruns in last quarter |
| App Service | Assessed | 9 production App Service apps in scope |
| Azure SQL DB | Assessed | 4 Azure SQL Databases in scope |
| AKS | Not Applicable | No AKS resources found |
| API Management | Deferred | APIM migration planned Q3 2026 |

---

## 3. Findings

### Core Module

| # | Checklist Item | Status | Evidence | Impact | Recommendation | Priority | Effort |
|---|---|---|---|---|---|---|---|
| C1 | All resources have required tags (costCenter, environment, owner) | Non-Compliant | ARG query: 47 of 83 resources missing costCenter tag | Cost allocation and chargeback not possible | Deploy Azure Policy to enforce tagging on all resource groups | Critical | M |
| C2 | Reader access was scoped to target subscriptions only | Compliant | RBAC confirmed via Portal — Guest account with Reader on 3 subscriptions | — | No action | — | — |
| C3 | Backup policy exists for all production workloads | Partial | Recovery Services Vault present; 4 SQL DBs not covered | Data loss risk | Extend vault policy to cover SQL DBs | High | S |

---

### Landing Zone Module

| # | Checklist Item | Status | Evidence | Impact | Recommendation | Priority | Effort |
|---|---|---|---|---|---|---|---|
| LZ1 | Subscriptions assigned to Management Groups | Non-Compliant | All 3 subscriptions sit directly under Tenant Root | Policy enforcement and governance controls cannot be applied centrally | Create management group hierarchy and assign subscriptions | High | L |
| LZ2 | Azure Policy applied for compliance | Non-Compliant | No policies assigned beyond default | Drift and compliance gaps will grow undetected | Assign built-in policies for tagging, allowed locations, and diagnostic settings | High | M |
| LZ3 | Resource locks on production resource groups | Non-Compliant | No CanNotDelete locks found | Accidental deletion risk | Apply CanNotDelete lock to all production resource groups | High | S |
| LZ4 | Log Analytics workspace configured | Compliant | Single central workspace found in Management subscription | — | No action | — | — |

---

### Cost Optimization Module

| # | Checklist Item | Status | Evidence | Impact | Recommendation | Priority | Effort |
|---|---|---|---|---|---|---|---|
| CO1 | Budget alerts configured per subscription | Non-Compliant | No Cost Management budgets found | Cost overruns will not be detected proactively | Create monthly budgets with 80% and 100% alerts for each subscription | Critical | S |
| CO2 | Right-sizing review for underutilised VMs | Non-Compliant | Azure Advisor shows 3 VMs at <5% CPU utilisation over 30 days | Unnecessary spend | Review and resize or deallocate | High | S |
| CO3 | Reserved Instances or Savings Plans in use | Not Applicable | Workloads are all PaaS — no IaaS VMs committed long-term | — | Consider App Service Premium reservations if plans remain stable | Medium | S |
| CO4 | Dev/test subscriptions on Dev/Test pricing | Non-Compliant | 1 Dev subscription billed at production rates | Overpaying for dev workloads | Convert to Dev/Test offer | Medium | S |

---

### App Service Module

| # | Checklist Item | Status | Evidence | Impact | Recommendation | Priority | Effort |
|---|---|---|---|---|---|---|---|
| AS1 | Diagnostic settings enabled (logs to Log Analytics) | Non-Compliant | 6 of 9 App Service apps have no diagnostic settings | No visibility into app errors or access logs | Enable diagnostic settings on all apps; route to central Log Analytics workspace | High | S |
| AS2 | Always On enabled for production apps | Non-Compliant | 3 apps on Basic tier with Always On disabled | Cold start delays on low-traffic apps | Enable Always On or upgrade plan if budget allows | Medium | S |
| AS3 | Managed Identity used instead of connection strings | Compliant | All apps use Managed Identity for Key Vault access | — | No action | — | — |
| AS4 | Deployment slots used for production deployments | Non-Compliant | Direct production deployments observed | Zero-downtime deployment not possible | Implement staging slot + slot swap pattern | Medium | M |
| AS5 | Auto-scaling configured for production plans | Non-Compliant | 2 production plans have no scale-out rules | Performance degradation under load | Configure autoscale rules with CPU-based triggers | High | S |

---

### Azure SQL DB Module

| # | Checklist Item | Status | Evidence | Impact | Recommendation | Priority | Effort |
|---|---|---|---|---|---|---|---|
| SQL1 | Long-term backup retention enabled | Non-Compliant | All 4 databases set to 7-day point-in-time retention only | Cannot recover beyond 7 days; may breach data retention obligations | Enable long-term retention (weekly/monthly/yearly) per business requirements | High | S |
| SQL2 | Transparent Data Encryption (TDE) enabled | Compliant | TDE enabled on all databases (service-managed key) | — | No action | — | — |
| SQL3 | Azure Defender for SQL enabled | Non-Compliant | Defender for SQL not enabled on any database | Threat detection not active | Enable Microsoft Defender for SQL on all production databases | High | S |
| SQL4 | Private Endpoint used for database access | Compliant | All databases accessible via Private Endpoint only | — | No action | — | — |

---

## 4. Excluded Modules

| Module | Reason |
|---|---|
| AKS | No AKS resources found in scope |
| AVD | Not in use |
| Identity | Entra ID governance out of scope for this engagement |
| API Management | Deferred — APIM migration planned Q3 2026; recommend scheduling a focused review post-migration |

---

## 5. Recommended Next Steps

| Priority | Action | Owner | Timescale |
|---|---|---|---|
| Critical | Deploy tagging policy and remediate existing resources | Customer Platform Team | 2–4 weeks |
| Critical | Create Cost Management budgets for all subscriptions | Customer FinOps / Finance | 1 week |
| High | Create Management Group hierarchy and assign policies | Customer Platform Team | 4–6 weeks |
| High | Enable diagnostic settings on all App Service apps | Customer App Team | 1 week |
| High | Enable Defender for SQL and extend backup retention | Customer App Team | 1 week |

---

## 6. Appendix

### Subscriptions assessed
- `sub-contoso-prod-001`
- `sub-contoso-prod-002`
- `sub-contoso-dev-001`

### ARG queries used
- Core tagging check: `resources | where isnull(tags.costCenter) | project id, name, type, resourceGroup`
- App Service diagnostics: `resources | where type == 'microsoft.web/sites' | where isnull(properties.siteConfig.diagnosticsSettings)`
- SQL DB retention: `resources | where type == 'microsoft.sql/servers/databases' | project name, properties.retentionPolicy`

### Tooling used
- Azure Resource Graph Explorer (Portal)
- `checklist_graph.sh` — AKS, App Service, SQL DB modules
- Azure Cost Management (Portal)
- Azure Advisor (Portal)

---

*This report reflects the state of the environment at the time of assessment. It is not a certification or compliance sign-off. All findings should be validated by the customer before remediation begins.*
