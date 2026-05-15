# Azure Migration Review — Readiness Assessment Guide

**Purpose:** Define how evidence is assessed, how judgement is applied, and how findings are translated into the final report structure.

## How to Use This Guide
This guide is used after discovery evidence has been collected. It helps the assessor turn raw estate information into structured findings, workload decisions, and report-ready narrative.

It should be used to answer three questions:

1. What does the evidence say about current readiness?
2. What migration path or target-state decision does that support?
3. Where should that conclusion appear in the final report?

This guide should be applied against the fixed section structure in [04_Sample_Report.md](Azure Migration Review/04_Sample_Report.md). If a finding cannot be placed into a specific 04 section/subsection, either evidence is missing or the finding is out of scope.

## Report-First Assessment Sequence
Use this sequence to keep assessment outputs aligned to how the report is actually authored:

1. Populate Assessment facts first (no target-state recommendations).
2. Classify workload dispositions for applications and databases.
3. Produce Proposed Solution narrative from those dispositions.
4. Convert target-state decisions into Resources towers (Network/Compute/Storage).
5. Build Cloud Adoption Plan actions from operating model and strategy evidence.
6. Finalise Cost Projection from the agreed resource model.
7. Finalise Executive Summary from the completed report body.

## Assessment Domains
### 1. Infrastructure and Hosting
Assess:

- Current hosting model and estate composition
- OS supportability and platform suitability
- VM sizing, performance profile, and resilience expectations
- Backup, DR, and replication needs

Feeds report sections:

- Assessment
- Resources > Compute
- Resources > Storage

### 2. Applications and Interfaces
Assess:

- Application type and user access pattern
- Technology stack and supportability
- Integration dependencies
- Modernisation suitability
- Decommissioning candidates

Feeds report sections:

- Assessment > Applications
- Proposed Solution > Applications

### 3. Data Platforms
Assess:

- Database technology and support model
- Latency sensitivity
- Refactor or managed-service suitability
- Retention of IaaS-hosted data platforms where needed

Feeds report sections:

- Assessment
- Proposed Solution > Database
- Resources > Compute and Storage

### 4. Azure Platform Baseline
Assess:

- Tenant posture
- Subscription model
- Existing platform resources
- Monitoring and operational services
- Landing zone maturity and gaps

Feeds report sections:

- Assessment > Azure
- Proposed Solution
- Resources > Network / Compute / Storage

### 5. Operating Model and Delivery Capability
Assess:

- DevOps maturity
- Release governance
- Change control and deployment repeatability
- Engineering toolchain fit
- Operational ownership and support readiness

Feeds report sections:

- Proposed Solution > Developer Experience
- Cloud Adoption Plan

### 6. Business and Adoption Readiness
Assess:

- Business drivers and critical outcomes
- Risk tolerance and sequencing pressure
- Transformation ambition versus delivery maturity
- Cost expectations and optimisation appetite

Feeds report sections:

- Executive Summary
- Cloud Adoption Plan
- Estimated Monthly Cost Projection

## Evidence-to-Judgement Model
Each assessment area should be judged using the following lenses:

- Completeness: do we have enough information to make a reliable recommendation?
- Supportability: can the current workload or service be supported safely during migration?
- Suitability: is the workload a good fit for Azure IaaS, PaaS, or refactoring?
- Criticality: what is the impact if migration goes wrong or is delayed?
- Complexity: what engineering effort or dependency management is implied?
- Value: what strategic or operational benefit is gained by changing the current model?

## Suggested Rating Language
Use qualitative language instead of artificial precision where evidence is incomplete. Recommended terms are:

- Ready: no major blockers identified; the workload can move with standard delivery controls
- Ready with Conditions: migration is feasible, but prerequisites or remediation items must be completed first
- Modernise Before Migration: current hosting is possible, but target value depends on redesign or service substitution
- Retain Temporarily: migration is not the immediate best decision due to dependency, support, or business timing constraints
- Retire: the service should be removed from future-state planning

## Tool-to-Domain Mapping
| Domain | Typical Inputs or Tools | Primary Use |
| --- | --- | --- |
| Infrastructure discovery | Azure Migrate, server inventories, diagrams | Build inventory and workload context |
| Azure baseline review | Azure portal review, subscription exports, resource lists | Understand existing cloud posture |
| Business and strategy framing | Microsoft SMART, CASE outputs, stakeholder interviews | Link migration decisions to business outcomes |
| Security and collaboration posture | ScubaGear, M365 reviews, identity observations | Inform operational and security considerations |
| Cost modelling | Pricing estimates, current estate sizing, resilience assumptions | Build indicative monthly cost view |

## Report Authoring Rules
### Executive Summary
Only include the most important conclusions:

- Why the migration matters
- What the assessment found
- What target-state direction is recommended

### Assessment Section
Describe the current state factually. Avoid recommendations until enough evidence has been presented.

Required subsection order to match 04:

1. Hypervisors
2. Virtual Machines (Core Estate, Citrix Estate)
3. Applications
4. Azure (Tenant, Tenant Licensing, Subscriptions, Resources)

### Proposed Solution Section
Explain why the target-state choices are appropriate. This is where the assessor should justify App Service, managed databases, Azure Virtual Desktop, landing zone components, or retained IaaS patterns.

Required subsection order to match 04:

1. Modernisation
2. Modern Application Presentation
3. Applications (targeted for modernisation and marked for decommissioning)
4. Database (targeted for modernisation and remaining on virtual machines)
5. Developer Experience

### Resources Section
Use grouped service towers rather than isolated line items. The reader should understand what each platform service is for and why it is needed.

Required subsection order to match 04:

1. Network
2. Compute
3. Storage

### Cloud Adoption Plan Section
Focus on organisational change, governance, sequencing, and execution readiness rather than technical inventory.

### Cost Projection Section
Be explicit that pricing is indicative and depends on reservation strategy, usage assumptions, final sizing, and delivery choices.

## Section-Level Judgement Prompts (Aligned to 04)
Use these prompts when deciding whether a finding is ready to write into the report.

| 04 Section | Judgement Prompt |
| --- | --- |
| Assessment > Hypervisors | Do we have enough access evidence to make a factual statement on host platform visibility? |
| Assessment > Virtual Machines | Are role, sizing, OS, and business purpose validated for each listed VM group? |
| Assessment > Applications | Are tech stack, exposure, blockers, and migration implications clear per application? |
| Assessment > Azure baseline | Is tenant/subscription/resource posture accurate and sufficient for platform recommendations? |
| Proposed Solution > App presentation | Is Front Door/APIM/App Service guidance justified by access, scale, and security needs? |
| Proposed Solution > Applications | Is each app's modernise/retain/retire path justified by evidence and dependencies? |
| Proposed Solution > Database | Is managed DB vs IaaS DB decision supported by latency, compatibility, and ops constraints? |
| Proposed Solution > Developer Experience | Are delivery model changes tied to observed current-state gaps? |
| Resources > Network/Compute/Storage | Does each costed service line map to a stated target-state capability? |
| Cloud Adoption Plan | Are strategy, sequencing, and ownership actions specific and executable? |
| Estimated Monthly Cost Projection | Are assumptions, reservation strategy, and uncertainty ranges explicit? |

## Common Assessment Pitfalls
Avoid the following:

- Treating all workloads as lift-and-shift candidates
- Separating technical recommendations from business drivers
- Ignoring operational ownership and support maturity
- Producing costs without documenting assumptions
- Presenting a target architecture without connecting it to discovered evidence

## Minimum Output Standard
Before the report is considered complete, it should contain:

- A clear view of the current estate
- A defined target-state narrative
- Workload-level migration logic
- Platform service recommendations
- Delivery and operating model implications
- Indicative commercial framing

## Evidence-to-Report Traceability Matrix
Use this matrix to prove how source artifacts become report content.

| Evidence Family | Typical Artifact Type | Assessment Use | Report Destination |
| --- | --- | --- | --- |
| Infrastructure inventory | Server inventories, platform exports, hosting sheets | Build current-state compute and dependency baseline | Assessment > Virtual Machines; Resources > Compute |
| Application assessments | Per-application migration reports, app inventory sheets | Determine modernization blockers and migration paths | Assessment > Applications; Proposed Solution > Applications |
| Collaboration and security posture | Security baseline output, policy findings, action plans | Identify identity and operational control risks | Assessment > Azure; Risks and Recommendations |
| Tenant and subscription data | Tenant snapshots, subscription/resource listings | Validate current cloud footprint and governance context | Assessment > Azure; Proposed Solution |
| Strategy and readiness outputs | Strategy evaluator and readiness scoring exports | Align technology plan with business outcomes and capability gaps | Executive Summary; Cloud Adoption Plan |
| Cost models | Pricing workbooks and scenario sheets | Build indicative monthly cost and assumptions | Resources; Estimated Monthly Cost Projection |
| Architecture artifacts | HLD/LLD docs, diagrams, handover packs | Validate target-state design choices | Proposed Solution; Resources |

## Workload Disposition Scoring Aid
Apply a simple weighted view when classifying workloads.

| Criterion | Weight | Scoring Guidance |
| --- | --- | --- |
| Technical fit for Azure service model | 30% | High score when dependencies and runtime are cloud-suitable |
| Business criticality and tolerance | 20% | High score when controlled transition risk is acceptable |
| Modernisation value | 20% | High score when change yields measurable agility or cost value |
| Migration complexity | 20% | High score when dependencies are known and manageable |
| Operational readiness | 10% | High score when support and monitoring model is prepared |

Use the weighted outcome to support disposition recommendations (rehost, replatform, refactor, retain, retire).