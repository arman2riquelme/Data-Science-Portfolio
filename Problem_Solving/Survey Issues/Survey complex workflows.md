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
- Grouping by 3 or 4-digit prefixes significantly reduces the number of results returned by Blue in each search.
- This method streamlines the process by allowing the focus to shift to the last digits of each CRN, instead of reviewing the entire number.

### Prioritizing the 4-Digit Prefix
- Initial tests with 3-digit prefixes were useful, but 4-digit prefixes proved to be more effective by creating fewer groups (clusters).
- Fewer groups allowed for faster navigation and improved efficiency in identifying the required courses.

### Visual Strategy in Blue
- Using 4-digit prefixes resulted in a more manageable set of CRNs. This made it easier to quickly identify the required courses by focusing on the last digit, reducing visual fatigue during the selection process.

### Flexibility
- This approach adapts to both courses with `CRN` and those with `Cross-list`. By combining fields such as `Course` and `Section`, unique identifiers like `Curso_Simple` or `Curso_Completo` were created to handle cross-listed courses effectively.

---

## Outcome

Although not the most sophisticated solution, this approach successfully addressed the problem. It allowed for efficient data entry in a single session while minimizing visual fatigue.
