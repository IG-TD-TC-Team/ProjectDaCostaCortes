# ProjectDaCostaCortes – Scribus BI Project

BI project (HES-SO Valais-Wallis) built on the weekly Mantis/Scribus bug-tracker snapshot.

| Folder | Content |
|--------|---------|
| `ETL/` | SSIS project `ETLScribus_DacostaCortes` – extract, transform, load into the warehouse |
| `Cube/` | SSAS project – cube / dimensions and reports (data visualisation) |
| `Documentation/` | Course brief (`BI_CC_Project.md` / `.pdf`) and project documentation |
| `DataSource/` | CSV snapshots of the Scribus bug tracker |

Open `ProjectDaCostaCortes.sln` for the cube project; open `ETL/ETLScribus_DacostaCortes/ETLScribus_DacostaCortes.dtproj` for the ETL.

## Team setup

1. Install Visual Studio with the **SQL Server Integration Services Projects** and **Analysis Services Projects** extensions (same versions for everyone).
2. Clone the repo anywhere, then copy `DataSource\scribus-dump-2026-01-09.csv` to `C:\BI\Data\`.
   The ETL reads the file from the project parameter `SourceFilePath` (default `C:\BI\Data\scribus-dump-2026-01-09.csv`).
   If you need another path, change it only locally and do not commit that change.
3. The SSIS project uses `ProtectionLevel = DontSaveSensitive`: no passwords are stored in the files. Use Windows authentication for SQL Server / SSAS, or re-enter credentials locally.
4. Deployment targets (SSAS server, etc.) live in `*.user` files, which are not versioned. Set your own in Visual Studio.

## Working together

- `.dtsx` and cube files are large XML files that merge badly: **don't edit the same package / cube file in parallel**. Split work by package or by ETL vs. cube.
- Work on short-lived branches, pull often, and merge through pull requests.
