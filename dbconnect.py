import MySQLdb

def connection():
    # Edited out actual values
    conn = MySQLdb.connect(host='localhost',
                           user='root',
                           passwd='mysql',
                           db = 'projeto')
    c = conn.cursor()

    return c, conn