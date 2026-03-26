import os
import traceback
from sqlalchemy import create_engine
from dotenv import load_dotenv

load_dotenv()
url = os.environ.get("DATABASE_URL")
try:
    engine = create_engine(url)
    with engine.connect() as conn:
        with open("db_error.txt", "w") as f:
            f.write("Connected successfully!")
except Exception as e:
    with open("db_error.txt", "w") as f:
        f.write(traceback.format_exc())
