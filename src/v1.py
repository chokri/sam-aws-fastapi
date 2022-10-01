from fastapi import APIRouter
# from starlette.requests import Request
# from utils import check_notification


router = APIRouter()


@router.get("/status", description="This function try to get health status", tags=["status"])
def get_status():
    return {"status": "OK"}
