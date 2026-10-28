# Azure setup

This project runs on the Azure free credit, which ends in early November 2026. After that the resources are switched off, so I keep screenshots and short notes here.

## Day 1 (28 October 2026)

### Resource group
![Resource group](01_resource_group.png)

A separate resource group, `rg-bank-risk`, in Norway East. I keep each project in its own resource group, so resources and costs don't mix with my other project.

### Storage account
![Storage account](02_storage_account.png)

Storage account `stbankriskfm`. Hierarchical namespace is enabled, which makes it Azure Data Lake Storage Gen2 with real folders. Anonymous access is off, soft delete keeps deleted files for 7 days, and it uses locally redundant storage (LRS), the cheapest option.

My first try had hierarchical namespace switched off. I caught it on the review page and turned it on before creating the account.

### Raw container
![Raw container](03_raw_container.png)

The `raw` container with the three CSV files from the notebook: customers, loans and transactions (about 40 MiB).
