# Azure Migration Review — Assessment Execution Guide

**Purpose:** Provide a practical runbook for delivering the assessment engagement and assembling the final sample report from interviews, evidence, tooling outputs, and engineering analysis.

## Delivery Model
The assessment is run as a short discovery engagement, but report assembly is driven by a fixed output format. The practical execution model is to work backwards from [04_Sample_Report.md](Azure Migration Review/04_Sample_Report.md) and collect only the evidence required to complete each section credibly.

A standard execution flow is:

1. Mobilise the engagement and confirm scope
2. Gather documents, exports, and stakeholder inputs
3. Analyse the current estate and identify patterns
4. Draft current-state findings and migration paths
5. Define the target-state platform and operating model
6. Build cost and adoption-planning outputs
7. Package findings into the final report

## Inputs Required
Before analysis begins, request the following where available:

- Current server and application inventories
- Existing Azure tenant and subscription exports
- Licensing summaries and service usage data
- Architecture diagrams and network diagrams
- Backup and disaster recovery information
- Application portfolios and business criticality notes
- Current delivery process information for development teams
- Any existing migration readiness, security, or operational review outputs

## Stakeholders to Engage
The guide assumes involvement from a cross-functional stakeholder group:

- Infrastructure or hosting owner
- Network and security owner
- Application owner or engineering lead
- Database owner
- Service desk or operations lead
- Business sponsor or transformation lead
- Commercial or financial stakeholder for cost alignment

## Execution Workflow
### Step 1: Confirm Engagement Scope
Document the target business outcomes, scope boundaries, critical systems, and assumptions. Confirm whether the engagement is focused on rehost, broader modernisation, or a hybrid outcome.

Record:

- Business drivers
- In-scope workloads
- Out-of-scope areas
- Known constraints
- Required report audience

### Step 2: Build the Evidence Register
Create a working evidence register so every conclusion in the report can be traced back to a source. Each evidence entry should include:

- Source type
- Date received
- Owner
- Coverage area
- Quality or confidence level
- Notes on gaps or validation needs

### Step 3: Run Current-State Discovery
Capture the estate in the same broad structure used later in the report:

- Hypervisors or hosting model
- Virtual machines and server roles
- VDI or desktop estate
- Applications and interfaces
- Azure tenant, subscriptions, and resources
- Identity, licensing, and operational services

Where estate data is incomplete, use interviews and supplied lists to create a usable inventory with assumptions clearly stated.

### Step 4: Analyse Workloads and Dependencies
For each major service or application, determine:

- What the service does
- Whether it is business critical
- Which data platform it depends on
- Whether it is internet-facing, internal-facing, or user-session based
- Whether it is a candidate for rehost, replatform, refactor, or retirement

This analysis directly drives the Applications, Database, and Proposed Solution sections of the report.

### Step 5: Review Existing Azure Footprint
Assess the tenant and platform baseline in order to establish what already exists and what must be built or remediated.

Review:

- Tenant identity and domain configuration
- Subscription model and environment separation
- Resource inventory by purpose and region
- Monitoring, logging, and security services already deployed
- Gaps relative to a target landing zone model

### Step 6: Define the Target Platform Narrative
Translate the findings into a target-state design narrative that explains:

- How applications should be presented and secured
- Which workloads stay on virtual machines
- Which move to App Service or managed database services
- How connectivity, resilience, and disaster recovery are handled
- Which engineering and operating model changes are required

This step produces the core narrative for the Proposed Solution and Resources sections.

### Step 7: Build the Indicative Cost Model
Create a service-oriented cost model rather than a simple server-cost translation. Group costs into major service towers such as:

- Network
- Compute
- Storage
- Platform services
- Backup and disaster recovery
- Monitoring and management

Capture assumptions clearly, including regions, reservation terms, redundancy, and consumption estimates.

### Step 8: Produce the Cloud Adoption Plan Summary
Summarise the non-technical delivery requirements needed to move from assessment to execution. This should include:

- Strategy and motivation alignment
- Team roles and responsibilities
- Platform and landing zone priorities
- Delivery sequencing themes
- Capability uplift requirements

### Step 9: Assemble the Final Report (Exact 04 Structure)
The final sample report should be assembled in this order to match [04_Sample_Report.md](Azure Migration Review/04_Sample_Report.md):

1. Document Control
2. Revision History
3. Document Review/Approval
4. Executive Summary
5. Assessment
6. Assessment > Hypervisors
7. Assessment > Virtual Machines > Core Estate / Citrix Estate
8. Assessment > Applications
9. Assessment > Azure > Tenant / Tenant Licensing / Subscriptions / Resources
10. Proposed Solution
11. Proposed Solution > Modernisation > Modern Application Presentation
12. Proposed Solution > Applications (Modernisation + Decommission)
13. Proposed Solution > Database (Modernise vs Remain on VM)
14. Proposed Solution > Developer Experience
15. Resources > Network
16. Resources > Compute
17. Resources > Storage
18. Cloud Adoption Plan
19. Estimated Monthly Cost Projection

## Backward Build Checklist (How 04 Is Actually Produced)
Use this checklist to ensure execution reflects the final report, not a generic assessment sequence.

| Report Block | Minimum Evidence Needed Before Writing | Authoring Rule |
| --- | --- | --- |
| Document Control set | Engagement metadata, accountable roles, version date | Create first and lock identifiers early |
| Executive Summary | Business context + confirmed recommendation themes | Write last draft near end; refresh after costs stabilise |
| Assessment: Hypervisors | Access statement from provider/client | Keep factual and concise |
| Assessment: VM tables | Validated VM inventory with role/OS/size | Preserve tabular format to match report readability |
| Assessment: Applications table | App list, stack, ports, blockers | Keep blocker counts and service types explicit |
| Assessment: Azure baseline | Tenant, license, subscription and resource exports | Separate subsections exactly as in 04 |
| Proposed Solution narrative | Approved target-state decisions | Justify choices using assessment evidence |
| Proposed Solution: App/DB dispositions | Modernise/rehost/retire decisions per workload | Keep split between modernisation and retained VM paths |
| Developer Experience | Delivery process findings and DevOps target model | Focus on execution capability, not tooling marketing |
| Resources tables | Service catalog + regional design + assumptions | Group by Network/Compute/Storage towers |
| Cloud Adoption Plan | Strategy/readiness outputs and sequencing themes | Keep this as delivery plan, not technical inventory |
| Cost Projection | Consolidated estimate with assumptions | Explicitly state variance and reservation caveats |

## Section-by-Section Report Construction
### Executive Summary
Use the engagement objectives, business drivers, and final recommendation themes from the completed report body. Draft this after Assessment, Proposed Solution, Resources, and Cost sections are stable.

### Assessment
Summarise the current estate in the same order as 04: Hypervisors, Virtual Machines, Applications, Azure (Tenant, Licensing, Subscriptions, Resources).

### Proposed Solution
Describe target-state hosting patterns, application modernisation themes, data platform decisions, and engineering changes using the exact subsection order in 04.

### Resources
Translate the target-state design into Network, Compute, and Storage towers with indicative service rows and regional resilience assumptions.

### Cloud Adoption Plan
Show how the organisation should move from readiness assessment to structured delivery.

### Estimated Monthly Cost Projection
Provide a directional commercial view with explicit caveats, assumptions, and reservation strategy context.

## Quality Checks
Before finalising the report, confirm that:

- Every recommendation can be traced to evidence
- Every major workload has a clear disposition path
- Every costed service has an explanation in the solution narrative
- Naming is sanitised where the framework is intended to be reusable
- Assumptions, exclusions, and uncertainties are easy to identify

## Final Deliverable Set
At completion, the engagement should leave behind:

- A reusable methodology document
- A practical execution guide
- A readiness assessment guide
- A sample report that shows the expected final output structure and level of detail

## Workshop Plan
Use workshops to validate assumptions quickly and avoid report rework.

| Workshop | Participants | Purpose | Output |
| --- | --- | --- | --- |
| Kickoff and Scope | Sponsor, IT lead, delivery team | Confirm objectives, scope, constraints | Signed scope and timeline |
| Infrastructure Discovery | Infrastructure, operations, architect | Validate estate inventory and dependencies | Baseline infrastructure model |
| Application and Data Discovery | App owners, DB owner, architect | Validate app mapping and data dependencies | Workload shortlisting and criticality view |
| Security and Identity Review | Security lead, identity owner | Validate policy posture and operational controls | Security and identity findings pack |
| Target-State Playback | Sponsor, platform and app leads | Review proposed architecture and migration paths | Agreed target-state direction |
| Final Readout | Sponsor, decision stakeholders | Confirm findings, risks, and next actions | Signed report and actions list |

## Evidence Register Template
Maintain this table throughout execution to preserve traceability.

| Evidence ID | Evidence Type | Source | Date Collected | Confidence | Used In Report Section |
| --- | --- | --- | --- | --- | --- |
| EV-001 | Infrastructure inventory export | Hosted platform export | YYYY-MM-DD | High | Assessment |
| EV-002 | Application migration assessment | Web app migration report | YYYY-MM-DD | Medium | Assessment, Proposed Solution |
| EV-003 | Security baseline output | Collaboration/security baseline tool | YYYY-MM-DD | High | Assessment, Risks |
| EV-004 | Strategy readiness output | Strategy/readiness evaluator | YYYY-MM-DD | Medium | Cloud Adoption Plan |
| EV-005 | Cost model workbook | Pricing model workbook | YYYY-MM-DD | Medium | Estimated Monthly Cost Projection |

## Execution Acceptance Criteria
The guide is complete only when these checks pass.

| Check | Pass Condition |
| --- | --- |
| Coverage | All in-scope domains represented in the report |
| Traceability | Every major recommendation linked to evidence |
| Consistency | Costs and architecture narrative do not conflict |
| Generic Readiness | No customer-specific identifiers remain in reusable outputs |
| Playback Readiness | Risks, assumptions, and decisions are explicit and reviewable |