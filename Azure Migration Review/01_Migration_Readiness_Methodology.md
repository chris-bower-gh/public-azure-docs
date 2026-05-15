# Azure Migration Review — Migration Readiness Methodology

**Purpose:** Define the engagement model, assessment approach, evidence domains, and decision-making framework used to produce the sample migration assessment report.

## Engagement Objective
This engagement is designed to give a client a structured, evidence-based view of migration readiness before any major Azure transition begins. The methodology is intended to answer five practical questions:

1. What exists today across infrastructure, applications, identities, data, and cloud tenancy?
2. Which workloads are suitable for rehost, replatform, refactor, retain, or retire decisions?
3. Which landing zone, networking, security, and operational capabilities are required to support the target state?
4. What delivery, governance, and engineering changes are needed for a successful migration?
5. What exact report structure should be produced to communicate findings, target architecture, and indicative cost?

## Engagement Scope
The methodology assumes a discovery-led migration assessment covering:

- On-premises or hosted compute estates
- Virtual desktop environments and user access platforms
- Business applications and integration services
- Data platforms, file services, and recovery dependencies
- Existing Azure tenant, subscriptions, and deployed resources
- Platform engineering, DevOps, and governance readiness
- Indicative target-state architecture and cost modelling

## Assessment Principles
The engagement follows these principles throughout:

- Evidence before recommendation: recommendations are based on discovered estate facts, not assumed best practice alone.
- Business alignment: platform decisions are tied back to business outcomes, delivery velocity, resilience, and risk reduction.
- Service-based thinking: the assessment looks beyond servers and focuses on what each workload does, who depends on it, and how it should evolve.
- Modernisation where justified: not every workload should be lifted and shifted; the methodology explicitly tests for modernisation opportunities.
- Governance by design: identity, security, resilience, cost control, and operational ownership are assessed as first-class concerns.
- Report traceability: every major section in the final report should map back to a specific evidence stream in the engagement.

## Assessment Phases
### Phase 1: Mobilisation and Scope Definition
The engagement starts by confirming objectives, stakeholders, assumptions, and evidence sources. This phase establishes what the client wants to achieve and what the assessment must cover.

Outputs:

- Confirmed assessment objectives
- Stakeholder map and interview plan
- Evidence request list
- Working assumptions and exclusions

### Phase 2: Discovery and Inventory
The current estate is inventoried across servers, applications, data stores, tenant configuration, subscriptions, licensing, and operational tooling. Where direct tooling is unavailable, structured interviews and supplied exports are used.

Outputs:

- Infrastructure inventory
- Application and dependency inventory
- Tenant and subscription inventory
- Initial workload categorisation

### Phase 3: Readiness Assessment
Discovered assets are evaluated against technical, operational, security, resilience, and business criteria. The goal is to determine whether each service is ready for migration and what form that migration should take.

Outputs:

- Workload readiness findings
- Risks, constraints, and blockers
- Current-state capability observations
- Modernisation candidates and retention candidates

### Phase 4: Target-State Definition
The assessment translates findings into a target platform view covering networking, compute, storage, application hosting, data platforms, resilience, and engineering practices.

Outputs:

- Target service mapping
- Indicative target architecture narrative
- Platform capability recommendations
- Delivery and operating model recommendations

### Phase 5: Commercial and Delivery Framing
The engagement concludes by packaging the findings into a client-facing report with indicative costs, delivery priorities, and a cloud adoption planning view.

Outputs:

- Sample report structure
- Indicative cost model
- Delivery sequencing considerations
- Cloud adoption plan summary

## Assessment Dimensions
### Technical Readiness
Technical readiness focuses on the estate’s ability to move or transform without introducing unacceptable compatibility, performance, or architectural risk.

Assessed topics:

- Operating systems and platform supportability
- Application hosting patterns and dependencies
- Data platform suitability for PaaS services
- Network connectivity and segmentation requirements
- Backup, disaster recovery, and replication needs
- Azure-native service fit

### Operational Readiness
Operational readiness measures whether the organisation can run, support, govern, and change the target platform once migration begins.

Assessed topics:

- Monitoring and support model maturity
- Service ownership and platform responsibilities
- Release management and deployment practices
- Identity, access, and operational control patterns
- Backup, recovery, and incident response capabilities

### Business and Strategic Readiness
Business readiness ensures that the migration is justified, prioritised, and sequenced in a way that supports broader organisational outcomes.

Assessed topics:

- Business drivers and expected outcomes
- Criticality of systems and user impact
- Risk appetite and acceptable transition constraints
- Cost visibility and optimisation opportunities
- Sequencing priorities for transformation

## Evidence Sources
The methodology allows for multiple evidence types depending on access level:

- Interviews with technical and business stakeholders
- Asset inventories and spreadsheet exports
- Azure tenant and subscription reviews
- Licensing summaries and service usage data
- Architecture diagrams and design artefacts
- Existing migration or assessment outputs
- Tooling outputs such as Azure Migrate, security posture tools, and readiness evaluators

## Tooling and Assessment Aids
Typical tools and accelerators used during the engagement include:

- Azure Migrate for inventory, dependency awareness, and sizing support
- Microsoft SMART for strategic migration and transformation context
- Cloud Adoption Strategy Evaluator for readiness and adoption framing
- ScubaGear where Microsoft 365 security and configuration posture is relevant to the wider engagement
- Azure pricing calculators or equivalent commercial modelling inputs for indicative cost projections

## Decision Framework
Each workload should be classified into one of the following outcome paths:

- Rehost: move largely as-is into Azure IaaS
- Replatform: move to managed Azure services with limited redesign
- Refactor: redesign for cloud-native delivery or modern application architecture
- Retain: keep in current state temporarily because migration is not yet justified
- Retire: remove from scope because the service is obsolete or duplicated

These decisions are supported by technical constraints, dependency mapping, business value, and operational fit.

## Reverse-Aligned Report Blueprint
This methodology is intentionally run backwards from the report output. The target document shape in [04_Sample_Report.md](Azure Migration Review/04_Sample_Report.md) is fixed first, then discovery and assessment are executed to populate each section with traceable evidence.

| Final Report Section (04) | What Must Be Produced During Assessment | Primary Evidence Streams |
| --- | --- | --- |
| Document Control / Revision History / Review | Engagement metadata, owner names/roles, version/date trail | Kickoff notes, document control log |
| Executive Summary | Business drivers, transformation intent, summary recommendation | Sponsor interviews, strategic readiness outputs |
| Assessment > Hypervisors | Hosting access constraints and current-state statement | Provider interviews, access constraints log |
| Assessment > Virtual Machines (Core/Citrix) | VM inventory with role, OS, sizing and service purpose | Infra inventories, sizing sheets, workshop validation |
| Assessment > Applications | App portfolio table with stack, ports, blockers | App assessment exports, app-owner interviews |
| Assessment > Azure (Tenant/Licensing/Subscriptions/Resources) | Tenant baseline and existing cloud footprint | Tenant snapshots, license exports, subscription/resource listings |
| Proposed Solution > Modernisation / Application Presentation | Target app presentation pattern and API/security front door model | Architecture review, platform design workshops |
| Proposed Solution > Applications | Modernise vs decommission decisions and target platform per app | Disposition analysis, dependency mapping |
| Proposed Solution > Database | DB platform decisions (managed services vs retained IaaS) | DB interviews, latency/compatibility constraints |
| Proposed Solution > Developer Experience | DevOps operating model changes and delivery controls | Engineering workshops, delivery process review |
| Resources > Network | Network services and resilience pattern | Landing zone/network design inputs, security requirements |
| Resources > Compute | VM/App Service/DB compute shape and regional placement | Workload mapping, performance and HA requirements |
| Resources > Storage | File, backup, replication and recovery service plan | DR/backup policies, storage consumption assumptions |
| Cloud Adoption Plan | Strategy, roles, sequencing and readiness actions | CASE/strategy outputs, operating model findings |
| Estimated Monthly Cost Projection | Consolidated monthly estimate with assumptions and caveats | Pricing model workbook, reservation assumptions |

## Report Build Order (Backwards Working Method)
To keep the framework aligned with the sample report, the team should produce content in this order:

1. Lock the final section/subsection skeleton from [04_Sample_Report.md](Azure Migration Review/04_Sample_Report.md).
2. Populate Assessment (current state only, no target recommendations yet).
3. Populate Proposed Solution from disposition and target-state decisions.
4. Populate Resources from the solution design and resilience model.
5. Populate Cloud Adoption Plan from strategy and delivery readiness evidence.
6. Finalise the Executive Summary after all major findings and costs are stable.
7. Finalise the Estimated Monthly Cost Projection from the agreed resource model.

## Deliverables
The standard output set for this framework is:

1. Methodology explaining how the assessment is run
2. Execution guide describing how evidence is collected and synthesised
3. Assessment guide mapping evidence to scoring, judgement, and report sections
4. Sample report showing what the final client-facing deliverable looks like

## Standard Engagement Cadence
The methodology is designed to run as a short, structured engagement with explicit checkpoints. A typical timeline is two to four weeks, depending on access to evidence and stakeholder availability.

| Stage | Typical Duration | Primary Activities | Key Outputs |
| --- | --- | --- | --- |
| Mobilise | 2-3 days | Scope confirmation, stakeholder alignment, evidence request | Confirmed scope and delivery plan |
| Discover | 4-7 days | Current-state data gathering, interviews, tooling exports | Evidence register and inventory baseline |
| Assess | 3-5 days | Workload analysis, readiness classification, risk review | Findings, disposition recommendations |
| Design | 3-5 days | Target-state definition, platform and operating model shaping | Proposed solution and delivery approach |
| Report | 2-3 days | Report assembly, QA, stakeholder playback | Final sample report and next-step plan |

## Roles and Responsibilities
This framework uses generic role definitions so it can be reused across engagements.

| Role | Responsibility |
| --- | --- |
| Engagement Lead | Owns scope, timeline, and stakeholder governance |
| Cloud Architect | Leads target-state platform and migration-path decisions |
| Infrastructure Analyst | Owns server and hosting discovery and readiness assessment |
| Application Analyst | Owns application portfolio analysis and disposition logic |
| Security and Identity Analyst | Reviews identity, policy, and collaboration posture evidence |
| Commercial Analyst | Builds indicative cost model and assumptions log |
| Client Sponsor | Confirms objectives, priorities, and decision alignment |

## Quality Gates
The methodology includes stage gates to prevent low-confidence recommendations.

| Gate | Entry Criteria | Exit Criteria |
| --- | --- | --- |
| Gate 1: Scope Locked | Objectives and in-scope domains defined | Signed scope and evidence request issued |
| Gate 2: Discovery Complete | Core evidence sources collected | Inventory baseline and evidence gaps logged |
| Gate 3: Assessment Complete | Workload and domain analysis complete | Findings and disposition logic peer reviewed |
| Gate 4: Design Complete | Target-state proposals drafted | Solution narrative and assumptions validated |
| Gate 5: Report Ready | Report assembled from approved inputs | QA complete and playback ready |