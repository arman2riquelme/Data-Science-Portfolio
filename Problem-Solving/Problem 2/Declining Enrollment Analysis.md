# Declining Enrollment Analysis: Fixed vs. Variable Divisor

## **Context**
This analysis focused on evaluating the **Average Declining Enrollment** across various programs over a 10-year period (2013–2023). The goal was to assess changes in enrollment and present two distinct methods for calculating average decline. Additionally, the results were transitioned from Excel formulas to M code for improved efficiency and reviewability.

### **Problem Overview**
- **Original Data**:  
  The dataset contained information about student retention across multiple programs for the years 2013–2023.

- **Initial Preparation**:  
  The dataset was reviewed for:  
  - Null or missing data.  
  - Changes in program names over the years.  
  - Errors in data entry.  

- **Year-Over-Year (YOY) Calculations**:  
  Columns were added to calculate:  
  - **Total Start**: The total number of enrolled students for each year.  
  - **YOY Change**: The difference between `Total Start` and the previous year's value.  

- **Previous Challenges**:  
  In the prior year, Excel formulas were used for these calculations, making it cumbersome to review and compare results due to the reliance on the **Query and Connections** panel. Transitioning to M code streamlined the process and enabled better visualization of results.

---

## **The Dilemma: Fixed vs. Variable Divisor**

### **1. Real Declining Enrollment (Variable Divisor)**
**Objective**: Adjust the calculation based on the actual number of years with enrollment declines.

- **Steps**:  
  1. Identify only the negative Year-over-Year (YOY) changes.  
  2. Sum all negative YOY changes over the 10 years.  
  3. Count the years with negative YOY changes.  
  4. Calculate the average by dividing the sum by the count of negative years.  

- **Advantages**:  
  - Reflects the severity of decline accurately.  
  - Accounts only for the years where enrollment truly declined.  

- **Disadvantages**:  
  - Not standardized for programs with different lengths or periods of decline.

---

### **2. Fixed 10-Year Average**
**Objective**: Provide a standardized measure by dividing the total decline over the entire 10-year period.

- **Steps**:  
  1. Identify only the negative YOY changes.  
  2. Sum all negative YOY changes over the 10 years.  
  3. Divide the sum by 10 (fixed divisor).  

- **Advantages**:  
  - Standardized across all programs, regardless of decline patterns.  
  - Easier to compare programs directly.  

- **Disadvantages**:  
  - May overstate decline in programs with fewer negative YOY years.

---

## **Rankings: Highest and Lowest AVG Decline Tables**

To evaluate programs with the most and least significant declines, two additional tables were created using both calculation methods:

### **1. Highest AVG Decline Table**
- **Columns**:  
  - Program Name  
  - Real Declining Enrollment (Variable Divisor)  
  - Fixed Declining Enrollment (10-Year Divisor)  

- **Purpose**:  
  Ranks programs with the highest average decline, highlighting programs that require attention.

### **2. Lowest AVG Decline Table**
- **Columns**:  
  - Program Name  
  - Real Declining Enrollment (Variable Divisor)  
  - Fixed Declining Enrollment (10-Year Divisor)  

- **Purpose**:  
  Identifies programs with the least significant average decline or steady enrollment trends.

---

## **Results Provided**
For each program analyzed, both methods were applied, and the results were summarized in the final report. Key metrics included:  
- **Program Name**: Identifies the program analyzed.  
- **Real Declining Enrollment**: Calculated using the variable divisor.  
- **Fixed Declining Enrollment**: Calculated using the fixed 10-year divisor.  
- **Sum of YOY Negative Changes**: A reference metric included for transparency.

---

## **Conclusion**
The decision between the two methods was left to the discretion of the supervisor, with both calculations presented clearly to highlight the strengths and limitations of each approach. Transitioning from Excel to M code allowed for more efficient processing and reduced complexity in reviewing and comparing data.
