# CourseraCleaningAssignment
Coursera Cleaning Data Assignment

This assignment does the following - 

1. Load Subjects, X and Y for Train and Test respectively.
2. Load Feature Names for X and Target Values for Y
3. Assign Column Names for X and replace numeric Y values with Target Values (like WALKING, SLEEPING) 
4. Merge Subject, X and Y by Column Binding
5. Merge Train and Test by Row Binding
5. Include only those columns which have mean() or std() in their names along with subject and activityname column
6. Calculate mean of all the feature columns grouped by subject + activityname
7. Store the new dataset in a file
