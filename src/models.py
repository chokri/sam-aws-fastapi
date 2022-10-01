from pydantic import BaseModel
# from typing import Optional, List
# from datetime import datetime


class StatusResponse(BaseModel):
	status: str

