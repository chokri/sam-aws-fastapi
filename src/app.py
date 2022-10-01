import os
from fastapi import FastAPI
from mangum import Mangum
from starlette.datastructures import CommaSeparatedStrings
import os
from v1 import router


ALLOWED_HOSTS = CommaSeparatedStrings(os.getenv("ALLOWED_HOSTS", ""))
API_V1_STR = "/api/v1"
PROJECT_NAME = "FastAPI-example"


STAGE = os.environ.get('STAGE', None)
ROOT_PATH = f"/{STAGE}" if STAGE else "/"

PROJECT_DESCRIPTION = """
FastAPI-example 🚀

## Description
Lambda Example to make RestFull Api using FastAPI in AWS Lambda
"""

app = FastAPI(
    title=PROJECT_NAME,
    description=PROJECT_DESCRIPTION,
    root_path=ROOT_PATH,
    version="0.0.1"
)

app.include_router(router, prefix=API_V1_STR)


handler = Mangum(app)
