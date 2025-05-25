# Krotos Assessment – Michael Papamikroulis

This repository contains my full submission for the Business Intelligence Analyst case study for **Krotos**. The objective was to analyze customer behavior and acquisition channel effectiveness using RFM segmentation and Power BI dashboards.

## Project Overview

The case study was divided into three main tasks:

1. **Database Setup**  
   - Structured and imported `Transactions.csv` and `Users.csv` into a PostgreSQL database  
   - Created appropriate schemas and documented field-level decisions based on the provided Excel file

2. **Analysis (RFM Segmentation)**  
   - Used SQL to calculate Recency, Frequency, and Monetary metrics per customer  
   - Scored each customer on a scale of 1–5 for each metric and assigned behavioral segments (e.g., Top, Loyal, Fading)  
   - Exported the final RFM segmentation results for visualization

3. **Visualization (Power BI)**  
   - Developed two interactive dashboards:
     - **Customer Segments Dashboard**: Shows segment distribution, performance metrics, and KPIs  
     - **Acquisition Channel Effectiveness**: Highlights how different channels perform in terms of customer volume and quality  
   - Included slicers and filtering capabilities as required

## Folder Contents

| File Name                                           | Description                                                                 |
|-----------------------------------------------------|-----------------------------------------------------------------------------|
| `Michael Papamikroulis Krotos Assessment.pdf`       | Final report with methodology, findings, and recommendations               |
| `Michael Papamikroulis Krotos Assessment.pbix`      | Power BI file with both dashboards                                         |
| `krotos_rfm_analysis.sql`                           | Full SQL script: schema creation, RFM calculation, and segmentation logic  |
| `Transactions.csv`                                  | Transactional data used for monetary, frequency, and recency calculations  |
| `Users.csv`                                         | User metadata including acquisition channel                                |
| `rfm_segmentation_output.csv`                       | Exported RFM dataset used for Power BI visualization                       |
| `Krotos _ RFM & Cohorts Analysis.xlsx`              | Original Excel source file with comments and two data sheets               |

## Tools Used

- **PostgreSQL** for data processing and metric calculation  
- **Power BI** for interactive dashboard development and visualization  
- **GitHub** for code and document delivery  

## Author

**Michael Papamikroulis**  
Senior Environmental Consultant transitioning into Analytics & Business Intelligence
