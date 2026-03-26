import os
import psycopg2
from dotenv import load_dotenv

load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")
# Remove 'postgresql://' prefix for psycopg2.connect if using it directly, but let's just use the URL
print(f"Testing connection to Supabase...")

try:
    # Try with sslmode=require if it's not already in the URL
    if "sslmode" not in DATABASE_URL:
        if "?" in DATABASE_URL:
            DATABASE_URL += "&sslmode=require"
        else:
            DATABASE_URL += "?sslmode=require"
    
    conn = psycopg2.connect(DATABASE_URL)
    print("Successfully connected using psycopg2 directly!")
    conn.close()
except Exception as e:
    print(f"Direct connection failed: {e}")
