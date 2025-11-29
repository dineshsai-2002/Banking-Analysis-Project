📊 Banking Analytics Dashboard
End-to-End Data Analytics Project using MySQL, Python, and Pandas

📘 Project Overview:
This project is a complete Banking Analytics System that integrates MySQL + Python + Pandas + Matplotlib + Seaborn to analyze customer, loan, and transaction data. It automates: Data Cleaning using Pandas Data Storage using MySQL Analytical Processing using Stored Procedures Visualization using Python Dashboards The dashboard provides 12 major insights related to customer behavior, loan performance, and transaction activity.

🚀 Features:
🔹 Data Cleaning (Pandas) Handle missing values Remove duplicates Standardize formats (dates, numbers) Normalize categorical data Create age groups, month columns, etc.

🔹 MySQL Database:
Tables: customers loans transactions Linked through customer_id.

🔹 Stored Procedures:
Includes procedures for: Loan status summary High-income customers Monthly transaction trends Average income comparison Top 10 customers High-value transactions Combined financial activity

🔹 Python Dashboard:
Uses: mysql.connector Pandas Matplotlib Seaborn Provides interactive menu-based dashboards for: Customer Analytics Loan Analytics Transaction Analytics Combined Banking Analytics

🧹 Tech Stack:
LayerToolsData CleaningPandasDatabaseMySQLLogicStored ProceduresVisualizationMatplotlib, SeabornBackendPython 📂 Project Structure 📁 Banking-Analytics-Dashboard │── README.md │── customers.csv │── loans.csv │── transactions.csv │── data_cleaning.ipynb │── mysql_stored_procedures.sql │── banking_dashboard_customers.py │── banking_dashboard_loans.py │── banking_dashboard_transactions.py │── banking_dashboard_combined.py │── visualization_dashboard.py

📊 12 Key Visualizations:
Customers by Gender & Account Type Customers by Age Group Top 5 Cities by Customers Loan Status Distribution Total Loan Amount by Loan Type Average Interest Rate by Loan Type Loan Performance (Closed vs Defaulted) Customers with Multiple Loans Monthly Transaction Trends Most Frequent Transaction Type High-Value Transactions (> ₹50,000) Top Cities by Combined Loan & Transaction Value

🔧 Installation:
1️⃣ Clone Repo git clone https://github.com/your-username/Banking-Analytics-Dashboard.git cd Banking-Analytics-Dashboard

2️⃣ Install Python Libraries:
pip install pandas mysql-connector-python matplotlib seaborn numpy

3️⃣ Create Database:
CREATE DATABASE Banking;

4️⃣ Import Stored Procedures:
SOURCE mysql_stored_procedures.sql;

5️⃣ Update DB Credentials:
In each Python file: db_config = { "host": "localhost", "user": "root", "password": "14032002kD@", "database": "Banking" }

▶️ Run the Dashboards:
Customer Analytics python banking_dashboard_customers.py

Loan Analytics:
python banking_dashboard_loans.py

Transaction Analytics:
python banking_dashboard_transactions.py Combined Analytics python banking_dashboard_combined.py

📈 Insights Generated:
46–60 age group dominates customer base Education & Home loans have the highest disbursement Deposits are the most frequent transactions High-value transactions concentrated in metro cities Loan defaulters often belong to lower-income segments

🏁 Project Outcomes:
Automated analytics workflow Faster reporting with stored procedures Clean, visual dashboards Business insights for decision-making Ready for ML model integration

🧭 Future Improvements:
Predictive ML models (loan default, churn) Real-time dashboards (Streamlit) Fraud detection module API integration for live banking data

🤝 Contributions:
Contributions and suggestions are welcome! Please open an issue or submit a pull request.

⭐ Support:
If you like this project, please star the repository on GitHub ⭐
