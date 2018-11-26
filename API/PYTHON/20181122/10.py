import mysql.connector

mydb = mysql.connector.connect(
    host="localhost",
    user="admin",
    passwd="dxinfo*dxinfo"
)

mycursor = mydb.cursor()

mycursor.execute("SHOW DATABASES")
print(mycursor.fetchall())
# print(dir(mycursor))
