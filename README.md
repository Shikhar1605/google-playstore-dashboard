
# 📊 Google Play Store Data Analysis Dashboard

## 🧩 Overview
This project analyzes Android apps listed on the Google Play Store to uncover trends related to installs, ratings, revenue potential, pricing strategy, and user engagement.
It combines **Python (for preprocessing)** and **Tableau (for visualization)** to deliver actionable insights in an interactive dashboard.

## 🧠 Objectives
- Understand **app distribution** across categories.
- Compare **Free vs Paid apps** performance.
- Analyze **user ratings**, **reviews**, and **install trends**.
- Estimate **revenue potential** based on installs and pricing.
- Identify top-performing categories and apps.

## ⚙️ Data Preprocessing (Python)
Data cleaning and transformation were performed in **Google Colab** using Python.
Key steps included:
- Handling missing values.
- Cleaning `Installs`, `Size`, and `Price` columns.
- Creating derived columns such as:
  - `Installs_Clean`
  - `Revenue_Potential`
  - `Rating_Category` (High, Medium, Low).
- Removing duplicates and formatting data for Tableau.

## 📈 Tableau Dashboard Structure

### Sheet Overview
| Worksheet | Title | Description |
|------------|--------|-------------|
| WS1 | App Category vs Installs | Logarithmic scale bar chart showing installs per category |
| WS2 | Rating Distribution | Histogram of app ratings |
| WS3 | Top 10 Categories by Reviews | Horizontal bar chart |
| WS4 | Top 10 Apps by Installs | Sorted bar chart |
| WS5 | Free vs Paid Apps by Category | Grouped bar chart |
| WS6 | Installs vs Reviews | Correlation bubble chart |
| WS7 | Free vs Paid App Share | Pie chart |
| WS8 | Apps Updated per Year | Line chart showing updates trend |
| WS9 | App Size vs Installs | Scatter plot showing relationship |
| WS10 | App Type Distribution | Pie chart |
| WS11 | Average Rating per Category | Bar chart |
| WS12 | Revenue Potential by Category | Bar/Tree chart showing potential earnings |

### Dashboard Layout
- **Row 1–2:** KPIs (Total Apps, Total Installs, Average Rating, Revenue Potential)
- **Row 3–4:** Top visual charts (Category analysis, Free vs Paid trends, Ratings, Revenue)
- Clean, interactive layout with filters for **Category** and **App Type**.

## 🏆 KPIs
| KPI | Description | Calculation |
|------|--------------|--------------|
| Total Apps | Number of distinct apps | COUNTD([App]) |
| Total Installs | Sum of installs | SUM([Installs_Clean]) |
| Average Rating | Mean rating | AVG([Rating]) |
| Revenue Potential | Sum of revenue estimate | SUM([Revenue_Potential]) |

## 🖼️ Sample Visuals
- Top Categories by Installs
- Rating Distribution
- Free vs Paid Apps
- Update Trend Over Time

## 🚀 Tools & Technologies
- **Python (Pandas, NumPy, Matplotlib)** – Data Cleaning & Processing
- **Tableau Public** – Dashboard & Visualization
- **Google Colab** – Notebook Environment

## 🔗 Tableau Public Link
[👉 View Interactive Dashboard](#)

## 📁 Repository Structure
```
GooglePlayStore-Dashboard/
│
├── data/
│   └── googleplaystore_cleaned.csv
│
├── notebooks/
│   └── googleplaystore_preprocessing.ipynb
│
├── tableau/
│   └── GooglePlayStore_Dashboard.twbx
│
├── images/
│   └── dashboard_preview.png
│
└── README.md
```

## 💡 Insights Gained
- Communication apps dominate installs but not necessarily ratings.
- Paid apps represent a small portion yet contribute significantly to revenue potential.
- Frequent updates correlate with higher ratings.
- Certain categories like **Finance** and **Education** show high monetization potential.

## ✍️ Author
**Shikhar Kumar**  
📅 Created: October 2025  
🔗 Tableau Public | GitHub | LinkedIn
