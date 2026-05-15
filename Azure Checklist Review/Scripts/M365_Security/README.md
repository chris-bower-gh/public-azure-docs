# M365 Security Assessment — ScubaGear

**Purpose:** Automated M365 tenant security baseline assessment, run as optional supplementary evidence to Azure Checklist Review engagements

**Tool:** [ScubaGear](https://github.com/cisagov/ScubaGear) (CISA SCuBA assessment framework)  
**Last Updated:** May 2026

---

## Overview

ScubaGear assesses Microsoft 365 tenant configuration against **CISA Secure Cloud Business Applications (SCuBA)** baselines. Assessment results map to NIST SP 800-53 and MITRE ATT&CK frameworks and are output as interactive HTML report + CSV data.

**Scope:** Entra ID (Identity), Security Suite (threat protection), Exchange Online, Teams, SharePoint, Power Platform, Power BI  
**Effort:** 1–2 hours (assessment + report generation)  
**Output:** Compliance report, JSON/CSV exports for evidence curation into review findings

---

## Prerequisites

- **Windows 10/11 with PowerShell 5.0+** (Windows PowerShell or PowerShell 7+)
- **Azure CLI** (`az` command) or **Graph API access** (Microsoft Graph permissions)
- **M365 tenant Global Admin or Security Reader** account
- **Internet connectivity** to M365 APIs
- **Disk space:** ~500 MB for ScubaGear installation and dependencies

---

## Installation

### 1. Install ScubaGear from PowerShell Gallery

```powershell
# Run as Administrator
Install-Module -Name ScubaGear -Repository PSGallery -Force
```

### 2. Initialize Dependencies

```powershell
# Install required dependencies (OPA, Regal, Graph modules, etc.)
Initialize-SCuBA
```

### 3. Verify Installation

```powershell
# Check version
Invoke-SCuBA -Version
```

---

## Configuration

### Option A: Quick Start (No Configuration File)

Run ScubaGear without custom configuration for baseline tenant posture:

```powershell
# Authenticate interactively and run assessment on all products
Invoke-SCuBA -Organization "contoso.onmicrosoft.com"
```

**Output:** Generated to `.\ScubaResults\` folder (HTML report + JSON/CSV files)

---

### Option B: Custom Configuration (YAML)

For production assessments or compliance submissions, use a YAML configuration file to:
- Define which M365 products to assess
- Exclude known risk acceptances
- Customize pass/fail criteria

#### Sample Configuration File

Create `scuba-config.yaml`:

```yaml
---
# ScubaGear Configuration — Contoso Ltd M365 Review
# Generated: May 2026

ProductNames:
  - AAD              # Entra ID (Identity)
  - SecuritySuite   # Threat protection (Defender)
  - ExchangeOnline  # Email
  - Teams           # Communication
  - SharePoint      # Document collaboration

AADConfig:
  ProductName: AAD

SecuritySuiteConfig:
  ProductName: SecuritySuite

ExchangeConfig:
  ProductName: ExchangeOnline

TeamsConfig:
  ProductName: Teams

SharePointConfig:
  ProductName: SharePoint
```

#### Run with Configuration

```powershell
# Authenticate and run with custom config
Invoke-SCuBA -ConfigFilePath ".\scuba-config.yaml" `
  -Organization "contoso.onmicrosoft.com"
```

---

## Running Assessment

### 1. Prepare for Authentication

Ensure you have a Global Admin or Security Reader account with M365 tenant access.

```powershell
# Authenticate to M365
Connect-MgGraph -Scopes "Directory.Read.All"
```

### 2. Run Assessment

```powershell
# Using YAML config file (recommended for production)
Invoke-SCuBA -ConfigFilePath ".\scuba-config.yaml" `
  -Organization "contoso.onmicrosoft.com"

# Or quick run without config
Invoke-SCuBA -Organization "contoso.onmicrosoft.com"
```

### 3. Monitor Progress

Assessment typically runs 5–15 minutes depending on tenant size and product scope. Progress is written to console and log file.

---

## Output & Interpretation

### Generated Files

After successful run, outputs are in `.\ScubaResults\`:

| File | Purpose |
|---|---|
| `BaselineReports.html` | Interactive compliance report — open in browser |
| `ScubaResults.json` | Structured assessment results (all controls + pass/fail) |
| `ScubaResults.csv` | Spreadsheet format for filtering and analysis |
| `ScubaResults-*-summary.json` | Per-product compliance summary |

### Reading the HTML Report

1. **Open** `BaselineReports.html` in your browser
2. **Filter by status:** Non-Compliant (failures) → prioritize for findings
3. **Review control details:** Expand each finding to see evidence and remediation guidance
4. **Cross-reference:** Note NIST 800-53 mapping and MITRE ATT&CK technique IDs

### Extracting Evidence for Review Report

1. Open HTML report → filter for **Non-Compliant** controls
2. For each finding:
   - **Control name** (e.g., "Require MFA for all users")
   - **Baseline requirement** (from SCuBA policy doc)
   - **Current state** (what ScubaGear found)
   - **Risk impact** (if any)
   - **Remediation** (recommended action)
3. Export finding rows from CSV and paste into your review report M365 security findings section
4. Reference NIST 800-53 control ID in appendix for traceability

---

## Example: Integrating into Review Report

### In Review Findings Section

Add a new M365 Security Module findings table:

```markdown
### M365 Security Module (Optional)

| # | Baseline Control | Status | Evidence | Impact | Recommendation | Priority |
|---|---|---|---|---|---|---|
| M365-1 | Require MFA for all users | Non-Compliant | 47 of 312 users have MFA disabled | Credential compromise risk | Enable MFA on all user accounts; use conditional access policies | Critical |
| M365-2 | External sharing restrictions | Partial | SharePoint allows sharing with external users; Teams guest access not restricted | Over-sharing risk | Restrict external sharing to approved domains; audit guest access policies | High |

*Source: ScubaGear assessment; [NIST 800-53 IA-2](https://csrc.nist.gov/publications/detail/sp/800-53/rev-5) (Authentication)*
```

### In Appendix

Add M365 baseline reference:

```markdown
#### M365 Security Assessment (ScubaGear)

Assessment run date: May 15, 2026  
Baseline framework: CISA SCuBA v2.0  
Products assessed: Entra ID, Exchange Online, Teams, SharePoint  
Control-to-NIST mapping: [NIST 800-53 Revision 5](https://csrc.nist.gov/publications/detail/sp/800-53/rev-5)  
Full results: See attached `ScubaResults.json` and `BaselineReports.html`
```

---

## Troubleshooting

### "Microsoft Graph module not found"

```powershell
# Install Graph module
Install-Module -Name Microsoft.Graph -Force
```

### Authentication fails

```powershell
# Verify you're signed in to M365 tenant
Get-MgContext

# If not connected, authenticate
Connect-MgGraph -Scopes "Directory.Read.All", "Exchange.Read.All"
```

### "OPA not found" error

```powershell
# Re-run initialization
Initialize-SCuBA

# Or manually update ScubaGear
Update-ScubaGear
```

---

## References

- **ScubaGear GitHub:** https://github.com/cisagov/ScubaGear
- **SCuBA Baselines:** https://cisa.gov/scuba
- **NIST 800-53 Revision 5:** https://csrc.nist.gov/publications/detail/sp/800-53/rev-5
- **MITRE ATT&CK:** https://attack.mitre.org

---

## Related Documentation

- [Azure Checklist Review — Methodology](../01_Review_Methodology.md)
- [Resource Audit Guide](../03_Resource_Audit_Guide.md) — includes M365 assessment section
- [Sample Report](../04_Sample_Report.md) — includes M365 findings example
