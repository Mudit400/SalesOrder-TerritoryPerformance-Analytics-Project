<div align="center">

# 🏁 AdventureWorks — Sales Order & Territory Performance Analytics

### End-to-end Azure data engineering and Power BI analytics project

![Azure](https://img.shields.io/badge/Cloud-Microsoft%20Azure-0078D4?style=for-the-badge&logo=microsoftazure&logoColor=white)
![ADF](https://img.shields.io/badge/Orchestration-Azure%20Data%20Factory-0078D4?style=for-the-badge)
![Databricks](https://img.shields.io/badge/Transformation-Azure%20Databricks-EA3E2A?style=for-the-badge&logo=databricks&logoColor=white)
![ADLS](https://img.shields.io/badge/Storage-ADLS%20Gen2-00A4EF?style=for-the-badge)
![Synapse](https://img.shields.io/badge/Analytics-Azure%20Synapse-0078D4?style=for-the-badge)
![Power BI](https://img.shields.io/badge/Reporting-Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)

**An end-to-end data pipeline that ingests AdventureWorks sales data, processes it through a Bronze–Silver–Gold lakehouse-style flow, exposes curated data through Azure Synapse SQL, and presents sales and territory insights in Power BI.**

</div>

---

## 📌 Project Overview

This project demonstrates an Azure-based data engineering and business intelligence workflow using the AdventureWorks sales dataset sourced from Kaggle. The source CSV files are maintained in a GitHub repository and retrieved through raw GitHub HTTP endpoints.

Azure Data Factory orchestrates ingestion, Azure Data Lake Storage Gen2 stores the data, Azure Databricks performs Spark-based processing, Azure Synapse provides a SQL analytics/serving layer over Parquet data, and Power BI is used to explore sales order and territory performance.

### 🎯 Objectives

- Automate ingestion of multiple AdventureWorks CSV files from GitHub.
- Land source data in the Bronze layer of ADLS Gen2.
- Transform source data with Azure Databricks and write Parquet files to the Silver layer.
- Expose Silver-layer data through Azure Synapse SQL views and create an external Gold sales table.
- Build a Power BI report for sales order and territory performance.
- Demonstrate an end-to-end cloud data engineering architecture using Azure services.

---

## 🏗️ Architecture

![AdventureWorks project architecture](docs/images/architecture.jpeg)

### Data flow

```text
GitHub (raw CSV files)
        |
        v
Azure Data Factory
(HTTP source + parameterized/dynamic copy)
        |
        v
Azure Data Lake Storage Gen2
        |
        +--> Bronze: source CSV landing
        |
        v
Azure Databricks (PySpark)
        |
        +--> Silver: transformed Parquet datasets
        |
        v
Azure Synapse Analytics
(SQL views + external Parquet table)
        |
        v
Power BI
(Sales Order & Territory Performance report)
```

> **Architecture note:** The project files show Databricks writing transformed datasets to the Silver layer. The Synapse SQL scripts create views over Silver Parquet folders and an external `gold.extsales` table from the sales view. In this implementation, Synapse acts as the SQL analytics/serving layer; the scripts supplied do not show a separate complex Gold business-transformation pipeline.

---

## 🧰 Technology Stack

| Layer / Responsibility | Technology | How it is used |
|---|---|---|
| Source data | Kaggle / GitHub | AdventureWorks CSV dataset; GitHub raw URLs are used as the HTTP source |
| Orchestration | Azure Data Factory | Copy pipelines, HTTP linked service, parameterized datasets, Lookup and ForEach |
| Data lake | Azure Data Lake Storage Gen2 | Central storage with Bronze, Silver and Gold containers |
| Processing | Azure Databricks | PySpark-based loading, column derivations, type handling and Parquet writes |
| SQL analytics | Azure Synapse Analytics | External data sources, Parquet file format, SQL views and external table |
| Visualization | Power BI | Sales order and territory performance dashboard |
| Infrastructure definition | Bicep / ARM template files | Azure resource deployment definitions are included in the project |

---

## 🔄 Pipeline & Medallion Layers

### 1. Ingestion — Azure Data Factory

The repository contains two ADF pipeline definitions:

- **`GitToRaw`** — a Copy activity that reads a delimited-text source over HTTP and writes it to an ADLS Gen2 sink.
- **`DynamicGITtoRAW`** — uses a Lookup activity to read a JSON list of file parameters, then a ForEach activity to execute a parameterized Copy activity for each file.

The parameter JSON contains relative GitHub paths and destination folder/file names for the AdventureWorks source files. The HTTP linked service supplies the base endpoint, while the dataset uses the relative URL.

![Azure Data Factory pipeline](docs/images/adf-pipeline.jpeg)

### 2. Bronze — Raw landing

The Bronze container holds source CSV datasets, including:

- Calendar
- Customers
- Product categories and subcategories
- Products
- Returns
- Sales (2015, 2016 and 2017)
- Territories

The Bronze layer preserves the ingested source files for downstream processing.

![ADLS Gen2 containers](docs/images/adls-containers.jpeg)

### 3. Silver — Databricks transformations

The Databricks notebook uses PySpark to read the Bronze CSV datasets and write Parquet outputs to Silver.

Examples visible in the supplied notebook include:

- Deriving `Month` and `Year` from the calendar date.
- Creating a customer `FullName` field.
- Deriving product fields using string split operations.
- Converting `StockDate` to a timestamp.
- Replacing the `S` prefix in `OrderNumber` with `T`.
- Creating `Multiply` as `OrderLineItem * OrderQuantity`.
- Writing transformed datasets in Parquet format to Silver folders.

### 4. Gold / SQL serving — Azure Synapse Analytics

The supplied Synapse SQL scripts:

- Create a `gold` schema.
- Define an external data source for the Silver storage location using a managed identity credential.
- Define a Parquet external file format with Snappy compression.
- Create SQL views for calendar, customers, product subcategories, products, returns, sales and territories, reading Parquet files through `OPENROWSET`.
- Create the external table `gold.extsales` from the `gold.sales` view.

The included final sales dataset has these fields:

`OrderDate`, `StockDate`, `OrderNumber`, `ProductKey`, `CustomerKey`, `TerritoryKey`, `OrderLineItem`, `OrderQuantity`, `Multiply`.

---

## 📊 Power BI — Sales Order & Territory Performance

The included Power BI report screenshot shows a dark-themed sales and territory analytics page with KPI cards, sales/product visuals and a geographical map.

![Power BI sales and territory performance dashboard](docs/images/powerbi-dashboard.jpeg)

### Example analysis areas

- Sales order volume and order trends.
- Order quantity and product performance.
- Customer and territory distribution.
- Geographical distribution of sales territories.
- Comparative performance across territories.

The report is intended for exploratory analysis of the available fields. The supplied final sales table contains order and quantity fields; do not interpret `OrderQuantity` or `Multiply` as revenue or profit without a verified price/cost calculation.

---

## 🖼️ Azure Environment Screenshots

### Azure resources

![Azure resources](docs/images/azure-resources.jpeg)

### Resource group

![Azure resource group](docs/images/resource-group.png)

---

## 📁 Repository Structure

The uploaded project archive contains the following main areas (some folders contain additional ADF JSON definitions and supporting files):

```text
SalesOrder & TerritoryPerformance Analytics Project/
│
├── AzureDataFactory/
│   ├── Datasets/
│   └── Pipelines/
│
├── Azure Synapse/
│   ├── Create External Table.sql
│   ├── Create Scheme.sql
│   ├── Create Views Gold.sql
│   └── FinalGoldData.sql
│
├── Containers/
│   ├── Bronze/
│   ├── Silver/
│   ├── Gold/
│   └── ParametersForIteration/
│
├── DataBricks/
│   ├── databricks_silver_layer.ipynb
│   ├── silver_layer.ipynb
│   └── silver_layer.py
│
├── ProjectSnapshots/
│
├── main.bicep
├── parameters.json
├── FinalGoldData.csv
└── SalesOrder & TerritoryPerformance Analytics.pbit
```

---

## 🚀 How to Explore the Project

1. Clone or download this repository.
2. Review the ADF linked services, datasets, pipeline JSON files and iteration parameter JSON.
3. In Azure Data Factory, configure the HTTP and ADLS Gen2 linked services for your own environment, then publish and run the ingestion pipeline.
4. Confirm that the source CSV files land in the Bronze container.
5. Open the Databricks notebook, configure secure access to your own ADLS account, and run the Silver transformation steps.
6. Confirm that the transformed Parquet datasets are written to the Silver container.
7. In Azure Synapse, configure the required identity permissions and external data access, then execute the schema, external data source, file format, view and external-table scripts in the appropriate order.
8. Connect Power BI to the curated SQL endpoint/table or use the included Power BI template, then configure credentials and refresh the model.

> Resource names, storage paths, identities and deployment settings in the project are environment-specific. Replace them with your own Azure resource values before running the solution.

---

## 🔐 Security & Before You Publish

**Important: the project archive supplied for documentation contains credential-like values embedded in Databricks code and a Synapse SQL script, and an Azure application screenshot that may expose a client secret. Do not commit those files or screenshots to a public repository in their current form.**

Before publishing the full project:

1. **Immediately rotate/revoke the exposed application client secret** in Microsoft Entra ID and create a replacement.
2. Replace hard-coded secrets in notebooks and scripts with Azure Key Vault, Databricks secret scopes, or an appropriate managed identity approach.
3. Replace the hard-coded Synapse master-key password with a new secret managed securely.
4. Remove credentials, tokens, connection strings, subscription-specific identifiers and sensitive screenshots from the repository.
5. If any secret was already committed, rotate it first and clean it from Git history; deleting it in a later commit does not remove it from earlier commits.
6. Keep a sanitized example configuration (for example, `.env.example`) with placeholder values only.

The `ApplicationForAccess.jpeg` screenshot is deliberately not included in this README image bundle.

---

## ⚠️ Notes & Limitations

- Azure resource names and locations in the screenshots reflect the project environment at the time the screenshots were captured.
- Azure costs, permissions, networking, identity configuration and service availability depend on the subscription and region.
- The README documents the files and screenshots supplied with the project; it does not claim that the deployed Azure resources are currently running.
- The Power BI screenshot is a captured report view, not an interactive report embedded in GitHub.
- The supplied Synapse scripts expose Silver data through SQL views and create an external sales table. A separate Gold transformation process should only be documented once it is implemented and verified.

---

## 👤 Author

**Mudit400**

AdventureWorks Sales Order & Territory Performance Analytics  
*Azure Data Engineering • Medallion Architecture • Business Intelligence*

---

<div align="center">

**Built with Microsoft Azure, PySpark and Power BI** ☁️

</div>
