🏦 Banking Data Analytics Dashboard:
-------------------------------------
Automated Customer, Loan & Transaction Insights using MySQL & Python

📌 Project Overview:
--------------------
This project is an end-to-end Banking Analytics Dashboard designed to analyze customer demographics, loan performance, and transaction behavior using MySQL stored procedures and Python visualizations.

The dashboard integrates:
-------------------------
Customer profiling
Loan status and interest analysis
Transaction trends and high-value payments
Combined financial performance metrics
The final solution outputs a 12-chart automated dashboard that enables business users to gain actionable insights for decision-making.

🎯 Objectives:
--------------
Analyze banking data across Customers, Loans, and Transactions
Build reusable stored procedures in MySQL for complex analytics
Connect database to Python via mysql-connector
Automate insights with Matplotlib & Seaborn visualizations
Build a dashboard with 12 professional KPI charts
Provide strategic recommendations for the banking domain

🛠️ Tools & Technologies:
------------------------
Category	Technologies Used
Database	MySQL 8.0
Backend	SQL Stored Procedures
Programming	Python
Data Handling	Pandas
Visualization	Matplotlib, Seaborn
Connectivity	mysql-connector-python
IDE	Jupyter Notebook / VS Code
🧱 Database Design
Entities & Relationships
CUSTOMERS (customer_id PK)
        |
        | 1-to-Many
        |
LOANS (loan_id PK, customer_id FK)
        |
CUSTOMERS (customer_id PK)
        |
        | 1-to-Many
        |
TRANSACTIONS (transaction_id PK, customer_id FK)

Table Structure:
CUSTOMERS TABLE
---------------
customer_id (PK)
full_name
gender
age
city
income
account_type

LOANS TABLE:
-----------
loan_id (PK)
customer_id (FK → customers.customer_id)
loan_type
loan_amount
interest_rate
status

TRANSACTIONS TABLE:
------------------
transaction_id (PK)
customer_id (FK → customers.customer_id)
transaction_type
amount
transaction_date

🔧 Data Processing:
-------------------
Data cleaning and formatting is performed using Python Pandas:
Data type corrections (dates, numeric values)
Missing value handling
Income, transaction, and loan amount normalization
Monthly date aggregation for trends
This step ensures accurate and consistent analytical outcomes.

⚙️ Stored Procedures (Core Analytics):
--------------------------------------
📊 1) Customer Analytics
-------------------------
Procedure	Purpose
total_customers_by_gender_account(IN acc_type, OUT total_count)	Customers grouped by gender and account type
high_income_customers(IN P_income)	Filters premium/high-income customers
customers_by_age_group()	Age-group segmentation
top_5_locations()	City-wise customer concentration
most_popular_account_type()	Identifies most common account type

💳 2) Loan Analytics
---------------------
Procedure	Purpose
count_loans_by_status(IN loan_type, OUT total)	Loan status counts per type
total_loan_amount_by_type()	Total disbursed amount by loan category
avg_interest_rate_by_type()	Calculates average interest per loan type
customers_with_multiple_loans()	Multi-loan customer detection
loan_performance_summary()	Closed vs Defaulted loan performance

💸 3) Transaction Analytics
----------------------------
Procedure	Purpose
total_avg_transaction_per_customer(IN months, OUT overall_avg)	Per-customer totals and averages
top_10_customers_last6months()	Transaction leaders
most_frequent_transaction_type()	Most common transaction type
monthly_transaction_trends()	Month-wise volume & value trends
high_value_transactions()	Transactions > ₹50,000

🔗 4) Combined Analytics
-------------------------
Procedure	Purpose
topn_customers_activity(IN N)	Highest overall financial customers
active_loan_recent_transactions(IN status, OUT count)	Loan + transaction activity linking
top_cities_by_financial_activity()	High-value cities
inactive_loan_customers(IN months)	EMI risk customers

📊 Dashboard Visualizations (12 Charts)
----------------------------------------
The final dashboard automatically renders:
Customers by Gender & Account Type
Top 5 Cities by customers
Customers by Age Groups
Loan Status Distribution by loan type
Total Loan Amount by loan type
Average Interest Rate by loan type
Loan Performance Summary (Closed vs Defaulted)
Most Frequent Transaction Type
Monthly Transaction Trends (Year-wise colored lines)
Top Cities by Combined Loan + Transaction Value
High-Value Transactions grouped by Type
Top N Customers by Overall Banking Activity

All visuals:
------------
Implement dark theme
Use multi-palette styling
Feature external legends for clarity
Auto-scale based on dataset size
▶️ How To Run
✅ Setup
pip install mysql-connector-python pandas matplotlib seaborn
✅ Run Dashboard
python banking_dashboard.py
Ensure MySQL is running and stored procedures are already created.

📈 Example Insights:
---------------------
Most customers clustered in select cities → targeted branch marketing needed.
Credit risk visible where transaction inactivity correlates with loan defaults.
Certain loan types generate higher interest revenue.
Premium customers contribute majority of high-value transactions.
Seasonal trends indicate best timing for promotional campaigns.

🧾 Business Recommendations:
----------------------------
Target customers by age and income for personalized offers.
Enhance loan risk scoring to minimize default exposure.
Build loyalty programs for high-value customers.
Reactivate dormant customers linked to loan accounts.
Use transaction seasonality to plan promotions.
Deploy live dashboards for leadership reporting.

🏁 Project Outcomes:
--------------------
12 fully automated business intelligence visuals
Reusable SQL & analytics layer
Improved risk detection strategies
Customer segmentation models
Revenue opportunity identification

📚 Skills Demonstrated:
------------------------
SQL stored procedure design
MySQL-Python integration
Financial dataset analysis
Data cleaning with Pandas
Business data visualization
Dashboard design principles
Insight presentation & reporting

