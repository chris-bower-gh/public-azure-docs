# Azure Review Checklists — Quick Guide
## How to Run the Tools

**Version:** 1.0  
**Last Updated:** May 15, 2026  
**Audience:** Technical Assessors

---

## Overview

There are two ways to use the Azure Review Checklists tooling. Use whichever best fits the engagement:

| Method | Best for | Where it runs |
|---|---|---|
| Excel spreadsheet | Most engagements; easy to share findings with customers | Local Windows machine |
| `checklist_graph.sh` script | Automated ARG scanning; bulk evidence collection | Azure Cloud Shell (Bash) |

Both methods use the same underlying checklist content. They are complementary — the script output is designed to feed directly into the spreadsheet.

---

## Method 1: Excel Spreadsheet

### One-time setup

1. Download the macro-enabled spreadsheet from the latest release:  
   `https://github.com/Azure/review-checklists/releases/latest/download/review_checklist.xlsm`

2. Before opening, right-click the file in Windows Explorer → **Properties** → tick **Unblock** → OK.  
   This is required for macros to run. Without it, Excel will block the file entirely.

3. Open the file and enable macros when prompted.

### Running a checklist review

1. In the spreadsheet, use the dropdown to select the **Technology** (e.g. `AKS`, `App Service`, `Azure SQL DB`) and **Language** (`English`).
2. Click **Import latest checklist** and accept the prompt. The checklist loads from GitHub automatically.
3. Go row by row setting the **Status** column:
   - `Compliant`
   - `Non-Compliant`
   - `Not Applicable`
4. Add notes in the **Comments** column — record evidence, resource names, or rationale for N/A decisions.
5. Check the **Dashboard** worksheet for a visual summary of progress.

> **Tip:** Work pillar by pillar (e.g. all Security rows, then all Reliability rows) rather than top to bottom. This keeps context consistent and speeds up decision-making.

### Importing ARG script results (optional)

If you have run the `checklist_graph.sh` script (see Method 2) and exported JSON output, you can import it:

1. With the matching checklist loaded in the spreadsheet, click **Advanced → Import Graph Results**.
2. Select the `.json` file produced by the script.
3. The **Comments** column will populate automatically with compliant/non-compliant resource IDs.

---

## Method 2: `checklist_graph.sh` Script (Azure Cloud Shell)

This script runs the ARG queries embedded in each checklist automatically across your subscriptions or management group.

> **Important:** This script requires a **Bash** shell. Use [Azure Cloud Shell](https://shell.azure.com/) and select the **Bash** environment, not PowerShell.

### One-time setup

Run this in Azure Cloud Shell to download and prepare the script:

```bash
wget -q -O ./checklist_graph.sh \
  https://raw.githubusercontent.com/Azure/review-checklists/main/scripts/checklist_graph.sh
chmod +x ./checklist_graph.sh
```

### Core commands

**List all available checklists:**
```bash
./checklist_graph.sh --list-technologies
```

**List the categories within a checklist (useful for scoped reviews):**
```bash
./checklist_graph.sh --technology=aks --list-categories
```

**Run all checks for a technology and output to console:**
```bash
./checklist_graph.sh --technology=aks --format=text
```

**Run all checks and export results to JSON (recommended for report building):**
```bash
./checklist_graph.sh --technology=aks --format=json > aks_graph_results.json
```

**Scope to a single category only:**
```bash
./checklist_graph.sh --technology=aks --category=1 --format=text
```

**Scope to a Management Group (runs across all subscriptions within it):**
```bash
./checklist_graph.sh --technology=aks --management-group=<mgmt-group-name> --format=json > aks_results.json
```

**Enable debug output if something looks wrong:**
```bash
./checklist_graph.sh --technology=aks --format=json --debug
```

### Technology names for common modules

| Module | `--technology` value |
|---|---|
| Azure Landing Zone | `alz` |
| AKS | `aks` |
| App Service | `appsvc` |
| Azure Functions | `azfun` |
| Azure SQL DB | `sqldb` |
| Cosmos DB | `cosmosdb` |
| API Management | `apim` |
| Key Vault | `keyvault` |
| Azure Front Door | `afd` |
| AVD | `avd` |
| SAP | `sap` |
| Cost Optimization | `cost` |
| WAF | `waf` |

> Not all checklists have ARG queries. Run `--list-technologies` to see the current supported list.

---

## Typical Workflow Per Engagement

```
1. Set subscription context
   az account set --subscription "<Customer-Subscription-ID>"

2. Run script for each selected module
   ./checklist_graph.sh --technology=appsvc --format=json > appsvc_results.json
   ./checklist_graph.sh --technology=sqldb  --format=json > sqldb_results.json

3. Open spreadsheet, load matching checklist

4. Import JSON results via Advanced → Import Graph Results

5. Complete remaining rows manually (items without ARG queries)

6. Export findings for report
```

---

## Notes

- The script queries Azure Resource Graph only — it does not make changes to any resources.
- RBAC: the account used in Cloud Shell needs **Reader** role on the subscriptions or management group being queried.
- Not all checklist items have automated ARG queries. Manual review is still required for the remainder.
- The JSON output from the script is intended for import into the spreadsheet. It is not human-readable on its own.
