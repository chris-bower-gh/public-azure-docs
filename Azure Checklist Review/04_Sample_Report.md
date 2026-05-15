# Azure Environment Review — Sample Report

**Customer:** Contoso Ltd  
**Assessment Date:** May 2026  
**Prepared By:** [Assessor Name]  
**Modules in Scope:** Core, Landing Zone, Cost Optimization, App Service, Azure SQL DB, M365 Security  

---

## 1. Executive Summary

An Azure environment review was conducted across 3 subscriptions for Contoso Ltd using Microsoft Azure Review Checklists tooling. The assessment covered platform foundations, cost management, and two key workload resource types identified during scoping.

**Overall posture: Moderate.** The environment has solid baseline security but has notable gaps in governance, cost controls, and app platform configuration.

| Priority | Count |
|---|---|
| Critical | 3 |
| High | 6 |
| Medium / Low | 9 |

**Top 3 recommendations:**
1. Enable MFA on all user accounts (M365) — currently 47 of 312 users have MFA disabled; critical identity risk.
2. Implement Resource Group tagging policy — cost allocation is not possible without consistent tagging.
3. Enable diagnostic settings on all App Service apps — currently missing on 6 of 9 apps.

---

## 2. Modules Assessed

| Module | Decision | Reason |
|---|---|---|
| Core | Assessed | Mandatory baseline |
| Landing Zone | Assessed | Multiple subscriptions with limited management group structure |
| Cost Optimization | Assessed | Customer flagged cost overruns in last quarter |
| App Service | Assessed | 9 production App Service apps in scope |
| Azure SQL DB | Assessed | 4 Azure SQL Databases in scope |
| M365 Security | Assessed | M365 tenant in scope; included for security baseline (CISA SCuBA) |
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
| CO2 | Right-sizing review for underutilised VMs | Non-Compliant | Azure Advisor shows 3 VMs at <5% CPU utilisation over 30 days — see Utilisation Data Extracts appendix for per-VM metrics | Unnecessary spend | Review and resize or deallocate; validate against scheduled workloads before actioning | High | S |
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

### M365 Security Module

| # | SCuBA Baseline Control | Status | Evidence | Impact | Recommendation | Priority | Effort |
|---|---|---|---|---|---|---|---|
| M365-1 | Require MFA for all users | Non-Compliant | ScubaGear: 47 of 312 users (15%) have MFA disabled; includes 8 privileged accounts | Credential compromise risk; privileged account takeover | Enable MFA on all user accounts; use Conditional Access to enforce for admin roles first | Critical | S |
| M365-2 | Prevent external sharing of sensitive data | Partial | SharePoint: external sharing enabled; Teams: guest access not restricted to approved domains | Over-sharing risk; data exfiltration | Restrict SharePoint external sharing to approved domains only; audit Teams guest policies | High | M |
| M365-3 | Enable advanced threat protection | Non-Compliant | Defender for Office 365 not enabled on any mailbox | No email threat detection | Enable Defender for Office 365 on all Exchange Online mailboxes | High | S |
| M365-4 | Audit logging enabled | Compliant | Unified Audit Log enabled; retention policy set to 90 days | — | No action | — | — |
| M365-5 | Enforce strong password policy | Non-Compliant | No custom password policy configured; using Azure AD default (12-char minimum) | Weak password enforcement | Configure custom password policy: 14+ characters, complexity requirements | Medium | S |

*Source: CISA SCuBA assessment via ScubaGear; controls mapped to [NIST 800-53 Revision 5](https://csrc.nist.gov/publications/detail/sp/800-53/rev-5) in Appendix.*

---

## 4. Excluded Modules

| Module | Reason |
|---|---|
| Identity (Entra ID deep-dive) | High-level Entra ID security baseline covered by M365 Security module; additional identity governance assessment can be deferred |
| AKS | No AKS resources found in scope |
| AVD | Not in use |
| API Management | Deferred — APIM migration planned Q3 2026; recommend scheduling a focused review post-migration |

---

## 5. Recommended Next Steps

| Priority | Action | Owner | Timescale |
|---|---|---|---|
| Critical | Enable MFA on all user accounts — particularly 8 privileged admin accounts (M365-1) | Customer Identity / Security Team | 1 week |
| Critical | Deploy tagging policy and remediate existing resources | Customer Platform Team | 2–4 weeks |
| Critical | Create Cost Management budgets for all subscriptions | Customer FinOps / Finance | 1 week |
| High | Create Management Group hierarchy and assign policies | Customer Platform Team | 4–6 weeks |
| High | Enable diagnostic settings on all App Service apps | Customer App Team | 1 week |
| High | Enable Defender for SQL and extend backup retention | Customer App Team | 1 week |
| High | Enable Defender for Office 365 on all mailboxes (M365-3) | Customer Identity / Security Team | 1 week |

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
- Phase 2 Inventory scripts (`Scripts/Phase2_Inventory/`) — KQL + PowerShell
- Phase 3 Utilisation scripts (`Scripts/Phase3_Utilisation/`) — PowerShell
- **ScubaGear** (Microsoft 365 security baseline assessment) — M365 Security module

---

### How Audit Data is Collected

Findings in this report were produced using manual checklist review, portal inspection, and — where supplementary evidence was needed — script-based inventory and utilisation data collection, plus automated M365 security assessment. There is no automated pipeline for Azure data; M365 data flows from ScubaGear assessment into the report through manual curation by the assessor.

| Step | Method |
|---|---|
| Azure KQL queries (`Scripts/Phase2_Inventory/*.kql`) | Paste into Azure Resource Graph Explorer → run → click **Download results** to export CSV |
| Azure PowerShell inventory scripts (`Scripts/Phase2_Inventory/*.ps1`) | Run in authenticated PowerShell session → CSVs written to `.\output\` folder |
| Azure PowerShell utilisation scripts (`Scripts/Phase3_Utilisation/*.ps1`) | Run in authenticated PowerShell session → CSVs written to `.\output\` folder |
| M365 security assessment (ScubaGear) | `Invoke-SCuBA` with YAML config → generates HTML report + JSON/CSV results |
| Report integration | Assessor opens all results/outputs, identifies rows relevant to findings, and pastes sample rows as evidence tables in this appendix |

---

### Inventory Data Extracts

The tables below are sample extracts from Phase 2 inventory scripts. Full output CSVs are retained in the `.\output\` folder.

**Virtual Machines** (`Scripts/Phase2_Inventory/02-virtual-machines.kql`)

| Name | Size | PowerState | ResourceGroup | Subscription |
|---|---|---|---|---|
| vm-contoso-sql-01 | Standard_D4s_v3 | running | rg-data-prod | sub-contoso-prod-001 |
| vm-contoso-jump-01 | Standard_B2s | running | rg-mgmt | sub-contoso-prod-002 |
| vm-contoso-legacy-01 | Standard_D2s_v3 | running | rg-legacy | sub-contoso-prod-001 |
| vm-contoso-build-01 | Standard_D2s_v3 | deallocated | rg-dev | sub-contoso-dev-001 |

**App Service Plans** (`Scripts/Phase2_Inventory/04-app-service-plans.kql`)

| Name | SKU | OS | AppCount | WorkerCount | Subscription |
|---|---|---|---|---|---|
| asp-contoso-prod | P2v3 | Windows | 5 | 1 | sub-contoso-prod-001 |
| asp-contoso-prod-2 | P1v3 | Windows | 3 | 1 | sub-contoso-prod-001 |
| asp-contoso-dev | B2 | Windows | 1 | 1 | sub-contoso-dev-001 |

*Note: asp-contoso-dev is a Basic tier plan — Always On is not available on this tier. Finding AS2 identifies 3 apps on Basic tier plans.*

---

### Utilisation Data Extracts

The tables below are sample extracts from Phase 3 utilisation scripts. Full output CSVs are retained in the `.\output\` folder. Metrics cover a 30-day look-back period.

**VM CPU and Memory Utilisation** (`Scripts/Phase3_Utilisation/02-vm-metrics.ps1`)

| Name | Metric | AvgPct | MaxPct | Subscription |
|---|---|---|---|---|
| vm-contoso-sql-01 | Percentage CPU | 2.1 | 8.4 | sub-contoso-prod-001 |
| vm-contoso-sql-01 | Available Memory % | 89.2 | 92.1 | sub-contoso-prod-001 |
| vm-contoso-jump-01 | Percentage CPU | 0.8 | 3.2 | sub-contoso-prod-002 |
| vm-contoso-jump-01 | Available Memory % | 78.4 | 83.1 | sub-contoso-prod-002 |
| vm-contoso-legacy-01 | Percentage CPU | 3.4 | 11.7 | sub-contoso-prod-001 |
| vm-contoso-legacy-01 | Available Memory % | 82.6 | 88.0 | sub-contoso-prod-001 |

*All three production VMs show sustained CPU below 5% — consistent with the Azure Advisor finding CO2. Resize or deallocation should be validated against scheduled workloads before actioning.*

**App Service Plan Utilisation** (`Scripts/Phase3_Utilisation/04-app-service-metrics.ps1`)

| Plan | Metric | AvgPct | MaxPct | Subscription |
|---|---|---|---|---|
| asp-contoso-prod | CpuPercentage | 4.2 | 18.6 | sub-contoso-prod-001 |
| asp-contoso-prod | MemoryPercentage | 67.3 | 81.4 | sub-contoso-prod-001 |
| asp-contoso-prod-2 | CpuPercentage | 1.8 | 9.4 | sub-contoso-prod-001 |
| asp-contoso-prod-2 | MemoryPercentage | 38.1 | 52.7 | sub-contoso-prod-001 |

*asp-contoso-prod shows low CPU but elevated average memory (67%). Memory pressure — rather than CPU — may be the relevant trigger for autoscale rules (see finding AS5).*

---

### M365 Security Assessment (ScubaGear)

**Assessment Details**

| Attribute | Value |
|---|---|
| Assessment Tool | ScubaGear v1.8.0 (CISA) |
| Baseline Framework | Secure Cloud Business Applications (SCuBA) v2.0 |
| M365 Products Assessed | Entra ID, Exchange Online, Teams, SharePoint, Security Suite |
| Assessment Date | May 15, 2026 |
| Audit Log | See `ScubaResults.json` (full control evaluation details) |
| Control Mapping | NIST 800-53 Revision 5; MITRE ATT&CK Framework |

**Compliance Summary**

| Status | Count |
|---|---|
| Compliant | 1 |
| Non-Compliant | 3 |
| Partial | 1 |

**Key Findings**

- **M365-1 (MFA):** 47 users without MFA; 8 are privileged accounts — immediate remediation required
- **M365-3 (Defender for Office 365):** No threat protection on mailboxes — enables email-based attacks
- **M365-5 (Password Policy):** Using default weak policy; no custom enforcement

See M365 Security Module findings (above) for full control details and recommendations.

---

*This report reflects the state of the environment at the time of assessment. It is not a certification or compliance sign-off. All findings should be validated by the customer before remediation begins.*
