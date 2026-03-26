import os
from sqlalchemy import create_engine
from dotenv import load_dotenv

load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")
print(f"Connecting to: {DATABASE_URL}")

try:
    engine = create_engine(DATABASE_URL)
    with engine.connect() as connection:
        print("Successfully connected to Supabase!")
        from sqlalchemy import text
        result = connection.execute(text("SELECT 1"))
        print(f"Test query result: {result.fetchone()}")
except Exception as e:
    print(f"Connection failed: {e}")
