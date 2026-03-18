<div align="center">

# 🎣🏆 World Cup Angling Championship Database

### Data Modelling • SQL (3NF) • AI vs Human System Design

[![SQL](https://img.shields.io/badge/SQL-3NF-blue?style=flat\&logo=mysql\&logoColor=white)](my-own-solution/my%20own.sql)
[![AI](https://img.shields.io/badge/AI-ChatGPT-orange?style=flat\&logo=openai)](AI%20prompt.docx)
[![Stars](https://img.shields.io/github/stars/Jiyun-data/angling-championship-database?style=social)](https://github.com/Jiyun-data/angling-championship-database)

<br>

**🔄 Data Pipeline Flow**
Entrants → Fish Catches → Qualifiers → Finals

</div>

---

## 🚀 Project Overview

> 💡 **Objective:** Design a **production-ready relational database** and evaluate the effectiveness of AI-generated schema designs.

This project combines **data modelling, SQL, and AI evaluation** to:

* Compare **AI-generated vs human-designed schemas**
* Identify weaknesses in **AI reasoning and data structure design**
* Build a **fully optimised (3NF) database** aligned with real-world requirements

👉 **Outcome:** A scalable, high-integrity database supporting competition operations and analytics

---

## 🧠 AI Evaluation & Insights

This project critically assesses how AI performs in structured data design tasks.

### 🔍 Key Findings

* 🤖 AI generates **syntactically correct but logically incomplete schemas**
* ⚠️ Fails to capture **implicit business rules**
* ⚠️ Struggles with **edge cases and constraints**
* ⚠️ Limited optimisation for **query performance and reporting**

### ✅ Human Improvements

* Implemented **normalisation to 3NF**
* Translated business logic into **relational constraints**
* Designed for **analytical queries and reporting**
* Handled **edge cases (lottery eligibility, scheduling conflicts)**

👉 **Insight:** AI is effective for rapid prototyping, but requires human validation for **data integrity and production use**

---

## 💼 Data & Business Value

<div align="center">

| Data Challenge         | Solution Implemented        |
| ---------------------- | --------------------------- |
| Redundant data         | Normalised schema (3NF)     |
| Inconsistent rules     | Constraint-driven logic     |
| Scheduling conflicts   | Structured allocation model |
| Reporting inefficiency | Query-optimised design      |

</div>

---

## ⚙️ Data Model Highlights

### 🧩 Entity Design

* Entrants, Sections, FishCatch, Qualifiers, BoatAllocation
* Lookup tables for **Province & County**

### 🔗 Relationships

* Fully defined **primary & foreign keys**
* **CASCADE rules** for referential integrity

### 📊 Analytics-Ready Design

* Structured for:

  * Daily catch reports
  * Ranking calculations
  * Performance tracking

### 🚤 Constraint Handling

* Prevents **double booking**
* Enforces **competition eligibility rules**

---

## 🖼️🏆 Production 3NF ERD
<div align="center">
<img src="https://raw.githubusercontent.com/Jiyun-data/angling-championship-database/main/my%20own%20solution/ERD.png" width="950">
<br><br>
**🎯 My Winning Schema: 3NF • Production Ready • Constraint Complete**
 
</div>



## 🧠 AI vs Human Comparison

<div align="center">

| Dimension           | 🤖 AI Output    | 👩‍💻 Final Solution     |
| ------------------- | --------------- | ------------------------ |
| Data Modelling      | Basic structure | ✅ Fully normalised (3NF) |
| Business Logic      | Partial         | ✅ Fully implemented      |
| Constraints         | Weak            | ✅ Strong integrity       |
| Edge Case Handling  | Missing         | ✅ Robust                 |
| Analytics Readiness | Limited         | ✅ Optimised              |

</div>

---

## 🧩 Example Schema Component

```sql id="evj4dl"
CREATE TABLE Entrant (
  EntrantID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100),
  Province ENUM('Connacht','Ulster','Leinster','Munster','Outside'),
  EntryStatus ENUM('Entrant','Qualifier','Lottery','Withdrawn')
);
```

---

## 🚀 Quick Start

```bash id="9g5pks"
git clone https://github.com/Jiyun-data/angling-championship-database
cd angling-championship-database
mysql < "my own solution/my own.sql"
DESCRIBE Entrant;
```

---

## 🎯 Key Data Takeaways

- ✔️ **Applied database normalisation (3NF)** to eliminate redundancy
- ✔️ **Translated business rules** into structured data constraints  
- ✔️ **Designed schema optimised** for analytics and reporting
- ✔️ **Evaluated AI limitations** in structured data modelling

👉 **Result:** Robust, scalable database for real-world deployment

---

<div align="center">

👩‍💼 **Jiyun Kim** • Data Analyst Portfolio  
**BComm AI/Data Analytics Graduate**

📍 **Dublin, Leinster, Ireland**  
💼 **[LinkedIn](https://linkedin.com/in/jiyunkim)**  
✉️ **[june.kim566@email.com](mailto:june.kim566@email.com)**  
🌐 **[GitHub](https://github.com/Jiyun-data)**  

**🎯 Skills:** SQL • Power BI • AI Tools • Data Modelling • 3NF Design

[![Footer](https://img.shields.io/badge/Portfolio-Ready-brightgreen?style=flat&logo=gitbook)](https://github.com/Jiyun-data/angling-championship-database)

⭐ **Star Repo** | 🔄 **Fork & Test** | 💬 **Hiring? DM me!**
</div>
