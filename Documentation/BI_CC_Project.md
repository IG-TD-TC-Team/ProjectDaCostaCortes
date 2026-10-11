# BI Project (CC) – HES-SO Valais-Wallis

> Markdown version of `BI_CC_Project.pdf` (24 slides).

## Table of Contents
1. [Course Agenda](#1-course-agenda)
2. [Project Setting](#2-project-setting)
3. [Data Source](#3-data-source)
4. [Group Work](#4-group-work)
5. [Project Timeline](#5-project-timeline)
6. [BI Project Management Stages](#6-bi-project-management-stages)
7. [BI Architecture Elements](#7-bi-architecture-elements)

---

## 1. Course Agenda

| Date | Subject |
|------|---------|
| 17 Sept | Introduction to BI / Data Warehousing & Data Modelling |
| 24 Sept | Data Modelling (Practice) |
| 01 Oct | ETL |
| 08 Oct | Cube OLAP & Analysis |
| 15 Oct | Finland week / No course |
| 22 Oct | BI Project |
| 29 Oct | IA & BI / BI Project |
| 05 Nov | Data Analysis / BI project |
| 12 Nov | BI project |
| 19 Nov | BI project / Data Analytics (Schumacher) |
| 26 Nov | Data Analytics (Schumacher) |
| 03 Dec | Data Analytics (Schumacher) |
| 10 Dec | Data Analytics (Schumacher) |
| 17 Dec | Data Analytics (Schumacher) |
| 24 Dec | Data Analytics (Schumacher) |

## 2. Project Setting

The project is based on a real-world bug tracking system:

- **Mantis** – a widely used bug tracker: <http://www.mantisbt.org/>
- **Scribus** – open-source page layout program: <http://www.scribus.net/canvas/Scribus>
- **Scribus uses Mantis** for its bugs: <http://bugs.scribus.net/my_view_page.php>

## 3. Data Source

- Go to <http://teachingse.hevs.ch/csvFiles/>
- It contains a **snapshot of the status of the bug tracking system**.
- ⚠️ Web access is only possible **inside the HES-SO network**.
- 🔄 **A new file is uploaded every Monday at 6 am.**

## 4. Group Work

- A group consists of **2 people**.
- The project counts for **60% of the CC** (= **50% of the module**).
- You can use async time and lecture time.

## 5. Project Timeline

| # | Task | Deadline |
|---|------|----------|
| 1 | Get an overview of the data | 22.10 |
| 2 | Define which questions you want to answer | 22.10 |
| 3 | Create a database schema for the warehouse (keep in mind the data must be updatable!) | 29.10 |
| 4 | Create the data warehouse | 29.10 |
| 5 | Apply the ETL process | 05.11 |
| 6 | Provide means for updating the warehouse based on new snapshots | 12.11 |
| 7 | Automate the update process | 19.11 |
| 8 | Create a cube / reports answering your questions | 19.11 |
| 9 | Provide documentation about your project (along with the project) | 19.11 |

> **There is no presentation.**

## 6. BI Project Management Stages

Development principles: **iterative development**, **user integration**, **data testing and validation**.

The stages form a cycle:

```
Requirements gathering → Analysis of source data → Modelling → ETL
      → Semantic layer / Reporting → Testing & Training
      → Administration / Security / Audit → Production
      (→ back to Requirements gathering)
```

| Stage | Activities |
|-------|-----------|
| **Requirements gathering** | Select key users (business and IT); identify requirements (interviews with the business); identify data (interviews with IT) |
| **Source data analysis** | Data quality; available history; management rules; fields to be archived |
| **Modelling** | Define fact tables based on granularity; create dimensions (denormalisation) |
| **ETL** (Extract, Transform, Load) | Data retrieval (full / delta); processing; loading into target tables; load frequency; mapping document |
| **Semantic layer** | SQL code generator that masks the technical aspects of the database (e.g. Universe & DataSet) |
| **Reporting** | Report creation; document template creation |
| **Tests** | With business and IT key users |
| **Training** | Reporting for end users; administration for IT |
| **Administration** | User and group creation; authentication mapping; data security |
| **Audit** | BI server activity; BI server content (repository) |
| **Production launch** | Delivery; documentation; load automation; report automation |

## 7. BI Architecture Elements

```
Source systems → Data Preparation Area → Data Warehouse Presentation Server → Feedback portal
                 (ODS + DSA)             (Data marts, OLAP)                   (queries, reports, apps)
```

### 7.1 Source systems
"Operational recording system, whose function is to capture transactions related to the activity."

- Priority = **uptime**
- Few queries
- Little history
- Little effort required to standardise basic dimensions
- Operational keys that ensure the uniqueness of certain elements

### 7.2 Data Preparation Area
"All processes that clean, transform, combine, archive, and remove duplicates, i.e., prepare source data for integration and subsequent use within the data warehouse." **No user access.**

| Component | Description |
|-----------|-------------|
| **ODS** – Operational Data Store | Storage (flat files, RDBMS, other); identical storage of operational data; consolidation of different sources; common basis for calculations |
| **DSA** – Data Staging Area | Working area; cleaning, transformation, duplicate removal, standardisation, archiving; addition of calculated fields; temporary tables; export of data marts |

### 7.3 Data Warehouse Presentation Server
"Target machine on which the DWH is stored and organised to respond directly to queries issued by users, report generators and other applications."

- **Data mart** = subset of a DWH according to a business process (a feasible project unit). It is:
  - subject-oriented
  - implemented locally
  - dedicated to a group of users
  - refreshed regularly
  - built on shared dimensions
- **Dimensional model**: dimensions + fact table
- **OLAP query services**:
  - **ROLAP** = relational database
  - **MOLAP** = cube (proprietary database)

### 7.4 Feedback (Reporting) Portal

| Tool | Purpose |
|------|---------|
| **Ad hoc query tools** | Invite users to formulate their own queries by directly manipulating relational tables and their joins |
| **Report generators** | Predefined reports, distributed automatically (scheduling / broadcasting) or viewed on demand |
| **User applications** | "Set of tools that query, analyse and present information to meet a specific need" – data access tools, spreadsheets, graphics software |
| **Modelling applications** | Forecasting, data mining, budgets, … |
