## **Problem 3: Visualizing Failure Rates Across Categories**

## **Context**

The goal of this project was to analyze and visualize the failure rates of students across various categories to identify common patterns. While numerical data provided insights, the challenge was to create a meaningful visualization that could help decision-makers interpret the information intuitively.

## Dataset Preparation
The dataset was enriched with indicators, metrics, and submetrics to enable deeper analysis. These were grouped into three primary categories:

**Demographic Insights: Focused on residency, age, gender, and similar factors.**
**Educational Engagement: Examined course delivery modes, semester-based trends, and program schedules.**
**Background and Support: Analyzed external support mechanisms, funding sources, and first-generation student status.**
Key metrics included:

Mean failure rates for each metric within a category.
Overall mean failure rates for each category:
**Demographic Insights: 2.58**
**Educational Engagement: 2.06**
**Background and Support: 2.60**

## **The Challenge**
I was requested a graphical representation of the data, but the exact requirements were unclear. The initial request referenced a "bar chart with shading," but upon discussion, it became evident that the graph needed to incorporate more dimensions and provide a broader understanding of why students were failing.

## **Solution: Iterative Development of the Graph with Python in a Jupyter Notebook**
The process involved multiple iterations to refine the visualization:

### **Version 1**
A simple graph was created to represent the **overall mean failure rates** across the three categories. While functional, it lacked depth and didn't reflect the underlying metrics or submetrics within each category.

### **Version 2**
The second iteration added more context by highlighting the **mean failure rates** for each metric within the categories. This provided greater detail but still fell short of visually emphasizing the relationships between metrics and categories.

### **Version 3 (Final Version)**
The final version integrated:
- **Overall mean failure rates** for each category.
- **Mean failure rates for each submetric**, annotated directly on the graph.
- **Shading** to emphasize trends and relationships across categories.

This approach provided a richer visualization that aligned with the supervisor's expectations and highlighted key insights effectively.

---

## **Final Note**
The complete code, including all iterations, is documented in the file **"Fail Report Updated March 6th_Github.ipynb"** under the **Statistics** folder. This file contains:
1. The full dataset preparation process.  
2. Code for all three graph versions.  
3. An explanation of how the dataset was enriched and the metrics calculated.  

Additionally, all data used in this project was anonymized to protect the privacy of individuals.
