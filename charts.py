import pandas as pd
import matplotlib.pyplot as plt

# Read the CSV file
df = pd.read_csv('current.csv')

# Convert Chapter to a string to handle it as a categorical variable
df['Chapter'] = df['Chapter'].astype(str)

# Create a Line Graph for Readtime
plt.figure()
plt.plot(df['Chapter'], df['Readtime'], marker='o', color='blue')
plt.title('Chapter vs Readtime and Rating')
plt.xlabel('Chapter')
plt.ylabel('Readtime (Minutes)', color='blue')
plt.tick_params(axis='y', labelcolor='blue')

# Create a second y-axis for Ratings
ax2 = plt.twinx()
ax2.plot(df['Chapter'], df['Rating'], marker='o', color='green')
ax2.set_ylabel('Rating', color='green')  
ax2.tick_params(axis='y', labelcolor='green')

# Set the limit for the rating axis
ax2.set_ylim(0, 10)

plt.savefig('output.png')
plt.close()

