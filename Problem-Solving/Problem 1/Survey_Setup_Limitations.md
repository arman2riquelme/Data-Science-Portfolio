## Problem Description

Blue, a workplace survey solution, is used to conduct semester faculty surveys, evaluating courses and instructors. While course and instructor data are automatically refreshed via an SQL connection with Cognos for data integrity, the surveys are selective: out of approximately 1,100 courses, only about 400 are evaluated each semester, with some courses having multiple instructors.

Currently, Blue does not support importing a custom list to populate a project. While a temporary dataset could be a future solution, and API integration was explored, Blue’s API only supports querying project data, not importing data into one.

This limitation requires courses to be manually added to the project, one by one, using either their CRN (Course Reference Number) or description, until the project is fully populated. Additionally, while the internal system assigns CRNs to all courses, Blue uses a different identifier for cross-listed courses, composed of the `Course` (5 alphanumeric characters) and `Section` (3 alphanumeric characters).

### Additional Challenges

#### Visually Exhausting Process
When searching for CRNs, Blue returns too many results if a more specific approach is not used. This makes it visually exhausting to identify the classes you need.

#### Cross-listed Courses Add Complexity
Courses with `Cross-list` do not have a `CRN`, meaning you cannot use that field as a direct reference. This adds another layer of complexity to the process.

---
## Solution

## Why Use Prefixes?

The use of prefixes emerged as a practical solution to overcome the system's limitations:

### Efficient Grouping
- CRNs are composed of 5 digits, where the first 3 or 4 digits often represent a shared root (e.g., `11377`, `11378`, and `11371` share the same 4-digit root `1137` and 3-digit root `113`).
- By grouping CRNs based on these prefixes, the number of results returned by Blue during searches is significantly reduced.
- This method allows users to focus on the last digit of each CRN when navigating through the search results, making the process faster and less visually demanding.

### Prioritizing the 4-Digit Prefix
- While 3-digit prefixes were initially tested, the 4-digit prefix proved to be more effective in reducing the number of clusters (groups of results).
- Fewer clusters allowed for quicker navigation and improved efficiency when identifying the required courses.

### Visual Strategy in Blue
- By using 4-digit prefixes, Blue returns a smaller and more manageable set of CRNs. This approach enables users to quickly identify the required courses by concentrating only on the last digit of each CRN, which reduces visual fatigue during the selection process.

### Flexibility
- This approach works for both types of courses:
  - Courses with `CRN` are grouped and prioritized by their prefixes.
  - Cross-listed courses, which lack a `CRN`, use unique identifiers based on their `Course` and `Section` fields, ensuring consistency across different data types.

---

## Outcome

This strategy, while not the most advanced, proved to be effective in addressing the limitations of the Blue system. It allowed for efficient data entry in a single session with minimal visual fatigue, showcasing a practical and adaptable problem-solving approach.

## Verification Data

To ensure that only the requested courses and instructors were entered into the project, a temporary ID system was created for cross-referencing and validation. This temporary ID helped compare the entries in Blue with the original list provided. The structure of the temporary ID was as follows:

- **For CRN-based Courses**: `CRN + First Name + Last Name`

This approach allowed for quick comparisons and ensured that the data entered into Blue matched the requested courses and instructors, maintaining data integrity and minimizing errors.

---

### Addressing Cross-listed Courses

Cross-listed courses in Blue do not have a CRN, meaning they must be searched manually by course name. During the process, it became apparent that extracting the alphanumeric course identifier (e.g., `Course + Section`) and using it as a search term was the only viable solution to locate these courses individually.

To ensure accuracy and consistency, the same temporary ID strategy was applied for cross-listed courses. The structure of the ID was:

- **For Cross-listed Courses**: `Alphanumeric Identifier (Course + Section) + First Name + Last Name`

This ensured that cross-listed courses were accurately entered into the project and could be easily cross-referenced with the provided list of requested courses and instructors.

By using this systematic approach for both CRN-based and cross-listed courses, the process was streamlined, ensuring that all requested data was entered correctly without unnecessary duplication or errors.
