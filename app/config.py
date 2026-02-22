import os
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    """Application settings loaded from environment variables."""
    
    # Application settings
    MAX_FILE_SIZE_MB: int = 2

    # Azure OpenAI - API version used by the local lab
    AZURE_OPENAI_BASE_URL: str = os.getenv("AZURE_OPENAI_BASE_URL", "")
    AZURE_OPENAI_MODEL_DEPLOYMENT: str = os.getenv("AZURE_OPENAI_MODEL_DEPLOYMENT", "")
    AZURE_OPENAI_API_VERSION: str = os.getenv("AZURE_OPENAI_API_VERSION", "2024-12-01-preview")

    # Local development only
    AZURE_OPENAI_API_KEY: str = os.getenv("AZURE_OPENAI_API_KEY", "")

    class Config:
        env_file = ".env"
        case_sensitive = False

settings = Settings()
