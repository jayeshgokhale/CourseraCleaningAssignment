## Code Book
1. The Data was divided into train and test. Train had 7352 observations and Test had 2947 observations. Thus the division was roughly 70-30.
2. The observations pertained to 30 "subjects". I believe these subjects are individuals: human.
3. For each subject, both train and test contained 561 features for each observation and one target variable.
4. The target variable pertained to an activity amongst 6 possible activities like WALKING, SITTING, STANDING etc.
5. As per requirements of the problem, the train and test data were merged together.
6. The activity codes were replaced with activity names.
7. The features which pertained to mean and std deviation were short listed and rest were excluded.
8. An aggregate mean of every such mean/std across all subjects and activity was taken and a new dataset obtained.
9. Such dataset was stored in a separate file.

