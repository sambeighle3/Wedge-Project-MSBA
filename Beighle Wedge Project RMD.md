
# Applied Data Analytics

## Wedge Project

<!-- I have spent a considerable amount of time on this over the last week and a half. I currently have everything uploaded manually. I would like to get the confirmation I have completed the project at a B level then will try to up it to an A when I have time. --> 

### Task 1

* Files for this task: 
  Wedge Project Part 1.ipnyb 

Loads all data into GBQ data set - did manually for now, but worked on code to do it programmatically.




### Task 2

* Files for this task: 
  Wedge Project Part 2.ipnyb 

code that connects to GBQ and creates a sample of owners




### Task 3

* Files for this task: 
 Wedge Project Part 3.ipnyb 
 Wedge Project Part 3 Python.ipnyb 
code that connects to GBQ and builds a summary of tables. I have written the queries in GBQ, then downloaded them to local device and created database and filled tables. I also made an attemept to do it with Python for practice.



## Query Comparison Results

Fill in the following table with the results from the 
queries contained in `gbq_assessment_query.sql`. You only
need to fill in relative difference on the rows where it applies. 
When calculating relative difference, use the formula 
` (your_results - john_results)/john_results)`. 

The results are exactly the same. I did a manual upload.

|  Query  |  Your Results  |  John's Results | Difference | Rel. Diff | 
|---|---|---|---|---|
| Total Rows  |85760139 | 85760139  |  0 | 0 |
| January 2012 Rows  | 107097  | 1070907  | 0 | 0  |
| October 2012 Rows  |  1042287 |  1042287 |  0 | 0  |
| Month with Fewest  |  December | December  | Yes | NA  |
| Num Rows in Month with Fewest  |  988998 | 988998  | 0 | 0  |
| Month with Most  | April  |  April | Yes | NA  |
| Num Rows in Month with Most  | 1135000  | 1135000  | 0  | 0  |
| Null_TS  | 7123792  | 7123792  |  0 | 0  |
| Null_DT  |  0 |  0 |  0 | 0  |
| Null_Local  |  234843 |  234843 | 0 |  0 |
| Null_CN  |  0 | 0  | 0  |  0 |
| Num 5 on High Volume Cards  | 14987  | 14987  | Yes  | NA  |
| Num Rows for Number 5 |460630|  460630 | 0  | 0 |
| Num Rows for 18736  |  12153 | 12153  |  0 |  0 |
| Product with Most Rows  |  Banana Organic | Banana Organic | Yes | NA  |
| Num Rows for that Product  |  908639 | 908639 | 0  |  0 |
| Product with Fourth-Most Rows  | avocado  | avocado  | Yes | NA  |
| Num Rows for that Product  | 456771  | 456771  |  0 |  0 |
| Num Single Record Products  | 2769  |  2769 |  0 | 0 |
| Year with Highest Portion of Owner Rows  | 2014  | 2014  | Yes | NA |
| Fraction of Rows from Owners in that Year  |  0.7591 | 0.7591  | 0  | 0  |
| Year with Lowest Portion of Owner Rows  |  2011 | 2011  | Yes | NA |
| Fraction of Rows from Owners in that Year  | 0.7372  | 0.7372 | 0  |  0 |

## Reflections

 So far, I have put a lot of work into this and think there is probably some left to do. This has been a really interesting project and has really opened my eyes to data engineering. 
