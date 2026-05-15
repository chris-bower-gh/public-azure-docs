# Azure Review Checklists — Resource Audit Data Collection
## Supplementing Best Practice Reviews with Inventory and Utilisation Data

**Version:** 1.0  
**Last Updated:** May 15, 2026  
**Purpose:** Optional supplementary data gathering for review assessments using reusable audit scripts

---

## Overview

The **Azure Review Checklists** assess compliance with best practices and architectural recommendations. Optionally, you can supplement checklist findings with deeper resource audit data:

1. **What resources exist** and how they're configured (inventory audit)
2. **How well they're being used** (utilisation patterns)

This document maps reusable audit scripts to the review modules. A complete assessment can include:

| Component | Purpose |
|---|---|
| **Checklist** | Compliance gaps against Azure best practices |
| **Inventory Audit** (optional) | Complete asset register with configuration details |
| **Utilisation Data** (optional) | 30-day usage patterns for efficiency assessment |
| **Report** | Consolidated findings: compliance gaps, config audit, utilisation insights |

---

## When Audit Data is Useful

### Checklist Review Only
- Customer has strict time constraints (< 1 day)
- Customer wants compliance and best practice recommendations only
- Configuration details and resource-level audit are out of scope

**Scope:** Core + 1–2 optional checklist modules  
**Effort:** 1–2 days  
**Output:** Best practice compliance gaps and recommendations

---

### Checklist + Inventory Audit
- Customer wants an asset register and configuration consistency audit
- Time allows for 2–3 day engagement
- Focus is on governance, tagging, naming standards, RBAC, configuration drift
- Resource utilisation data not needed

**Scope:** Core + Inventory audit data for selected resource types  
**Effort:** 2–3 days  
**Output:** Checklist findings + detailed asset register with config audit

---

### Checklist + Inventory + Utilisation Data
- Comprehensive review with efficiency assessment
- Full 4–5 day engagement
- Resources have sufficient history (30+ days of metrics)

**Scope:** Core + all optional modules + full inventory and utilisation data  
**Effort:** 4–5 days  
**Output:** Compliance gaps + asset register + utilisation analysis + efficiency recommendations

---

### M365 Security Audit (Optional Add-on)
- Customer operates M365 and wants security baseline assessment alongside Azure review
- Can be run independently of Azure assessment or combined for holistic tenant review
- Time allows for 1–2 additional days for M365 tenant assessment

**Scope:** Entra ID, Exchange Online, Teams, SharePoint, Power Platform security posture against CISA SCuBA baselines  
**Tool:** [ScubaGear](https://github.com/cisagov/ScubaGear) — automated M365 compliance assessment  
**Effort:** 1–2 days (can run in parallel with Azure assessment)  
**Output:** M365 security compliance report (HTML + CSV) mapped to NIST SP 800-53 + MITRE ATT&CK

See **M365 Security Assessment** section below for setup and usage.

---

## Available Audit Scripts

Reusable data collection scripts are located in the repo at `scripts/phase2-inventory/` and `scripts/phase3-utilisation/`. You can copy these to a separate location for use in reviews (not tied to the FinOps engagement process).

Two script types:

| Type | Location | Runtime | Output |
|---|---|---|---|
| **Inventory scripts** | `scripts/phase2-inventory/` | KQL in Azure Portal Resource Graph Explorer OR PowerShell CLI | CSV with resource config snapshot |
| **Utilisation scripts** | `scripts/phase3-utilisation/` | PowerShell CLI | CSV with 30-day metrics (CPU, memory, throughput, etc.) |

---

## Module-to-Scripts Mapping

This table shows which audit scripts provide data for each review module. Scripts are tool-agnostic and can be run independently of any FinOps engagement.

---

### Category A — Platform Foundations

#### Landing Zone Module
| Audit Script | What it collects | How it supports checklist |
|---|---|---|
| (Manual ARG queries) | Management Group hierarchy, Policy assignments, RBAC roles | Validate checklist governance items with portal evidence |

#### Cost Optimization Module
| Audit Script | What it collects | How it supports checklist |
|---|---|---|
| `log-analytics-ingestion.ps1` | Log Analytics daily GB ingestion by table (30 days) | Evidence for data retention and ingestion cost checklist items |

---

### Category B — Compute and App Services

#### App Service Module
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| `04-app-service-plans.kql` | SKU, tier, OS type, app count, worker count | Evidence for tier and capacity checklist items |

| Utilisation Script | What it collects | How it supports checklist |
|---|---|---|
| `04-app-service-metrics.ps1` | 30-day CPU %, memory % (hourly averages) | Validates whether tier is appropriately sized for actual demand |
| `04-app-service-metrics-deepdive.ps1` | 7-day 1-min granularity CPU/memory, percentiles, headroom | Detailed utilisation analysis; confirms tier adequacy |

#### Azure Functions Module
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| (Manual portal audit) | Function app plans, runtime version, diagnostic settings | Checklist ARG queries + manual evidence gathering |

#### AKS Module
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| (Manual CLI audit) | Node pools, VM sizes, autoscale settings, network policy | Checklist ARG queries + manual configuration audit |

#### Container Apps Module
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| (Manual portal audit) | Container Apps environments, memory/CPU allocations, scale rules | Checklist ARG queries + manual configuration audit |

---

### Category C — Data and Storage

#### Azure SQL DB Module
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| (Manual ARG query) | Server names, database editions, DTU/vCore, zone redundancy | Validate checklist config items |

#### SQL Elastic Pools Module
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| `01-sql-elastic-pools.kql` | Edition, DTU/vCore capacity, storage, zone redundancy, member DB count | Evidence for capacity and redundancy checklist items |
| `01-sql-elastic-pools-server-names.kql` | Server names (support data for utilisation queries) | Prerequisite for utilisation analysis |

| Utilisation Script | What it collects | How it supports checklist |
|---|---|---|
| `01-sql-pool-metrics.ps1` | 30-day hourly CPU %, DTU %, storage % | Validates tier appropriateness and capacity headroom |
| `01-sql-pool-metrics-deepdive.ps1` | 7-day 1-min DTU %, percentiles, spike detection | Confirms whether apparent underutilisation masks batch workloads |

#### MySQL, PostgreSQL Modules
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| (Manual portal audit) | SKU, compute/storage tiers, HA configuration, backup retention | Checklist validation + manual evidence |

#### Cosmos DB Module
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| (Manual portal audit) | RUs provisioned, autoscale settings, replication regions | Checklist validation + manual evidence |

#### Redis Module
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| (Manual portal audit) | SKU, memory size, clustering mode, replication | Checklist validation + manual evidence |

#### Storage Accounts Module
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| `07-storage-accounts.kql` | SKU, kind (Blob/File/Queue/Table), access tier (hot/cool/archive) | Evidence for redundancy and access tier checklist items |

#### Data Factory Module
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| `12-data-factory.kql` | Instance count, provisioning state | Inventory snapshot |
| `12-data-factory-ir.ps1` | Integration Runtime types (Managed VNET, Azure, Self-Hosted) | Config audit for network/security checklist items |

| Utilisation Script | What it collects | How it supports checklist |
|---|---|---|
| `12-data-factory-pipeline-runs.ps1` | 30-day run counts, failure rate, last status | Validates whether ADF is actively used vs. idle |

---

### Category D — Integration and Messaging

#### API Management Module
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| (Manual portal audit) | SKU, policy count, backend pool config | Checklist validation + manual evidence |

#### Service Bus Module
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| `05-service-bus.kql` | Tier (Standard/Premium), SKU, capacity, messaging entities | Evidence for tier and throughput checklist items |

| Utilisation Script | What it collects | How it supports checklist |
|---|---|---|
| `05-servicebus-metrics.ps1` | 30-day incoming/outgoing messages, active message counts | Validates tier appropriateness for actual throughput demand |

#### Event Hubs Module
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| (Manual portal audit) | Tier, partition count, retention settings | Checklist validation + manual evidence |

#### Logic Apps Module
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| `13-logic-apps.kql` | Standard instances and their App Service Plan host | Linkage audit for deployment model checklist items |

---

### Category E — Networking

#### Azure Front Door Module
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| `15-frontdoor.kql` | SKU, provisioning state, backend pool config | Evidence for tier and backend selection checklist items |

#### App Delivery / Load Balancing Module
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| `15-app-gateway-frontdoor.kql` | App Gateway SKU, tier, capacity | Evidence for tier and capacity checklist items |
| `15-app-gateway-backends.kql` | Backend pool membership; identifies empty pools | Config audit: unused backend pools consuming resources |

#### DNS Module
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| (Manual ARG query) | DNS zone count, record types, TTL | Checklist validation + manual evidence |

---

### Category F — Security and Governance

#### Key Vault Module
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| (Manual portal audit) | Vault tier, access policy vs RBAC, secret/key/cert counts | Checklist validation + manual evidence |

#### Recovery Services Vault Module
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| `16-backup-vaults.kql` | Redundancy (GRS vs LRS), cross-region restore setting | Evidence for redundancy and disaster recovery checklist items |
| `16-backup-retention.ps1` | Retention policies per backup: daily, weekly, monthly, yearly | Config audit for retention compliance checklist items |

---

### Category G — Hybrid and Infrastructure

#### Azure Virtual Desktop Module
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| `19-avd-hostpools.kql` | MaxSessionLimit, load balancer type (BreadthFirst/DepthFirst), pool type | Config audit for load balancing checklist items |
| `19-avd-orphaned-hosts.kql` | AVD VMs not registered to a host pool (orphaned) | Audit finding: orphaned hosts (configuration drift) |

| Utilisation Script | What it collects | How it supports checklist |
|---|---|---|
| `19-avd-utilisation.kql` | Active sessions vs. capacity over time (via Log Analytics) | Validates pool load balancing strategy effectiveness |

#### Azure VMware Solution Module
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| (Manual portal audit) | Cluster node count, SKU, replication config | Checklist validation + manual evidence |

#### Virtual Machines Module
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| `02-virtual-machines.kql` | Size, power state, attached disks | Inventory audit; flags powered-off VMs (unintended waste) |

| Utilisation Script | What it collects | How it supports checklist |
|---|---|---|
| `02-vm-metrics.ps1` | 30-day CPU %, available memory | Validates whether VM sizing matches actual workload demand |

#### Managed Disks Module
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| `03-managed-disks.kql` | SKU, size, attachment status, throughput/IOPS | Inventory audit; flags unattached disks (orphaned storage) |

| Utilisation Script | What it collects | How it supports checklist |
|---|---|---|
| `03-managed-disk-metrics.ps1` | 30-day max/avg IOPS and throughput; FitsStdSSD flag | Efficiency assessment: Premium to Standard tier appropriateness |

#### Azure Firewall Module
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| `08-azure-firewall.kql` | Tier (Standard/Premium), policy linkage | Tier validation against checklist items |
| `08-azure-firewall-diagnostics.ps1` | Diagnostic settings (Resource Graph unreliable for these) | Audit finding: missing diagnostic settings |

#### Virtual Network Module
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| `06-virtual-network.kql` | VNet peerings, public IPs, load balancers, NAT gateways, private endpoints | Network architecture audit against connectivity checklist items |

#### Virtual WAN Module
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| `11-virtual-wan.kql` | Hubs, VPN gateways, P2S gateways, provisioning state | Hub and gateway inventory for connectivity checklist items |

| Utilisation Script | What it collects | How it supports checklist |
|---|---|---|
| `virtual-wan-hub-traffic.ps1` | 30-day total data processed per hub | Validates hub utilisation; flags unused hubs |

#### Azure Bastion Module
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| `17-bastion.kql` | Bastion hosts, SKU tier, deployment method | Audit for Azure Bastion presence and tier alignment |

---

## M365 Security Assessment

### Overview

For customers with M365 workloads, **ScubaGear** provides automated security baseline assessment and can complement your Azure checklist review. ScubaGear queries M365 APIs, evaluates security configuration against **CISA SCuBA baselines**, and produces compliance reports (HTML, CSV, JSON).

**Key features:**
- Assessments against NIST SP 800-53 and MITRE ATT&CK mapped controls
- Support for Entra ID, Exchange Online, Teams, SharePoint, Power Platform, Security Suite
- Automated policy evaluation using Open Policy Agent (OPA)
- Risk acceptance workflows via YAML configuration
- Output: Interactive HTML report + structured CSV for manual curation into review findings

### ScubaGear Setup & Usage

See `Scripts/M365_Security/README.md` for:
- Installation and prerequisites
- Quick-start PowerShell commands
- YAML configuration template
- How to interpret and integrate M365 findings into your review report

### When to Include M365 Assessment

| Scenario | Include M365? |
|---|---|
| Azure-only infrastructure, no M365 | No — out of scope |
| M365 tenant but low security priority | Optional — note in report as deferred |
| Holistic tenant security review | Yes — run in parallel with Azure assessment for comprehensive findings |
| Compliance/audit engagement (e.g., BOD 25-01) | Yes — required if M365 in scope |

### Output Integration

M365 findings follow the same manual curation pattern as Azure data:
1. Run ScubaGear → generates HTML report + CSV results
2. Open report, filter for non-compliant controls
3. Extract relevant evidence rows → paste into your review findings
4. Cross-reference to NIST 800-53 / MITRE ATT&CK in appendix
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| `17-bastion.kql` | SKU tier (Developer/Basic/Standard) | Tier validation against access and scale checklist items |

---

### Category H — Developer and DevOps Tooling

#### Azure Container Registry Module
| Inventory Script | What it collects | How it supports checklist |
|---|---|---|
| (Manual portal audit) | SKU, geo-replication, webhook count | Checklist validation + manual evidence |

---

## Typical Full-Scope Engagement Workflow

```
Phase 1 — Scoping (0.5 day)
├─ Define in-scope review modules
├─ Identify resource types for inventory audit
└─ Decide: Checklist only vs. Inventory+Metrics included

Phase 2a — Download & Prepare (0.5 day)
├─ Clone FinOps repo locally
├─ Configure FinOps/scripts/config.ps1 with customer subscriptions
├─ Download cost exports from portal (for context, optional)
└─ Prepare checklist module files

Phase 2b — Run Inventory Scripts (1 day)
├─ Run FinOps Phase 2 scripts for selected modules (KQL + PS1)
│  (e.g., App Service, SQL DB, VM, Disks, Storage)
└─ Export results to CSVs

Phase 2c — Run Checklist ARG Queries (0.5 day)
├─ Run checklist_graph.sh for each selected module
│  (e.g., appsvc, sqldb, waf, cost, lz)
└─ Export to JSON for spreadsheet import

Phase 3 — Manual Review + Metrics (1 day)
├─ Open Excel checklist spreadsheet
├─ Import ARG results → Comments column auto-populates
├─ Manually assess remaining items (no ARG queries)
└─ Add config context from FinOps inventory

Phase 3b — Utilisation Metrics (optional, 1 day)
├─ Run FinOps Phase 3 metrics scripts for flagged resources
└─ Note findings for report

Phase 4 — Consolidate & Report (1 day)
├─ Compile checklist findings
├─ Cross-reference with inventory audit (orphaned resources, config drift)
├─ Add utilisation insights (right-sizing, retirement candidates)
└─ Deliver report

Total effort: 2–5 days (depending on scope)
```

---

## Quick Reference: Scripts by Module

| Review Module | Inventory Scripts | Utilisation Scripts | Comments |
|---|---|---|---|
| App Service | `04-app-service-plans.kql` | `04-app-service-metrics.ps1` + deepdive | Run deepdive if metrics flag underutilisation |
| Azure SQL DB | `01-sql-elastic-pools.kql` (if pools) | `01-sql-pool-metrics.ps1` (if pools) | Inventory only if no elastic pools |
| Storage Accounts | `07-storage-accounts.kql` | — | Configuration audit only |
| Virtual Machines | `02-virtual-machines.kql`, `03-managed-disks.kql` | `02-vm-metrics.ps1`, `03-managed-disk-metrics.ps1` | Both inventory and utilisation recommended |
| Service Bus | `05-service-bus.kql` | `05-servicebus-metrics.ps1` | Validate tier appropriateness |
| AVD | `19-avd-hostpools.kql`, `19-avd-orphaned-hosts.kql` | `19-avd-utilisation.kql` | Orphaned hosts audit highlights drift |
| Virtual Networks | `06-virtual-network.kql` | — | Network architecture audit |
| Azure Firewall | `08-azure-firewall.kql`, `08-azure-firewall-diagnostics.ps1` | — | Diagnostic settings critical |
| Log Analytics | `10-log-analytics.kql`, `10-app-insights.kql` | `log-analytics-ingestion.ps1` | Ingestion validation |
| Data Factory | `12-data-factory.kql`, `12-data-factory-ir.ps1` | `12-data-factory-pipeline-runs.ps1` | Active vs. idle assessment |

---

## Report Structure

If you include audit data alongside checklist findings, structure the report with these sections:

**1. Compliance & Best Practice (Checklist findings)**
- Each checklist item: Status, Evidence, Impact, Recommendation

**2. Asset & Configuration Audit (Inventory data)**
- Resource inventory by type (counts, SKUs, tiers)
- Configuration consistency findings (tagging, redundancy, diagnostics)
- Drift and anomalies (orphaned resources, unattached disks, unused backends)

**3. Efficiency Assessment (Utilisation data, optional)**
- Underutilised resources (if 30+ days of metrics collected)
- Current vs. allocated capacity
- Performance headroom validation

---

## Notes

- **Not all resources have audit scripts.** For those, use checklist ARG queries + manual portal audit.
- **Utilisation metrics require 30+ days of history.** For new environments, omit or note the constraint.
- **Deepdive scripts** (marked `-deepdive`) are only necessary after an initial screen flags a resource. Run only when warranted.
- **Orphaned resource scripts** (like `19-avd-orphaned-hosts.kql`, unattached disks, empty backends) are high-value audit findings.
